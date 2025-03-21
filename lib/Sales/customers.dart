import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  // Filter related variables
  Set<String> selectedFilters = {};
  String? selectedCountry;

  @override
  void initState() {
    super.initState();
    initializeOdooClient();
  }

  Future<void> initializeOdooClient() async {
    setState(() => isLoading = true);
    final prefs = await SharedPreferences.getInstance();
    final baseUrl = prefs.getString("urldata") ?? "";
    final dbName = prefs.getString("selectedDatabase") ?? "";
    final userLogin = prefs.getString("userLogin") ?? "";
    final userPassword = prefs.getString("password") ?? "";

    if (baseUrl.isNotEmpty && dbName.isNotEmpty && userLogin.isNotEmpty && userPassword.isNotEmpty) {
      client = OdooClient(baseUrl);
      try {
        await client!.authenticate(dbName, userLogin, userPassword);
        await fetchCustomerData();
        await fetchCategoryData();
        // await fetchCountryData(); // Uncomment if you need country data
      } catch (e) {
        log("Odoo Authentication Failed: $e");
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to connect to Odoo: $e")),
          );
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Missing connection details")),
        );
      }
    }
    if (mounted) {
      setState(() => isLoading = false);
    }
  }

  Future<void> fetchCategoryData() async {
    if (client == null) return;

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
            [['id', 'in', categoryIds.toList()]]
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
              [['id', 'in', allCategoryIds.toList()]]
            ],
            'kwargs': {
              'fields': ['id', 'name', 'parent_path'],
            },
          });

          if (fullResponse != null && mounted) {
            Map<int, String> tempCategoryMap = {for (var cat in fullResponse) cat['id']: cat['name']};
            setState(() {
              categoryMap = tempCategoryMap;
            });

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
          }
        }
      }
    } catch (e) {
      log("Error fetching categories: $e");
    }
  }

  // Filter definitions
  Map<String, Map<String, dynamic>> getFilters() {
    return {
      'individuals': {
        'name': 'Individuals',
        'domain': [['is_company', '=', false]]
      },
      'companies': {
        'name': 'Companies',
        'domain': [['is_company', '=', true]]
      },
      'customer_invoice': {
        'name': 'Customer Invoices',
        'domain': [['customer_rank', '>', 0]]
      },
      'vendor_bills': {
        'name': 'Vendor Bills',
        'domain': [['supplier_rank', '>', 0]]
      },
      'archived': {
        'name': 'Archived',
        'domain': [['active', '=', false]]
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text("Apply", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
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
        await fetchCategoryData(); // Fetch updated category data after filtering
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

  Future<void> fetchCustomerData() async {
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
      if (mounted) {
        setState(() {
          customers = response ?? [];
        });
        await fetchCategoryData(); // Fetch category data after initial customer fetch
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Customers"),
        elevation: 0,
        backgroundColor: const Color(0xFF9EA700),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => showFilterDialog(context),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : customers.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              "No Customers Found",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      )
          : RefreshIndicator(
        onRefresh: () async {
          await fetchCustomerData();
        },
        child: Padding(
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
        ),
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

    String commercialPartnerName = hasCommercialPartner ? customer['commercial_partner_id'][1] : '';
    String? jobTitle = customer['function'] is String && customer['function'].isNotEmpty ? customer['function'] : null;

    List<String> categoryPaths = [];
    if (customer['category_id'] != null && customer['category_id'] is List) {
      final categoryList = customer['category_id'] as List;
      for (var category in categoryList) {
        int categoryId = category is int ? category : (category is List && category.isNotEmpty ? category[0] : null);
        if (categoryId != null && categoryPathMap.containsKey(categoryId)) {
          categoryPaths.add(categoryPathMap[categoryId]!);
        }
      }
    }

    String? countryName = customer['country_id'] != null &&
        customer['country_id'] is List &&
        customer['country_id'].isNotEmpty
        ? countryMap[customer['country_id'][0]] ?? 'Unknown'
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
                    child: imageBase64 != null
                        ? ClipOval(
                      child: Image.memory(
                        Base64Decoder().convert(imageBase64),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          isCompany ? Icons.business : Icons.person,
                          size: 24,
                          color: Colors.grey[600],
                        ),
                      ),
                    )
                        : Icon(
                      isCompany ? Icons.business : Icons.person,
                      size: 24,
                      color: Colors.grey[600],
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
                                  : customer['company_id'][1].toString().length),
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
                              Icon(Icons.business, size: 14, color: Colors.grey[600]),
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
                            children: categoryPaths.take(2).map((path) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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
                            )).toList(),
                          ),
                        ),
                      ],
                      if (customer['city']?.toString().isNotEmpty ?? false) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            customer['city'].toString(),
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
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
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                      if (customer['email']?.toString().isNotEmpty ?? false) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            customer['email'].toString(),
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatItem(Icons.star_border, customer['customer_rank']?.toString() ?? "0", Colors.amber),
                  _buildStatItem(Icons.description_outlined, customer['supplier_rank']?.toString() ?? "0", Colors.blue),
                  _buildStatItem(Icons.attach_money, customer['amount']?.toString() ?? "0", Colors.green),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                    onPressed: () {},
                  ),
                ],
              ),
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