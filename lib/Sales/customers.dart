import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:cyllo_mobile/isarModel/customerViewModel.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../Leads/leads.dart';
import '../getUserImage.dart';
import '../main.dart';
import 'Views/customerView.dart';

class Customers extends StatefulWidget {
  const Customers({super.key});

  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  OdooClient? client;
  bool isLoading = false;
  List<dynamic> customers = [];
  Map<int, String> categoryMap = {};
  Map<int, String> categoryPathMap = {};
  Map<int, String> countryMap = {};
  Map<int, List<dynamic>> customerActivities = {};
  List<dynamic> activityTypes = [];

  // Filter related variables
  Set<String> selectedFilters = {};
  String? selectedCountry;
  int selectedView = 0;

  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;


  @override
  void initState() {
    super.initState();
    loadFromIsar();
    initializeOdooClient();
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (searchController.text.isNotEmpty) {
        _searchCustomers(searchController.text);
      } else {
        fetchCustomerData();
      }
    });
  }

  Future<void> _searchCustomers(String query) async {
    if (client == null) return;

    setState(() => isLoading = true);
    try {
      List<dynamic> domain = [
        '|',
        '|',
        '|',
        '|',
        ['complete_name', 'ilike', query],
        ['ref', 'ilike', query],
        ['email', 'ilike', query],
        ['vat', 'ilike', query],
        ['company_registry', 'ilike', query],
      ];


      final filters = getFilters();
      if (selectedFilters.isNotEmpty) {
        for (var filterKey in selectedFilters) {
          domain.addAll(filters[filterKey]!['domain']);
        }
      }

      final response = await client!.callKw({
        'model': 'res.partner',
        'method': 'search_read',
        'args': [domain],
        'kwargs': {
          'fields': [
            'id',
            'name',
            'email',
            'phone',
            'city',
            'state_id',
            'country_id',
            'category_id',
            'image_128',
            'company_type',
            'company_id',
            'commercial_partner_id',
            'function',
            'is_company',
            'customer_rank',
            'supplier_rank',
            'active',
          ],
        },
      });

      if (mounted) {
        setState(() {
          customers = response ?? [];
        });
        await fetchCategoryData();
        await fetchActivityData();
        log("Searched customers: ${customers.length}");
      }
    } catch (e) {
      log("Error searching customers: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error searching customers: $e")),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  Future<bool> ensureAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    final baseUrl = prefs.getString("urldata") ?? "";
    final dbName = prefs.getString("selectedDatabase") ?? "";
    final userLogin = prefs.getString("userLogin") ?? "";
    final userPassword = prefs.getString("password") ?? "";

    if (baseUrl.isEmpty || dbName.isEmpty || userLogin.isEmpty || userPassword.isEmpty) {
      log("Missing connection details");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Missing connection details")),
        );
      }
      return false;
    }

    if (client == null) {
      client = OdooClient(baseUrl);
    }

    try {
      await client!.authenticate(dbName, userLogin, userPassword);
      log("Odoo client authenticated successfully");
      return true;
    } catch (e) {
      log("Odoo Authentication Failed: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to authenticate with Odoo: $e")),
        );
      }
      return false;
    }
  }

  Future<void> initializeOdooClient() async {
    setState(() => isLoading = true);
    if (await ensureAuthenticated()) {
      try {
        await fetchCustomerData(savetoIsar: true);
        await fetchCategoryData(savetoIsar: true);
        await fetchActivityTypes();
        await fetchActivityData(savetoIsar: true);
      } catch (e) {
        log("Error during initialization: $e");
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Initialization failed: $e")),
          );
        }
      }
    }
    if (mounted) {
      setState(() => isLoading = false);
    }
  }

  Widget ChartSelection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: 185,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.grey.shade200,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedView = 0;
                  });
                },
                icon: Icon(
                  Icons.bar_chart_rounded,
                  color: selectedView == 0 ? Color(0xFF9EA700) : Colors.black,
                ),
              ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedView = 1;
                  });
                },
                icon: Icon(
                  Icons.view_list_rounded,
                  color: selectedView == 1 ? Color(0xFF9EA700) : Colors.black,
                ),
              ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedView = 2;
                  });
                },
                icon: Icon(
                  Icons.access_time,
                  color: selectedView == 2 ? Color(0xFF9EA700) : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void>  fetchActivityTypes() async {
    if (client == null) return;

    try {
      final response = await client!.callKw({
        'model': 'mail.activity.type',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {
          'fields': ['id', 'name'],
        },
      });

      if (response != null && mounted) {
        setState(() {
          activityTypes = response;
        });
        log("Fetched activity types: ${activityTypes.length}");
        log("Sample activity type: ${activityTypes.isNotEmpty ? activityTypes[0] : 'No activity types'}");
      }
    } catch (e) {
      log("Error fetching activity types: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error fetching activity types: $e")),
        );
      }
    }
  }

  Future<void> fetchActivityData({bool savetoIsar = false}) async {
    // Try loading from Isar first
    final activitiesFromIsar = await isar.activitys.where().findAll();
    if (activitiesFromIsar.isNotEmpty && !savetoIsar) {
      Map<int, List<dynamic>> tempActivities = {};
      for (var activity in activitiesFromIsar) {
        tempActivities.putIfAbsent(activity.customerId, () => []).add({
          'res_id': activity.customerId,
          'activity_type_id': activity.activityTypeId != null && activity.activityTypeName != null
              ? [activity.activityTypeId, activity.activityTypeName]
              : null,
          'date_deadline': activity.dateDeadline,
          'summary': activity.summary,
          'user_id': activity.userId != null && activity.userName != null
              ? [activity.userId, activity.userName]
              : null,
          'user_image': activity.userImage,
        });
      }
      setState(() {
        customerActivities = tempActivities;
      });
      log("Loaded activities for ${customerActivities.length} customers from Isar");
    }

    // Fetch from Odoo if needed
    if (client == null) return;

    try {
      List<int> customerIds = customers.map((customer) => customer['id'] as int).toList();
      if (customerIds.isEmpty) {
        log("No customer IDs available for activity fetch");
        return;
      }

      final response = await client!.callKw({
        'model': 'mail.activity',
        'method': 'search_read',
        'args': [
          [
            ['res_id', 'in', customerIds],
            ['res_model', '=', 'res.partner'],
          ]
        ],
        'kwargs': {
          'fields': [
            'id',
            'res_id',
            'activity_type_id',
            'date_deadline',
            'summary',
            'user_id',
          ],
        },
      });

      log("Raw activity response: $response");

      if (response is! List) {
        throw FormatException("Unexpected response format: $response");
      }

      if (response != null && mounted) {
        Map<int, List<dynamic>> tempActivities = {};
        Set<int> userIds = {};

        for (var activity in response) {
          int customerId = activity['res_id'];
          tempActivities.putIfAbsent(customerId, () => []).add(activity);
          if (activity['user_id'] != null &&
              activity['user_id'] is List &&
              activity['user_id'].length > 0) {
            userIds.add(activity['user_id'][0]);
          }
        }

        // Fetch user images
        if (userIds.isNotEmpty) {
          final userResponse = await client!.callKw({
            'model': 'res.users',
            'method': 'search_read',
            'args': [
              [
                ['id', 'in', userIds.toList()]
              ]
            ],
            'kwargs': {
              'fields': ['id', 'name', 'image_128'],
            },
          });

          log("Raw user response: $userResponse");

          if (userResponse != null) {
            Map<int, String> userImageMap = {};
            for (var user in userResponse) {
              if (user['image_128'] != null && user['image_128'] is String && user['image_128'].isNotEmpty) {
                userImageMap[user['id']] = user['image_128'];
              }
            }

            for (var activities in tempActivities.values) {
              for (var activity in activities) {
                if (activity['user_id'] != null &&
                    activity['user_id'] is List &&
                    activity['user_id'].length > 0) {
                  int userId = activity['user_id'][0];
                  if (userImageMap.containsKey(userId)) {
                    activity['user_image'] = userImageMap[userId];
                  }
                }
              }
            }
          }
        }

        // Save to Isar
        if (savetoIsar) {
          await isar.writeTxn(() async {
            await isar.activitys.clear(); // Clear existing activities
            for (var activity in response) {
              try {
                final activityModel = Activity()
                  ..odooId = activity['id']
                  ..customerId = activity['res_id']
                  ..activityTypeId = activity['activity_type_id'] is List && activity['activity_type_id'].isNotEmpty
                      ? activity['activity_type_id'][0]
                      : null
                  ..activityTypeName = activity['activity_type_id'] is List && activity['activity_type_id'].length > 1
                      ? activity['activity_type_id'][1]?.toString()
                      : null
                  ..dateDeadline = activity['date_deadline']?.toString()
                  ..summary = activity['summary']?.toString()
                  ..userId = activity['user_id'] is List && activity['user_id'].isNotEmpty
                      ? activity['user_id'][0]
                      : null
                  ..userName = activity['user_id'] is List && activity['user_id'].length > 1
                      ? activity['user_id'][1]?.toString()
                      : null
                  ..userImage = activity['user_image']?.toString();

                await isar.activitys.put(activityModel);
              } catch (e) {
                log("Error saving activity ID ${activity['id']}: $e");
              }
            }
          });
          log("Saved ${response.length} activities to Isar");
        }

        setState(() {
          customerActivities = tempActivities;
        });
        log("Fetched activities for ${customerActivities.length} customers");
      }
    } catch (e) {
      log("Error fetching activities: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error fetching activities: $e")),
        );
      }
      // Fall back to Isar data if available
      if (activitiesFromIsar.isNotEmpty) {
        Map<int, List<dynamic>> tempActivities = {};
        for (var activity in activitiesFromIsar) {
          tempActivities.putIfAbsent(activity.customerId, () => []).add({
            'res_id': activity.customerId,
            'activity_type_id': activity.activityTypeId != null && activity.activityTypeName != null
                ? [activity.activityTypeId, activity.activityTypeName]
                : null,
            'date_deadline': activity.dateDeadline,
            'summary': activity.summary,
            'user_id': activity.userId != null && activity.userName != null
                ? [activity.userId, activity.userName]
                : null,
            'user_image': activity.userImage,
          });
        }
        setState(() {
          customerActivities = tempActivities;
        });
        log("Fallback: Loaded activities for ${customerActivities.length} customers from Isar");
      }
    }
  }

  Future<void> fetchCategoryData({bool savetoIsar = false}) async {
    // Try loading from Isar first
    final categoriesFromIsar = await isar.categorys.where().findAll();
    if (categoriesFromIsar.isNotEmpty && !savetoIsar) {
      setState(() {
        categoryMap = {for (var cat in categoriesFromIsar) cat.odooId: cat.name ?? 'Unknown'};
        categoryPathMap = {
          for (var cat in categoriesFromIsar)
            cat.odooId: cat.parentPath?.isNotEmpty ?? false
                ? cat.parentPath!.split('/').where((id) => id.isNotEmpty).map((id) {
              int catId = int.tryParse(id) ?? 0;
              return categoryMap[catId] ?? 'Unknown';
            }).join('/')
                : cat.name ?? 'Unknown'
        };
      });
      log("Loaded ${categoriesFromIsar.length} categories from Isar");
    }

    // Fetch from Odoo if needed
    if (client == null ) return;

    try {
      Set<int> categoryIds = {};
      for (var customer in customers) {
        if (customer['category_id'] != null && customer['category_id'] is List) {
          final categoryList = customer['category_id'] as List;
          for (var category in categoryList) {
            if (category is int) {
              categoryIds.add(category);
            } else if (category is List && category.isNotEmpty && category[0] is int) {
              categoryIds.add(category[0]);
            }
          }
        }
      }

      if (categoryIds.isNotEmpty) {
        final initialResponse = await client!.callKw({
          'model': 'res.partner.category',
          'method': 'search_read',
          'args': [
          [
            ['id', 'in', categoryIds.toList()]
            ]
          ],
          'kwargs': {
            'fields': ['id', 'name', 'parent_path'],
          },
        });

        if (initialResponse != null && mounted) {
          Set<int> allCategoryIds = {...categoryIds};
          for (var category in initialResponse) {
            String parentPath = category['parent_path'] ?? '';
            if (parentPath.isNotEmpty) {
              List<String> pathIds = parentPath.split('/').where((id) => id.isNotEmpty).toList();
              pathIds.forEach((id) => allCategoryIds.add(int.tryParse(id) ?? 0));
            }
          }

          final fullResponse = await client!.callKw({
            'model': 'res.partner.category',
            'method': 'search_read',
            'args': [
              [
                ['id', 'in', allCategoryIds.toList()]
              ]
            ],
            'kwargs': {
              'fields': ['id', 'name', 'parent_path'],
            },
          });

          log("Raw category response: $fullResponse");

          if (fullResponse != null && mounted) {
            Map<int, String> tempCategoryMap = {for (var cat in fullResponse) cat['id']: cat['name']};

            // Save to Isar
            if (savetoIsar) {
              await isar.writeTxn(() async {
                await isar.categorys.clear(); // Clear existing categories
                for (var category in fullResponse) {
                  try {
                    final categoryModel = Category()
                      ..odooId = category['id']
                      ..name = category['name']?.toString()
                      ..parentPath = category['parent_path']?.toString();
                    await isar.categorys.put(categoryModel);
                  } catch (e) {
                    log("Error saving category ID ${category['id']}: $e");
                  }
                }
              });
              log("Saved ${fullResponse.length} categories to Isar");
            }

            setState(() {
              categoryMap = tempCategoryMap;
              for (var category in fullResponse) {
                String parentPath = category['parent_path'] ?? '';
                if (parentPath.isNotEmpty) {
                  List<String> pathIds = parentPath.split('/').where((id) => id.isNotEmpty).toList();
                  List<String> pathNames = pathIds.map((id) {
                    int catId = int.tryParse(id) ?? 0;
                    return tempCategoryMap[catId] ?? 'Unknown';
                  }).toList();
                  categoryPathMap[category['id']] = pathNames.join('/');
                } else {
                  categoryPathMap[category['id']] = category['name'];
                }
              }
            });
            log("Fetched ${fullResponse.length} categories");
          }
        }
      }
    } catch (e) {
      log("Error fetching categories: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error fetching categories: $e")),
        );
      }
      // Fall back to Isar data if available
      if (categoriesFromIsar.isNotEmpty) {
        setState(() {
          categoryMap = {for (var cat in categoriesFromIsar) cat.odooId: cat.name ?? 'Unknown'};
          categoryPathMap = {
            for (var cat in categoriesFromIsar)
              cat.odooId: cat.parentPath?.isNotEmpty ?? false
                  ? cat.parentPath!.split('/').where((id) => id.isNotEmpty).map((id) {
                int catId = int.tryParse(id) ?? 0;
                return categoryMap[catId] ?? 'Unknown';
              }).join('/')
                  : cat.name ?? 'Unknown'
          };
        });
        log("Fallback: Loaded ${categoriesFromIsar.length} categories from Isar");
      }
    }
  }
  Map<String, Map<String, dynamic>> getFilters() {
    return {
      'individuals': {
        'name': 'Individuals',
        'domain': [
          ['is_company', '=', false]
        ]
      },
      'companies': {
        'name': 'Companies',
        'domain': [
          ['is_company', '=', true]
        ]
      },
      'customer_invoice': {
        'name': 'Customer Invoices',
        'domain': [
          ['customer_rank', '>', 0]
        ]
      },
      'vendor_bills': {
        'name': 'Vendor Bills',
        'domain': [
          ['supplier_rank', '>', 0]
        ]
      },
      'archived': {
        'name': 'Archived',
        'domain': [
          ['active', '=', false]
        ]
      },
    };
  }

  void showFilterDialog(BuildContext context) {
    final currentFilters = getFilters();
    Set<String> tempSelectedFilters = Set.from(selectedFilters);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.white,
          title: Text(
            "Select Filters",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[800],
            ),
          ),
          content: StatefulBuilder(
            builder: (context, setDialogState) {
              return Container(
                width: double.maxFinite,
                constraints: BoxConstraints(maxHeight: 300),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: currentFilters.entries.map((entry) {
                      return Card(
                        elevation: 0,
                        color: Colors.grey[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CheckboxListTile(
                          title: Text(
                            entry.value['name'],
                            style: TextStyle(color: Colors.blueGrey[800]),
                          ),
                          value: tempSelectedFilters.contains(entry.key),
                          activeColor: Colors.blue,
                          onChanged: (bool? value) {
                            setDialogState(() {
                              if (value == true) {
                                tempSelectedFilters.add(entry.key);
                              } else {
                                tempSelectedFilters.remove(entry.key);
                              }
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
          actionsPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(foregroundColor: Colors.grey[600]),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedFilters = tempSelectedFilters;
                });
                Navigator.pop(context);
                applyFilters();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF9EA700),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Text("Apply", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Widget iconSelectedView() {
    switch (selectedView) {
      case 0:
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1.5,
              mainAxisSpacing: 12,
            ),
            itemCount: customers.length,
            itemBuilder: (context, index) {
              final customer = customers[index];
              return buildCustomerCard(customer);
            },
          ),
        );

      case 1:
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 1000,
              child: ListView.builder(
                itemCount: customers.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      color: Colors.grey.shade200,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Name',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Phone',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Email',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Salesperson',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Activities',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'City',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Country',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Company',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  final customer = customers[index - 1];
                  bool hasCommercialPartner =
                      customer['commercial_partner_id'] != null &&
                          customer['commercial_partner_id'] is List &&
                          customer['commercial_partner_id'].length > 1 &&
                          customer['commercial_partner_id'][0] !=
                              customer['id'];
                  String commercialPartnerName = hasCommercialPartner
                      ? customer['commercial_partner_id'][1]
                      : '';
                  String? countryName = customer['country_id'] != null &&
                          customer['country_id'] is List &&
                          customer['country_id'].length > 1
                      ? customer['country_id'][1]
                      : null;
                  String salespersonName = customer['user_id'] != null &&
                          customer['user_id'] is List &&
                          customer['user_id'].length > 1
                      ? customer['user_id'][1]
                      : '';

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CustomerView(customerId: customer['id']),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      color:
                          index % 2 == 0 ? Colors.white : Colors.grey.shade100,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              customer['name'] ?? 'Unknown',
                              style: TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              customer['phone']?.toString() ?? '',
                              style: TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              customer['email']?.toString() ?? '',
                              style: TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              salespersonName,
                              style: TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: Icon(Icons.access_time,
                                  size: 16, color: Colors.grey[600]),
                              onPressed: () {
                                // Implement activity action if needed
                              },
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              customer['city']?.toString() ?? '',
                              style: TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              countryName ?? '',
                              style: TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              commercialPartnerName,
                              style: TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      case 2:
        List<dynamic> customersWithActivities = customers
            .where((customer) => customerActivities.containsKey(customer['id']))
            .toList();

        // If no customers have activities, show a message
        if (customersWithActivities.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.event_busy,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  "No Activities Found",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }

        // Dynamically generate columns based on activity types
        List<GridColumn> columns = [
          GridColumn(
            columnName: 'customer',
            label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.centerLeft,
              child: const Text(
                '',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ),
            width: 200,
          ),
        ];

        // Add a column for each activity type
        for (var type in activityTypes) {
          columns.add(
            GridColumn(
              columnName: type['name'],
              label: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Text(
                  type['name'],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ),
              width: 150,
            ),
          );
        }

        return SfDataGrid(
          rowHeight: 60,
          source: CustomerActivityDataSource(customersWithActivities, customerActivities, activityTypes,  context),
          columnWidthMode: ColumnWidthMode.fill,
          gridLinesVisibility: GridLinesVisibility.both,
          headerGridLinesVisibility: GridLinesVisibility.both,
          columns: columns,
        );
      default:
        return Container();
    }
  }

  Future<void> applyFilters() async {
    if (client == null) return;

    setState(() => isLoading = true);
    List<dynamic> domain = [];

    final filters = getFilters();
    bool hasIndividuals = selectedFilters.contains('individuals');
    bool hasCompanies = selectedFilters.contains('companies');
    bool hasCustomerInvoice = selectedFilters.contains('customer_invoice');
    bool hasVendorBills = selectedFilters.contains('vendor_bills');
    bool hasArchived = selectedFilters.contains('archived');

    if (hasIndividuals && hasCompanies) {
      domain.add('|');
      domain.addAll(filters['individuals']!['domain']);
      domain.addAll(filters['companies']!['domain']);
    } else if (hasIndividuals) {
      domain.addAll(filters['individuals']!['domain']);
    } else if (hasCompanies) {
      domain.addAll(filters['companies']!['domain']);
    }

    if (hasCustomerInvoice && hasVendorBills) {
      domain.add('|');
      domain.addAll(filters['customer_invoice']!['domain']);
      domain.addAll(filters['vendor_bills']!['domain']);
    } else if (hasCustomerInvoice) {
      domain.addAll(filters['customer_invoice']!['domain']);
    } else if (hasVendorBills) {
      domain.addAll(filters['vendor_bills']!['domain']);
    }

    if (hasArchived) {
      domain.addAll(filters['archived']!['domain']);
    }

    log("Applying filters with domain: $domain");

    try {
      final response = await client!.callKw({
        'model': 'res.partner',
        'method': 'search_read',
        'args': [domain],
        'kwargs': {
          'fields': [
            'id',
            'name',
            'email',
            'phone',
            'city',
            'state_id',
            'country_id',
            'category_id',
            'image_128',
            'company_type',
            'company_id',
            'commercial_partner_id',
            'function',
            'is_company',
            'customer_rank',
            'supplier_rank',
            'active',
          ],
        },
      });

      if (mounted) {
        setState(() {
          customers = response ?? [];
        });
        await fetchCategoryData();
        log("Filtered customers: ${customers.length}");
        log("Sample customer data: ${customers.isNotEmpty ? customers[0] : 'No customers'}");
      }
    } catch (e) {
      log("Error applying filters: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error applying filters: $e")),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }
  Future<void> loadFromIsar() async {
    // setState(() => isLoading = true);
    try {
      // Load customers
      final customersFromIsar = await isar.customers.where().findAll();
      if (customersFromIsar.isNotEmpty) {
        setState(() {
          customers = customersFromIsar.map((customer) {
            return {
              'id': customer.odooId,
              'name': customer.name,
              'email': customer.email,
              'phone': customer.phone,
              'city': customer.city,
              'category_id': customer.categoryIds,
              'image_128': customer.image128,
              'company_type': customer.companyType,
              'company_id': customer.companyId != null && customer.companyName != null
                  ? [customer.companyId, customer.companyName]
                  : null,
              'commercial_partner_id': customer.commercialPartnerId != null &&
                  customer.commercialPartnerName != null
                  ? [customer.commercialPartnerId, customer.commercialPartnerName]
                  : null,
              // 'function': customer.function,
              'is_company': customer.isCompany,
              'customer_rank': customer.customerRank,
              'supplier_rank': customer.supplierRank,
              'active': customer.active,
              'country_id': customer.countryId != null && customer.countryName != null
                  ? [customer.countryId, customer.countryName]
                  : null,
              'state_id': customer.stateId != null && customer.stateName != null
                  ? [customer.stateId, customer.stateName]
                  : null,
            };
          }).toList();
        });
        log("Loaded ${customers.length} customers from Isar");
      }

      // Load categories
      final categoriesFromIsar = await isar.categorys.where().findAll();
      if (categoriesFromIsar.isNotEmpty) {
        setState(() {
          categoryMap = {for (var cat in categoriesFromIsar) cat.odooId: cat.name ?? 'Unknown'};
          categoryPathMap = {
            for (var cat in categoriesFromIsar)
              cat.odooId: cat.parentPath?.isNotEmpty ?? false
                  ? cat.parentPath!.split('/').where((id) => id.isNotEmpty).map((id) {
                int catId = int.tryParse(id) ?? 0;
                return categoryMap[catId] ?? 'Unknown';
              }).join('/')
                  : cat.name ?? 'Unknown'
          };
        });
        log("Loaded ${categoriesFromIsar.length} categories from Isar");
      }

      // Load activities
      final activitiesFromIsar = await isar.activitys.where().findAll();
      if (activitiesFromIsar.isNotEmpty) {
        Map<int, List<dynamic>> tempActivities = {};
        for (var activity in activitiesFromIsar) {
          tempActivities.putIfAbsent(activity.customerId, () => []).add({
            'res_id': activity.customerId,
            'activity_type_id': activity.activityTypeId != null && activity.activityTypeName != null
                ? [activity.activityTypeId, activity.activityTypeName]
                : null,
            'date_deadline': activity.dateDeadline,
            'summary': activity.summary,
            'user_id': activity.userId != null && activity.userName != null
                ? [activity.userId, activity.userName]
                : null,
            'user_image': activity.userImage,
          });
        }
        setState(() {
          customerActivities = tempActivities;
        });
        log("Loaded activities for ${customerActivities.length} customers from Isar");
      }

      // Fetch from Odoo if Isar is empty
      if (customersFromIsar.isEmpty) {
        await initializeOdooClient();
      } else {
        // Fetch fresh data in the background
        if (await ensureAuthenticated()) {
          await fetchCustomerData(savetoIsar: true);
          await fetchCategoryData(savetoIsar: true);
          await fetchActivityTypes();
          await fetchActivityData(savetoIsar: true);
        }
      }
    } catch (e) {
      log("Isar Load Failed: $e");
    }
  }
  bool isValidBase64(String? input) {
    if (input == null || input.isEmpty || input == 'false') {
      return false;
    }
    try {
      if (input.length % 4 != 0) return false;
      base64Decode(input); // Attempt to decode
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> fetchCustomerData({bool savetoIsar = false}) async {
    try {
      final response = await client?.callKw({
        'model': 'res.partner',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'fields': [
            'id',
            'name',
            'email',
            'phone',
            'city',
            'state_id',
            'country_id',
            'category_id',
            'image_128',
            'company_type',
            'company_id',
            'commercial_partner_id',
            'function',
            'is_company',
            'customer_rank',
            'supplier_rank',
            'active',
          ],
        },
      });
      if (response != null && mounted) {
        if (savetoIsar) {
          await isar.writeTxn(() async {
            await isar.customers.clear();
            log('Cleared Customer collection');

            for (var customer in response) {
              try {
                final customerModel = Customer()
                  ..odooId = customer['id']
                  ..name = customer['name']?.toString()
                  ..email = customer['email']?.toString()
                  ..phone = customer['phone']?.toString()
                  ..city = customer['city']?.toString()
                  ..categoryIds = customer['category_id'] is List
                      ? (customer['category_id'] as List)
                      .whereType<int>()
                      .toList()
                      : null
                  // ..image128 = customer['image_128']?.toString()
                  ..image128 = isValidBase64(customer['image_128']?.toString())
                      ? customer['image_128']?.toString()
                      : null
                  ..companyType = customer['company_type']?.toString()
                  ..companyId = customer['company_id'] is List &&
                      customer['company_id'].isNotEmpty
                      ? customer['company_id'][0]
                      : null
                  ..companyName = customer['company_id'] is List &&
                      customer['company_id'].length > 1
                      ? customer['company_id'][1]?.toString()
                      : null
                  ..commercialPartnerId = customer['commercial_partner_id'] is List &&
                      customer['commercial_partner_id'].isNotEmpty
                      ? customer['commercial_partner_id'][0]
                      : null
                  ..commercialPartnerName = customer['commercial_partner_id'] is List &&
                      customer['commercial_partner_id'].length > 1
                      ? customer['commercial_partner_id'][1]?.toString()
                      : null
                  ..function = customer['function']?.toString()
                  ..isCompany = customer['is_company']
                  ..customerRank = customer['customer_rank']
                  ..supplierRank = customer['supplier_rank']
                  ..active = customer['active']
                  ..countryId = customer['country_id'] is List &&
                      customer['country_id'].isNotEmpty
                      ? customer['country_id'][0]
                      : null
                  ..countryName = customer['country_id'] is List &&
                      customer['country_id'].length > 1
                      ? customer['country_id'][1]?.toString()
                      : null
                  ..stateId = customer['state_id'] is List &&
                      customer['state_id'].isNotEmpty
                      ? customer['state_id'][0]
                      : null
                  ..stateName = customer['state_id'] is List &&
                      customer['state_id'].length > 1
                      ? customer['state_id'][1]?.toString()
                      : null;

                await isar.customers.put(customerModel);
                log('Saved customer: ${customer['name']}');
              } catch (e) {
                log('Error saving customer: ${customer['name']}, Error: $e');
                log('Customer data: $customer');
              }
            }
          });
        }

        setState(() {
          customers = response;
          isLoading = false;
        });
        await fetchCategoryData();
        await fetchActivityData();
        log("Customers fetched: ${customers.length}");
        log("Sample customer data: ${customers.isNotEmpty ? customers[0] : 'No customers'}");
      }
    } catch (e) {
      log("Error fetching customers: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error fetching customers: $e")),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: isSearching
            ? TextField(
          controller: searchController,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: const TextStyle(color: Colors.white70),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.2),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        )
            : const Text("Customers",style: TextStyle(color: Colors.white),),
        elevation: 0,
        backgroundColor: const Color(0xFF9EA700),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search,color: Colors.white,),
            onPressed: () {
              setState(() {
                if (isSearching) {
                  searchController.clear();
                  isSearching = false;
                  fetchCustomerData(); // Reset to full data
                } else {
                  isSearching = true;
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list,color: Colors.white,),
            onPressed: () => showFilterDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          ChartSelection(),
          SizedBox(
            height: 15,
          ), // Added here at the start
          Expanded(
            child: isLoading && customers.isEmpty
                ?Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: Color(0xFF9EA700),
                size: 100,
              ),
            )

                    : RefreshIndicator(
                        onRefresh: () async {
                          await fetchCustomerData();
                        },
                        child: iconSelectedView(),
                      ),
          ),
        ],
      ),
    );
  }

  Widget buildCustomerCard(dynamic customer) {
    String? imageBase64 = customer['image_128'] is String &&
            customer['image_128'].isNotEmpty &&
            customer['image_128'] != false
        ? customer['image_128']
        : null;
    bool isCompany = customer['company_type'] == 'company';
    bool hasCompanyImage = customer['company_id'] != null &&
        customer['company_id'] is List &&
        customer['company_id'].length > 1;

    bool hasCommercialPartner = customer['commercial_partner_id'] != null &&
        customer['commercial_partner_id'] is List &&
        customer['commercial_partner_id'].length > 1 &&
        customer['commercial_partner_id'][0] != customer['id'];

    String commercialPartnerName =
        hasCommercialPartner ? customer['commercial_partner_id'][1] : '';
    String? jobTitle =
        customer['function'] is String && customer['function'].isNotEmpty
            ? customer['function']
            : null;

    List<String> categoryPaths = [];
    if (customer['category_id'] != null && customer['category_id'] is List) {
      final categoryList = customer['category_id'] as List;
      for (var category in categoryList) {
        int categoryId = category is int
            ? category
            : (category is List && category.isNotEmpty ? category[0] : null);
        if (categoryId != null && categoryPathMap.containsKey(categoryId)) {
          categoryPaths.add(categoryPathMap[categoryId]!);
        }
      }
    }

    String? countryName = customer['country_id'] != null &&
            customer['country_id'] is List &&
            customer['country_id'].length > 1
        ? customer['country_id'][1]
        : null;

    return Card(
      color: Colors.grey.shade50,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CustomerView(customerId: customer['id']),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          constraints: const BoxConstraints(minHeight: 200),
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    child: OdooAvatar(
                      client: client!, // Use the OdooClient from _CustomersState
                      model: 'res.partner',
                      recordId: customer['id'], // Customer ID
                      size: 70,
                      borderRadius: 35,
                      shape: BoxShape.circle,
                      // Optional: Add a placeholder or errorBuilder if OdooAvatar supports it
                    ),
                  ),
                  if (hasCompanyImage) ...[
                    const SizedBox(width: 8),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[200],
                      ),
                      child: Center(
                        child: Text(
                          customer['company_id'][1].toString().substring(
                              0,
                              customer['company_id'][1].toString().length > 4
                                  ? 4
                                  : customer['company_id'][1]
                                      .toString()
                                      .length),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 12),
              Text(
                customer['name'] ?? 'Unknown',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (hasCommercialPartner) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Row(
                            children: [
                              Icon(Icons.business,
                                  size: 14, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  commercialPartnerName,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey[700],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if (jobTitle != null) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            jobTitle,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                      if (categoryPaths.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Wrap(
                            spacing: 4,
                            children: categoryPaths
                                .take(2)
                                .map((path) => Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: getCategoryColor(path),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        path,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                      if (customer['city']?.toString().isNotEmpty ?? false) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            customer['city'].toString(),
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[600]),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                      if (countryName?.isNotEmpty ?? false) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            countryName!,
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[600]),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                      if (customer['email']?.toString().isNotEmpty ??
                          false) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            customer['email'].toString(),
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[600]),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              // const SizedBox(height: 8),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     _buildStatItem(
              //         Icons.star_border,
              //         customer['customer_rank']?.toString() ?? "0",
              //         Colors.amber),
              //     _buildStatItem(
              //         Icons.description_outlined,
              //         customer['supplier_rank']?.toString() ?? "0",
              //         Colors.blue),
              //     _buildStatItem(Icons.attach_money,
              //         customer['amount']?.toString() ?? "0", Colors.green),
              //     IconButton(
              //       padding: EdgeInsets.zero,
              //       constraints: const BoxConstraints(),
              //       icon: Icon(Icons.access_time,
              //           size: 16, color: Colors.grey[600]),
              //       onPressed: () {},
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, Color color) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Color getCategoryColor(String path) {
    String category = path.split('/').last.toLowerCase();
    if (category.contains('vendor') || category.contains('desk')) {
      return Colors.green[600]!;
    } else if (category.contains('service')) {
      return Colors.cyan[600]!;
    } else if (category.contains('office')) {
      return Colors.blue[600]!;
    } else if (category.contains('consult')) {
      return Colors.purple[300]!;
    }
    return Colors.grey[600]!;
  }
}

class CustomerActivityDataSource extends DataGridSource {
  List<DataGridRow> _customers = [];
  final List<dynamic> activityTypes;
  final BuildContext context;

  CustomerActivityDataSource(List<dynamic> customers,
      Map<int, List<dynamic>> customerActivities, this.activityTypes,this.context) {
    _customers = customers.map<DataGridRow>((customer) {
      String? imageBase64 = customer['image_128'] is String &&
              customer['image_128'].isNotEmpty &&
              customer['image_128'] != false
          ? customer['image_128']
          : null;
      String companyName = customer['commercial_partner_id'] != null &&
              customer['commercial_partner_id'] is List &&
              customer['commercial_partner_id'].length > 1
          ? customer['commercial_partner_id'][1]
          : '';

      List<dynamic> activities = customerActivities[customer['id']] ?? [];

      Map<String, Map<String, dynamic>> activityData = {
        for (var type in activityTypes) type['name']: {},
      };

      for (var activity in activities) {
        String? activityType = activity['activity_type_id'] is List &&
                activity['activity_type_id'].length > 1
            ? activity['activity_type_id'][1]
            : null;
        String? date = activity['date_deadline']?.toString() ?? '';
        dynamic userId =
            activity['user_id'] is List && activity['user_id'].length > 1
                ? activity['user_id']
                : null;
        String? userImage = activity['user_image'];

        if (activityType != null && activityData.containsKey(activityType)) {
          activityData[activityType] = {
            'date': date,
            'user_id': userId,
            'user_image': userImage,
          };
        }
      }

      List<DataGridCell> cells = [
        DataGridCell<Widget>(
          columnName: 'customer',
          value: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ),
                child: imageBase64 != null
                    ? ClipOval(
                        child: Image.memory(
                          Base64Decoder().convert(imageBase64),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.person,
                            size: 24,
                            color: Colors.grey[600],
                          ),
                        ),
                      )
                    : Icon(
                        Icons.person,
                        size: 24,
                        color: Colors.grey[600],
                      ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CustomerView(customerId: customer['id'])));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        customer['name'] ?? 'Unknown',
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        companyName,
                        style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ];

      for (var type in activityTypes) {
        cells.add(DataGridCell<Map<String, dynamic>>(
          columnName: type['name'],
          value: activityData[type['name']] ?? {},
        ));
      }

      return DataGridRow(cells: cells);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _customers;

  Color _getActivityColor(String date) {
    if (date.isEmpty) return Colors.transparent;
    DateTime activityDate = DateTime.parse(date);
    DateTime today = DateTime.now();
    DateTime todayStart = DateTime(today.year, today.month, today.day);
    DateTime activityDateStart =
        DateTime(activityDate.year, activityDate.month, activityDate.day);

    if (activityDateStart.isBefore(todayStart)) {
      return Colors.red; // Overdue
    } else if (activityDateStart.isAtSameMomentAs(todayStart)) {
      return Colors.yellow; // Today
    } else {
      return Colors.green; // Planned
    }
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((cell) {
        if (cell.columnName == 'customer') {
          return Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: cell.value as Widget,
          );
        }

        Map<String, dynamic> activityData = cell.value as Map<String, dynamic>;
        String date = activityData['date']?.toString() ?? '';
        String? userImage = activityData['user_image'];

        Color backgroundColor = _getActivityColor(date);

        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          color: backgroundColor,
          child: date.isNotEmpty
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.8),
                      ),
                      child: activityData['user_id'] != null && activityData['user_id'] is List && activityData['user_id'].isNotEmpty
                          ? OdooAvatar(
                        client:client, // Pass the OdooClient from _CustomersState
                        model: 'res.users',
                        recordId: activityData['user_id'][0], // User ID
                        size: 24,
                        borderRadius: 12,
                        shape: BoxShape.circle,
                      )
                          : Icon(
                        Icons.person,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      date,
                      style: TextStyle(fontSize: 12, color: Colors.black87),
                    ),
                  ],
                )
              : const SizedBox(),
        );
      }).toList(),
    );
  }
}
