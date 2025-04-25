import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:cyllo_mobile/isarModel/activityModel.dart';
import 'package:cyllo_mobile/isarModel/pipelineModel.dart';
import 'package:flutter/material.dart';
import 'package:appflowy_board/appflowy_board.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../getUserImage.dart';
import '../main.dart';
import 'Views/activityView.dart';
import 'Views/pipeLineView.dart';
import 'myPipeline.dart';

class Myactivity extends StatefulWidget {
  const Myactivity({super.key});

  @override
  State<Myactivity> createState() => _MyactivityState();
}

OdooClient? client;
bool isLoading = true;
final AppFlowyBoardController controller = AppFlowyBoardController();
late AppFlowyBoardScrollController boardController;
int selectedView = 0;
List<Map<String, dynamic>> leadsList = [];
List<Map<String, dynamic>> activitiesList = [];

class _MyactivityState extends State<Myactivity> {
  List<String> _creationDates = [];
  Map<int, String> tagMap = {};
  List<String> _closedDates = [];
  List<ChartData> chartDatavalues = [];
  List<String> activityTypes = [];
  Uint8List? profileImage;
  String? userName;
  bool showNoDataMessage = false;
  String selectedChart = "bar";
  String selectedFilter = "count";
  String showVariable = "count";
  String? selectedReport = "Activities";

  Set<String> selectedFilters = {};
  int? currentUserId;
  String? selectedCreationDate;
  String? selectedClosedDate;
  final TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  Timer? _debounce;

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (searchController.text.isNotEmpty) {
        pipe(query: searchController.text);
      } else {
        pipe(); // Reset to full data when search is cleared
      }
    });
  }

  Map<String, Map<String, dynamic>> getFilters() {
    String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return {
      'my_activities': {
        'name': 'My Activities',
        'domain': [
          ['activity_user_id', '=', currentUserId]
        ]
      },
      'unassigned': {
        'name': 'Unassigned',
        'domain':[
          '&',
          ['user_id', '=', false],
          ['type', '=', 'lead']
        ]

      },
      'my_assigned_partners': {
        'name': 'My Assigned Partners',
        'domain': [
          ["partner_assigned_id.user_id", "=", currentUserId]
        ]
      },
      'lost': {
        'name': 'Lost',
        'domain': [
          '&',
          ['active', '=', false],
          ['probability', '=', 0]
        ]
      },
      'created_on': {
        'name': 'Created On',
        'domain': [],
      },
      'closed_on': {
        'name': 'Closed On',
        'domain': [],
      },
      'late_activities': {
        'name': 'Late Activities',
        'domain': [
          ['my_activity_date_deadline', '<', todayDate]
        ]
      },
      'today_activities': {
        'name': 'Today Activities',
        'domain': [
          ['my_activity_date_deadline', '=', todayDate]
        ]
      },
      'future_activities': {
        'name': 'Future Activities',
        'domain': [
          ['my_activity_date_deadline', '>', todayDate]
        ]
      },
      'archived': {
        'name': 'Archived',
        'domain': [
          ['active', '=', false],
        ]
      },
    };
  }

  Future<void> initializeOdooClient() async {
    setState(() {
      isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    final baseUrl = prefs.getString("urldata") ?? "";
    final dbName = prefs.getString("selectedDatabase") ?? "";
    final userLogin = prefs.getString("userLogin") ?? "";
    final userPassword = prefs.getString("password") ?? "";
    currentUserId = prefs.getInt("userId");

    if (baseUrl.isNotEmpty &&
        dbName.isNotEmpty &&
        userLogin.isNotEmpty &&
        userPassword.isNotEmpty) {
      client = OdooClient(baseUrl);
      try {
        final auth = await client!.authenticate(dbName, userLogin, userPassword);
        print("Odoo Authenticated: $auth");
        await userImage();
        await pipe(savetoIsar: true);
        await tag();
        await iconSelectedView();
        await fetchData();
        await buildChart();
        await fetchFilteredData();
        await act();
        final dates = await fetchAllDates();
        setState(() {
          _creationDates = dates['creationDates']!;
          _closedDates = dates['closedDates']!;
        });
      } catch (e) {
        await loadFromIsar();
        print("Odoo Authentication Failed: $e");
      }
    }
    setState(() => isLoading = false);
  }

  Future<void> loadFromIsar() async {
    setState(() {
      isLoading = true;
      selectedView = 0;
    });
    try {
      final tags = await isar.tags.where().findAll();
      tagMap = {for (var tag in tags) tag.tagId!: tag.name ?? ''};
      final pipes = await isar.newacts.where().findAll();

      if (pipes.isNotEmpty) {
        leadsList = pipes.map((pipe) {
          return {
            'id': pipe.leadId,
            'name': pipe.name,
            'expected_revenue': pipe.expectedRevenue ?? 0.0,
            'stage_id': pipe.stageId != null && pipe.stageName != null
                ? [pipe.stageId![0], pipe.stageName]
                : null,
            'partner_id': pipe.partnerId != null && pipe.partnerName != null
                ? [pipe.partnerId![0], pipe.partnerName]
                : null,
            'tag_ids': pipe.tagIds,
            'priority': pipe.priority,
            'activity_state': pipe.activityState,
            'activity_type_id': pipe.activityTypeId != null && pipe.activityTypeName != null
                ? [pipe.activityTypeId![0], pipe.activityTypeName]
                : null,
            'email_from': pipe.emailFrom,
            'recurring_revenue_monthly': pipe.recurringRevenueMonthly,
            'contact_name': pipe.contactName,
            'activity_ids': pipe.activityIds,
            'activity_date_deadline': pipe.activityDateDeadline,
            'create_date': pipe.createDate,
            'day_open': pipe.dayOpen,
            'day_close': pipe.dayClose,
            'probability': pipe.probability,
            'recurring_revenue_monthly_prorated': pipe.recurringRevenueMonthlyProrated,
            'recurring_revenue_prorated': pipe.recurringRevenueProrated,
            'prorated_revenue': pipe.proratedRevenue,
            'recurring_revenue': pipe.recurringRevenue,
            'activity_user_id': pipe.activityUserId,
            'date_closed': pipe.dateClosed,
            'type': pipe.type,
            'user_id': pipe.userId,
            'phone': pipe.phone,
          };
        }).toList();

        // opportunitiesList = leadsList.where((lead) => lead['type'] == "opportunity").toList();

        controller.clear();
        // Group pipes by stage_id instead of stageName
        Map<int, List<Newact>> groupedPipes = {};
        for (var pipe in pipes) {
          if (pipe.stageId != null && pipe.stageName != null) {
            groupedPipes.putIfAbsent(pipe.stageId![0], () => []).add(pipe);
          }
        }

        // Sort groups by stage_id
        var sortedStageIds = groupedPipes.keys.toList()..sort();
        for (var stageId in sortedStageIds) {
          var pipesInStage = groupedPipes[stageId]!;
          // Use stageName for display, but order by stageId
          String stageName = pipesInStage.first.stageName ?? 'Unknown';
          final groupData = AppFlowyGroupData(
            id: stageId.toString(),
            name: stageName,
            items: pipesInStage.map((pipe) {
              int priorityValue;
              switch (pipe.priority ?? '0') {
                case '0':
                  priorityValue = 0; // Low
                  break;
                case '1':
                  priorityValue = 1; // Medium
                  break;
                case '2':
                  priorityValue = 2; // High
                  break;
                case '3':
                  priorityValue = 3; // High
                  break;
                default:
                  priorityValue = 0; // Default to Low
              }
              return LeadItem(
                leadId: pipe.leadId ?? 0,
                name: pipe.name ?? '',
                revenue: pipe.expectedRevenue?.toString() ?? '0',
                customerName: pipe.partnerName ?? 'None',
                priority: priorityValue,
                tags: pipe.tagIds?.map((id) => tagMap[id] ?? '').toList() as List<String> ?? [],
                activityState: pipe.activityState ?? '',
                activityType: pipe.activityTypeName ?? '',
                hasActivity: pipe.activityIds?.isNotEmpty ?? false,
                activityIds: pipe.activityIds?.map((id) => id.toString()).toList() ?? [],
                salespersonId: pipe.userId,
                imageData: null, // Handle profile image if stored in Isar
              );
            }).toList(),
          );
          controller.addGroup(groupData);
        }

        // Calculate chart data
        Map<String, double> stageValues = {};
        Map<String, int> stageIdToName = {};
        for (var item in opportunitiesList) {
          if (item['stage_id'] != null &&
              item['stage_id'] is List &&
              item['stage_id'].length > 1) {
            String stageName = item['stage_id'][1].toString();
            int stageId = item['stage_id'][0] as int;
            stageIdToName[stageName] = stageId;
            double value;
            if (selectedFilter == "count") {
              value = (stageValues[stageName] ?? 0) + 1;
            } else if (selectedFilter == "day_open" && item['day_open'] != null && item['day_open'] != false) {
              value = (stageValues[stageName] ?? 0) + (item['day_open'] as double);
            } else if (selectedFilter == "day_close" && item['day_close'] != null && item['day_close'] != false) {
              value = (stageValues[stageName] ?? 0) + (item['day_close'] as double);
            } else if (selectedFilter == "recurring_revenue_monthly" && item['recurring_revenue_monthly'] != null && item['recurring_revenue_monthly'] != false) {
              value = (stageValues[stageName] ?? 0) + (item['recurring_revenue_monthly'] as double);
            } else if (selectedFilter == "expected_revenue" && item['expected_revenue'] != null && item['expected_revenue'] != false) {
              value = (stageValues[stageName] ?? 0) + (item['expected_revenue'] as double);
            } else if (selectedFilter == "probability" && item['probability'] != null && item['probability'] != false) {
              value = (stageValues[stageName] ?? 0) + (item['probability'] as double);
            } else if (selectedFilter == "recurring_revenue_monthly_prorated" && item['recurring_revenue_monthly_prorated'] != null && item['recurring_revenue_monthly_prorated'] != false) {
              value = (stageValues[stageName] ?? 0) + (item['recurring_revenue_monthly_prorated'] as double);
            } else if (selectedFilter == "recurring_revenue_prorated" && item['recurring_revenue_prorated'] != null && item['recurring_revenue_prorated'] != false) {
              value = (stageValues[stageName] ?? 0) + (item['recurring_revenue_prorated'] as double);
            } else if (selectedFilter == "prorated_revenue" && item['prorated_revenue'] != null && item['prorated_revenue'] != false) {
              value = (stageValues[stageName] ?? 0) + (item['prorated_revenue'] as double);
            } else if (selectedFilter == "recurring_revenue" && item['recurring_revenue'] != null && item['recurring_revenue'] != false) {
              value = (stageValues[stageName] ?? 0) + (item['recurring_revenue'] as double);
            } else {
              value = 0;
            }
            stageValues[stageName] = value;
          }
        }

        setState(() {
          chartDatavalues.clear();
          // Sort chart data by stage_id
          List<String> stageNames = stageValues.keys.toList();
          stageNames.sort((a, b) => stageIdToName[a]!.compareTo(stageIdToName[b]!));
          List<ChartData> sortedData = stageNames
              .where((stage) => stageValues.containsKey(stage))
              .map((stage) => ChartData(stage, stageValues[stage]!))
              .toList();
          chartDatavalues = sortedData;

          if (stageNames.isEmpty || sortedData.every((data) => data.y == 0)) {
            showNoDataMessage = true;
          } else {
            showNoDataMessage = false;
          }
          isLoading = false;
        });
      } else {
        await initializeOdooClient();
      }
    } catch (e) {
      log("Isar Load Failed: $e");
      setState(() {
        isLoading = false;
        showNoDataMessage = true;
      });
    }
  }

  void showFilterDialog(BuildContext context) {
    final currentFilters = getFilters();
    Set<String> tempSelectedFilters = Set.from(selectedFilters);
    String? tempSelectedCreationDate = selectedCreationDate;
    String? tempSelectedClosedDate = selectedClosedDate;

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
        List<String> creationDates = _creationDates;
        List<String> closedDates = _closedDates;

        if (!creationDates.contains("None")) {
        creationDates = ["None", ...creationDates];
        }
        if (!closedDates.contains("None")) {
        closedDates = ["None", ...closedDates];
        }

                  return Container(
                    width: double.maxFinite,
                    constraints: BoxConstraints(maxHeight: 400),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (currentFilters.isEmpty)
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "No filters available",
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                          ...currentFilters.entries.map((entry) {
                            if (entry.key == 'created_on') {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      entry.value['name'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blueGrey[700],
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey[300]!),
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.grey[50],
                                      ),
                                      child: DropdownButton<String>(
                                        value: tempSelectedCreationDate ?? "None",
                                        hint: Text("Select a month"),
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        items: creationDates.map((String date) {
                                          return DropdownMenuItem<String>(
                                            value: date,
                                            child: Text(date),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setDialogState(() {
                                            if (newValue == "None") {
                                              tempSelectedCreationDate = null;
                                              tempSelectedFilters.remove('created_on');
                                            } else {
                                              tempSelectedCreationDate = newValue;
                                              tempSelectedFilters.add('created_on');
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else if (entry.key == 'closed_on') {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      entry.value['name'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blueGrey[700],
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey[300]!),
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.grey[50],
                                      ),
                                      child: DropdownButton<String>(
                                        value: tempSelectedClosedDate ?? "None",
                                        hint: Text("Select a month"),
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        items: closedDates.map((String date) {
                                          return DropdownMenuItem<String>(
                                            value: date,
                                            child: Text(date),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setDialogState(() {
                                            if (newValue == "None") {
                                              tempSelectedClosedDate = null;
                                              tempSelectedFilters.remove('closed_on');
                                            } else {
                                              tempSelectedClosedDate = newValue;
                                              tempSelectedFilters.add('closed_on');
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
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
                        ],
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
                  selectedCreationDate = tempSelectedCreationDate;
                  selectedClosedDate = tempSelectedClosedDate;
                });
                Navigator.pop(context);
                fetchFilteredData();
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

  Future<Map<String, List<String>>> fetchAllDates() async {
    return {
      'creationDates': await fetchCreationDates(),
      'closedDates': await fetchClosedDates(),
    };
  }

  Future<List<String>> fetchClosedDates() async {
    if (client == null) return [];

    try {
      final response = await client!.callKw({
        'model': 'crm.lead',
        'method': 'search_read',
        'args': [
          [['activity_user_id', '=', currentUserId]]
        ],
        'kwargs': {
          'fields': ['date_closed'],
        },
      });

      if (response == null || response.isEmpty) return [];

      Set<String> uniqueDates = {};
      for (var lead in response) {
        if (lead['date_closed'] != null && lead['date_closed'] != false && lead['date_closed'] is String) {
          DateTime date = DateTime.parse(lead['date_closed']);
          String formattedDate = DateFormat('MMMM yyyy').format(date);
          uniqueDates.add(formattedDate);
        }
      }

      List<String> sortedDates = uniqueDates.toList()
        ..sort((a, b) {
          DateTime dateA = DateFormat('MMMM yyyy').parse(a);
          DateTime dateB = DateFormat('MMMM yyyy').parse(b);
          return dateA.compareTo(dateB);
        });

      return sortedDates;
    } catch (e) {
      print("Failed to fetch closed dates: $e");
      return [];
    }
  }

  Future<List<String>> fetchCreationDates() async {
    if (client == null) return [];

    try {
      final response = await client!.callKw({
        'model': 'crm.lead',
        'method': 'search_read',
        'args': [
          [['activity_user_id', '=', currentUserId]]
        ],
        'kwargs': {
          'fields': ['create_date'],
        },
      });

      if (response == null || response.isEmpty) return [];

      Set<String> uniqueDates = {};
      for (var lead in response) {
        if (lead['create_date'] != null) {
          DateTime date = DateTime.parse(lead['create_date']);
          String formattedDate = DateFormat('MMMM yyyy').format(date);
          uniqueDates.add(formattedDate);
        }
      }

      List<String> sortedDates = uniqueDates.toList()
        ..sort((a, b) {
          DateTime dateA = DateFormat('MMMM yyyy').parse(a);
          DateTime dateB = DateFormat('MMMM yyyy').parse(b);
          return dateA.compareTo(dateB);
        });

      return sortedDates;
    } catch (e) {
      print("Failed to fetch creation dates: $e");
      return [];
    }
  }

  Future<void> fetchFilteredData() async {
    if (client == null) return;

    // setState(() {
    //   isLoading = true;
    // });

    try {
      await pipe();
      await buildChart();
    } catch (e) {
      log("Error fetching filtered data: $e");
      setState(() {
        // isLoading = false;
        showNoDataMessage = true;
      });
    }
  }

  Future<Map<int, String>> tag() async {
    Map<int, String> tagMap = {};
    try {
      final response = await client?.callKw({
        'model': 'crm.tag',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'fields': ['id', 'name', 'color'],
        }
      });
      if (response != null) {
        for (var tag in response) {
          tagMap[tag['id']] = tag['name'];
        }
      }
      print('Tags fetched: $tagMap');
      return tagMap;
    } catch (e) {
      print("Failed to fetch tags: $e");
      return {};
    }
  }

  Future<void> act() async {
    try {
      final response = await client?.callKw({
        'model': 'mail.activity.type',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'fields': ['name'],
        }
      });

      if (response != null && response is List) {
        setState(() {
          activityTypes = response.map((item) => item['name'].toString()).toList();
        });
      }
    } catch (e) {
      print("Failed to fetch activity types: $e");
    }
  }

  Future<void> userImage() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getInt("userId") ?? "";
    try {
      final response = await client?.callKw({
        'model': 'res.users',
        'method': 'search_read',
        'args': [
          [
            ["id", "=", userid],
          ]
        ],
        'kwargs': {
          'fields': [
            'image_1920',
            'name',
          ]
        },
      });
      if (response == null || response.isEmpty || response is! List) {
        print('No data received or invalid format');
        setState(() => isLoading = false);
        return;
      }
      try {
        final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(response);
        setState(() {
          var imageData = data[0]['image_1920'];
          if (imageData != null && imageData is String) {
            profileImage = base64Decode(imageData);
          }
          userName = data[0]['name'] ?? '';
        });
      } catch (e) {
        print("Odoo error$e");
      }
    } catch (e) {
      print("Image error$e");
    }
  }

  Future<void> pipe({String query="",bool savetoIsar = false}) async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getInt("userId") ?? "";
    try {
      Map<int, String> tagMap = await tag();
      final currentFilters = getFilters();
      List<dynamic> finalFilter = [];

      // Build the filter logic (unchanged until the issue with empty filter is resolved)
      bool hasUnassigned = selectedFilters.contains('unassigned');
      bool hasMyActivities = selectedFilters.contains('my_activities');
      bool hasMyAssignedPartners = selectedFilters.contains('my_assigned_partners');
      bool hasLost = selectedFilters.contains('lost');
      bool hasCreatedOn = selectedFilters.contains('created_on') && selectedCreationDate != null;
      bool hasClosedOn = selectedFilters.contains('closed_on') && selectedClosedDate != null;
      bool hasLateActivities = selectedFilters.contains('late_activities');
      bool hasTodayActivities = selectedFilters.contains('today_activities');
      bool hasFutureActivities = selectedFilters.contains('future_activities');
      bool hasArchived = selectedFilters.contains('archived');

      log('Selected Filters: $selectedFilters');

      // Primary domain (unassigned, my_activities, my_assigned_partners) with OR logic
      List<dynamic> primaryDomain = [];
      if (hasMyActivities) {
        primaryDomain.addAll(currentFilters['my_activities']!['domain']); // ['activity_user_id', '=', currentUserId]
      }
      if(!hasMyActivities){
        finalFilter.add(['activity_user_id','!=',false]);
      }
      if (hasUnassigned || hasMyAssignedPartners) {
        if (hasUnassigned && hasMyAssignedPartners && hasMyActivities) {
          primaryDomain = ['|', '|', ...currentFilters['unassigned']!['domain'],
            ...currentFilters['my_activities']!['domain'],
            ...currentFilters['my_assigned_partners']!['domain']];
        } else if (hasUnassigned && hasMyActivities) {
          primaryDomain = ['|', ...currentFilters['unassigned']!['domain'],
            ...currentFilters['my_activities']!['domain']];
        } else if (hasUnassigned && hasMyAssignedPartners) {
          primaryDomain = ['|', ...currentFilters['unassigned']!['domain'],
            ...currentFilters['my_assigned_partners']!['domain']];
        } else if (hasMyActivities && hasMyAssignedPartners) {
          primaryDomain = ['|', ...currentFilters['my_activities']!['domain'],
            ...currentFilters['my_assigned_partners']!['domain']];
        } else if (hasUnassigned) {
          primaryDomain = [...currentFilters['unassigned']!['domain']];
        } else if (hasMyAssignedPartners) {
          primaryDomain = [...currentFilters['my_assigned_partners']!['domain']];
        }
      }

      // Activities domain (late, today, future) with OR logic
      List<dynamic> activitiesDomain = [];
      if (hasLateActivities || hasTodayActivities || hasFutureActivities) {
        if (hasLateActivities && hasTodayActivities && hasFutureActivities) {
          activitiesDomain.add('|');
          activitiesDomain.add('|');
          activitiesDomain.addAll(currentFilters['late_activities']!['domain']);
          activitiesDomain.addAll(currentFilters['today_activities']!['domain']);
          activitiesDomain.addAll(currentFilters['future_activities']!['domain']);
        } else if (hasLateActivities && hasTodayActivities) {
          activitiesDomain.add('|');
          activitiesDomain.addAll(currentFilters['late_activities']!['domain']);
          activitiesDomain.addAll(currentFilters['today_activities']!['domain']);
        } else if (hasLateActivities && hasFutureActivities) {
          activitiesDomain.add('|');
          activitiesDomain.addAll(currentFilters['late_activities']!['domain']);
          activitiesDomain.addAll(currentFilters['future_activities']!['domain']);
        } else if (hasTodayActivities && hasFutureActivities) {
          activitiesDomain.add('|');
          activitiesDomain.addAll(currentFilters['today_activities']!['domain']);
          activitiesDomain.addAll(currentFilters['future_activities']!['domain']);
        } else if (hasLateActivities) {
          activitiesDomain.addAll(currentFilters['late_activities']!['domain']);
        } else if (hasTodayActivities) {
          activitiesDomain.addAll(currentFilters['today_activities']!['domain']);
        } else if (hasFutureActivities) {
          activitiesDomain.addAll(currentFilters['future_activities']!['domain']);
        }
      }

      // Date filters (created_on, closed_on) with proper range
      List<dynamic> dateDomain = [];
      bool hasDateFilter = false;
      if (hasCreatedOn) {
        DateTime parsedDate = DateFormat('MMMM yyyy').parse(selectedCreationDate!);
        DateTime startDateTime = DateTime(parsedDate.year, parsedDate.month, 0, 18, 30, 0);
        String startDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(startDateTime);
        DateTime endDateTime = DateTime(parsedDate.year, parsedDate.month + 1, 0, 18, 29, 59);
        String endDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(endDateTime);
        dateDomain.add(['create_date', '>=', startDate]);
        dateDomain.add(['create_date', '<=', endDate]);
        hasDateFilter = true;
      }
      if (hasClosedOn) {
        DateTime parsedDate = DateFormat('MMMM yyyy').parse(selectedClosedDate!);
        DateTime startDateTime = DateTime(parsedDate.year, parsedDate.month, 0, 18, 30, 0);
        String startDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(startDateTime);
        DateTime endDateTime = DateTime(parsedDate.year, parsedDate.month + 1, 0, 18, 29, 59);
        String endDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(endDateTime);
        dateDomain.add(['date_closed', '>=', startDate]);
        dateDomain.add(['date_closed', '<=', endDate]);
        hasDateFilter = true;
      }
      if (hasCreatedOn && hasClosedOn) {
        dateDomain = ['&', ...dateDomain];
      } else if (hasCreatedOn || hasClosedOn) {
        dateDomain = ['&', ...dateDomain];
      }

      // Combine domains with AND logic
      if (primaryDomain.isNotEmpty) {
        finalFilter = [...finalFilter, ...primaryDomain];
      }
      if (activitiesDomain.isNotEmpty) {
        if (finalFilter.isNotEmpty) {
          finalFilter = ['&', ...finalFilter, ...activitiesDomain];
        } else {
          finalFilter = [...activitiesDomain];
        }
      }
      if (hasDateFilter) {
        if (finalFilter.isNotEmpty) {
          finalFilter = ['&', ...finalFilter, ...dateDomain];
        } else {
          finalFilter = [...dateDomain];
        }
      }
      if (hasLost) {
        if (finalFilter.isNotEmpty) {
          finalFilter = ['&', ...finalFilter, ...currentFilters['lost']!['domain']];
        } else {
          finalFilter = [...currentFilters['lost']!['domain']];
        }
      }
      if (hasArchived) {
        if (finalFilter.isNotEmpty) {
          finalFilter = ['&', ...finalFilter, ...currentFilters['archived']!['domain']];
        } else {
          finalFilter = [...currentFilters['archived']!['domain']];
        }
      }

      // Default filter: Ensure activity_user_id != false when no primary filters are selected
      if (finalFilter.isEmpty && !hasMyActivities && !hasUnassigned && !hasMyAssignedPartners) {
        finalFilter = [['activity_user_id', '!=', false]];
      }


      if(query.isNotEmpty){
        List<dynamic> searchDomain = [
          "|",
          "|",
          "|",
          ["partner_name", "ilike", query],
          ["email_from", "ilike", query],
          ["contact_name", "ilike", query],
          ["name", "ilike", query],
        ];

        finalFilter=[...finalFilter,...searchDomain];
      } log('monnnaa$finalFilter');
      final response = await client?.callKw({
        'model': 'crm.lead',
        'method': 'search_read',
        'args': [finalFilter],
        'kwargs': {
          'fields': [
            'name',
            'expected_revenue',
            'stage_id',
            'partner_id',
            'tag_ids',
            'priority',
            'activity_state',
            'activity_type_id',
            'email_from',
            'recurring_revenue_monthly',
            'contact_name',
            'activity_ids',
            'activity_date_deadline',
            'create_date',
            'day_open',
            'day_close',
            'probability',
            'activity_user_id',
            'date_closed',
            'type',
            'prorated_revenue',
            'user_id',
            'phone',
          ],
        }
      });

      log('Response: $response');
      if (response != null) {
        leadsList = List<Map<String, dynamic>>.from(response);
        // Conditionally filter activitiesList based on "My Activities" selection
        if (hasMyActivities) {
          activitiesList = leadsList
              .where((lead) =>
          lead['activity_user_id'] != null &&
              lead['activity_user_id'] is List &&
              lead['activity_user_id'].isNotEmpty &&
              lead['activity_user_id'][0] == userid)
              .toList();
        } else {
          activitiesList = leadsList; // Use all leads from the filtered leadsList
        }
        if(savetoIsar) {
          await isar.writeTxn(() async {
            print('Clearing Newpipe collection');
            await isar.newacts.clear();

            for (var lead in activitiesList) {
              try {
                if (lead['id'] == null) {
                  print('Skipping lead with null ID: $lead');
                  continue;
                }


                final newpipe = Newact()
                  ..leadId = lead['id']
                  ..name = lead['name']?.toString()
                  ..type = lead['type']?.toString()
                  ..expectedRevenue = lead['expected_revenue'] is double
                      ? lead['expected_revenue']
                      : (lead['expected_revenue'] is int
                      ? lead['expected_revenue'].toDouble()
                      : 0.0)
                  ..stageId = lead['stage_id'] is List &&
                      lead['stage_id'].isNotEmpty ? [lead['stage_id'][0]] : null
                  ..stageName = lead['stage_id'] is List &&
                      lead['stage_id'].length > 1 ? lead['stage_id'][1]
                      ?.toString() : null
                  ..partnerId = lead['partner_id'] is List &&
                      lead['partner_id'].isNotEmpty
                      ? [lead['partner_id'][0]]
                      : null
                  ..partnerName = lead['partner_id'] is List &&
                      lead['partner_id'].length > 1 ? lead['partner_id'][1]
                      ?.toString() : null
                  ..tagIds = lead['tag_ids'] is List ? List<int>.from(
                      lead['tag_ids']) : null
                  ..priority = lead['priority']?.toString() ??
                      '0' // Store as string ('0', '1', '2')
                  ..activityState = lead['activity_state']?.toString()
                  ..activityTypeId = lead['activity_type_id'] is List &&
                      lead['activity_type_id'].isNotEmpty ? [
                    lead['activity_type_id'][0]
                  ] : null
                  ..activityTypeName = lead['activity_type_id'] is List &&
                      lead['activity_type_id'].length > 1
                      ? lead['activity_type_id'][1]?.toString()
                      : null
                  ..emailFrom = lead['email_from']?.toString()
                  ..recurringRevenueMonthly = lead['recurring_revenue_monthly'] is double
                      ? lead['recurring_revenue_monthly']
                      : (lead['recurring_revenue_monthly'] is int
                      ? lead['recurring_revenue_monthly'].toDouble()
                      : null)
                  ..contactName = lead['contact_name']?.toString()
                  ..activityIds = lead['activity_ids'] is List ? List<int>.from(
                      lead['activity_ids']) : null
                  ..activityDateDeadline = lead['activity_date_deadline']
                      ?.toString()
                  ..createDate = lead['create_date']?.toString()
                  ..dayOpen = lead['day_open'] is double
                      ? lead['day_open']
                      : (lead['day_open'] is int
                      ? lead['day_open'].toDouble()
                      : null)
                  ..dayClose = lead['day_close'] is double
                      ? lead['day_close']
                      : (lead['day_close'] is int
                      ? lead['day_close'].toDouble()
                      : null)
                  ..probability = lead['probability'] is double
                      ? lead['probability']
                      : (lead['probability'] is int ? lead['probability']
                      .toDouble() : null)
                  ..recurringRevenueMonthlyProrated = lead['recurring_revenue_monthly_prorated'] is double
                      ? lead['recurring_revenue_monthly_prorated']
                      : (lead['recurring_revenue_monthly_prorated'] is int
                      ? lead['recurring_revenue_monthly_prorated'].toDouble()
                      : null)
                  ..recurringRevenueProrated = lead['recurring_revenue_prorated'] is double
                      ? lead['recurring_revenue_prorated']
                      : (lead['recurring_revenue_prorated'] is int
                      ? lead['recurring_revenue_prorated'].toDouble()
                      : null)
                  ..proratedRevenue = lead['prorated_revenue'] is double
                      ? lead['prorated_revenue']
                      : (lead['prorated_revenue'] is int
                      ? lead['prorated_revenue'].toDouble()
                      : null)
                  ..recurringRevenue = lead['recurring_revenue'] is double
                      ? lead['recurring_revenue']
                      : (lead['recurring_revenue'] is int
                      ? lead['recurring_revenue'].toDouble()
                      : null)
                  ..activityUserId = lead['activity_user_id'] is List &&
                      lead['activity_user_id'].isNotEmpty ? [
                    lead['activity_user_id'][0]
                  ] : null
                  ..dateClosed = lead['date_closed']?.toString()
                  ..userId = lead['user_id'] is int
                      ? lead['user_id'] as int?
                      : (lead['user_id'] is List && lead['user_id'].isNotEmpty
                      ? lead['user_id'][0] as int?
                      : null)
                  ..phone = lead['phone']?.toString();
                await isar.newacts.put(newpipe);
                print('Saved lead ID: ${lead['id']}');
              } catch (e) {
                print('Error saving lead ID: ${lead['id']}, Error: $e');
                print('Lead data: $lead');
              }
            }
          });
        }

        Map<String, List<Map<String, dynamic>>> groupedLeads = {};

        for (var lead in activitiesList) {
          String stage = lead['stage_id'] is List && lead['stage_id'].length > 1
              ? lead['stage_id'][1]
              : 'Unknown';
          List<String> tagNames = [];
          if (lead['tag_ids'] != null && lead['tag_ids'] is List) {
            for (var tagId in lead['tag_ids']) {
              if (tagMap.containsKey(tagId)) {
                tagNames.add(tagMap[tagId]!);
              }
            }
          }
          groupedLeads.putIfAbsent(stage, () => []).add(lead);
        }

        controller.clear();

        for (var entry in groupedLeads.entries) {
          final groupData = AppFlowyGroupData(
            id: entry.key,
            name: entry.key,
            items: entry.value.map((lead) {
              List<String> tagNames = [];
              if (lead['tag_ids'] != null && lead['tag_ids'] is List) {
                for (var tagId in lead['tag_ids']) {
                  if (tagMap.containsKey(tagId)) {
                    tagNames.add(tagMap[tagId]!);
                  }
                }
              }
              return LeadItem(
                leadId: lead['id'],
                name: lead['name'],
                revenue: lead['expected_revenue'].toString(),
                customerName: lead['partner_id'] != null &&
                    lead['partner_id'] is List &&
                    lead['partner_id'].length > 1
                    ? lead['partner_id'][1]
                    : "None",
                priority: (lead['priority'] is int)
                    ? lead['priority']
                    : int.tryParse(lead['priority'].toString()) ?? 0,
                tags: tagNames,
                activityState: lead['activity_state'] != null
                    ? (lead['activity_state'] is bool
                    ? (lead['activity_state'] ? "true" : "false")
                    : lead['activity_state'].toString())
                    : '',
                activityType: lead['activity_type_id'] != null &&
                    lead['activity_type_id'] is List &&
                    lead['activity_type_id'].length > 1
                    ? lead['activity_type_id'][1]
                    : "",
                hasActivity: lead['activity_ids'] != null &&
                    lead['activity_ids'] is List &&
                    lead['activity_ids'].isNotEmpty,
                activityIds: lead['activity_ids'] != null && lead['activity_ids'] is List
                    ? List<String>.from(lead['activity_ids'].map((e) => e.toString()))
                    : [],
                salespersonId: lead['user_id'] != null && // Added this
                    lead['user_id'] is List &&
                    lead['user_id'].length > 0
                    ? lead['user_id'][0]
                    : null,
                imageData: profileImage != null ? base64Encode(profileImage!) : null,
              );
            }).toList(),
          );

          controller.addGroup(groupData);
        }

        if (activitiesList.isNotEmpty) {
          Map<String, double> stageValues = {};

          for (var item in activitiesList) {
            if (item['stage_id'] != null &&
                item['stage_id'] is List &&
                item['stage_id'].length > 1) {
              String stageName = item['stage_id'][1].toString();
              double value;
              if (selectedFilter == "count") {
                value = (stageValues[stageName] ?? 0) + 1;
              } else if (selectedFilter == "day_open" && item['day_open'] != false) {
                value = (stageValues[stageName] ?? 0) + (item['day_open'] as double);
              } else if (selectedFilter == "day_close" && item['day_close'] != false) {
                value = (stageValues[stageName] ?? 0) + (item['day_close'] as double);
              } else if (selectedFilter == "recurring_revenue_monthly" &&
                  item['recurring_revenue_monthly'] != false) {
                value = (stageValues[stageName] ?? 0) + (item['recurring_revenue_monthly'] as double);
              } else if (selectedFilter == "expected_revenue" && item['expected_revenue'] != false) {
                value = (stageValues[stageName] ?? 0) + (item['expected_revenue'] as double);
              } else if (selectedFilter == "probability" && item['probability'] != false) {
                value = (stageValues[stageName] ?? 0) + (item['probability'] as double);
              } else if (selectedFilter == "recurring_revenue_monthly_prorated" && item['recurring_revenue_monthly_prorated'] != false) {
                value = (stageValues[stageName] ?? 0) + (item['recurring_revenue_monthly_prorated'] as double);
              } else if (selectedFilter == "recurring_revenue_prorated" && item['recurring_revenue_prorated'] != false) {
                value = (stageValues[stageName] ?? 0) + (item['recurring_revenue_prorated'] as double);
              } else if (selectedFilter == "prorated_revenue" && item['prorated_revenue'] != false) {
                value = (stageValues[stageName] ?? 0) + (item['prorated_revenue'] as double);}
              else if (selectedFilter == "recurring_revenue" && item['recurring_revenue'] != false) {
                value = (stageValues[stageName] ?? 0) + (item['recurring_revenue'] as double);
              }
              else {
                value = 0;
              }
              stageValues[stageName] = value;
            }
          }

          setState(() {
            chartDatavalues.clear();

            Set<String> stageOrderSet = stageValues.keys.toSet();
            List<String> stageOrder = stageOrderSet.toList();
            List<ChartData> sortedData = stageOrder
                .where((stage) => stageValues.containsKey(stage))
                .map((stage) => ChartData(stage, stageValues[stage]!))
                .toList();

            chartDatavalues = sortedData;

            if (stageOrder.isEmpty || sortedData.every((data) => data.y == 0)) {
              showNoDataMessage = true;
            } else {
              showNoDataMessage = false;
            }

            isLoading = false;
          });
        } else {
          setState(() {
            chartDatavalues.clear();
            showNoDataMessage = true;
            isLoading = false;
          });
        }
      }
    } catch (e) {
      print("Odoo Fetch Failed: $e");
      setState(() {
        isLoading = false;
        showNoDataMessage = true;
      });
    }
  }
  Widget ChartSelection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        width: double.infinity,
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
                  Icons.calendar_month,
                  color: selectedView == 2 ? Color(0xFF9EA700) : Colors.black,
                ),
              ),
              // VerticalDivider(thickness: 2, color: Colors.white),
              // IconButton(
              //   onPressed: () {
              //     setState(() {
              //       selectedView = 3;
              //     });
              //   },
              //   icon: Icon(
              //     Icons.table_rows_outlined,
              //     color: selectedView == 3 ? Color(0xFF9EA700) : Colors.black,
              //   ),
              // ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedView = 4;
                  });
                },
                icon: Icon(
                  Icons.graphic_eq_rounded,
                  color: selectedView == 4 ? Color(0xFF9EA700) : Colors.black,
                ),
              ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedView = 5;
                  });
                },
                icon: Icon(
                  Icons.access_time,
                  color: selectedView == 5 ? Color(0xFF9EA700) : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void openEmail(BuildContext context, Map<String, dynamic> lead) {
    if (lead['email_from'] != null && lead['email_from'].toString().isNotEmpty) {
      final Uri params = Uri(
        scheme: 'mailto',
        path: lead['email_from'].toString(),
        query:
        'subject=Email Regarding Your Inquiry&body=Hi,\n\nPlease let me know if you need more information about the product.\n\nBest regards,\n[Name,Mobile]',
      );
      final url = params.toString();
      launchUrlString(url);
    } else {
      var snackBar = SnackBar(content: Text('Email not Found'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
  void openMessage(BuildContext context, Map<String, dynamic> lead) async {
    if (lead['phone'] != null && lead['phone'].toString().isNotEmpty) {
      final Uri params = Uri(
        scheme: 'sms',
        path: lead['phone'].toString(),
        queryParameters: {
          'body': 'Hello, I\'m following up on your recent inquiry. How can I assist you today?'
        },
      );
      final url = params.toString();
      await launchUrlString(url);
    } else {
      var snackBar = SnackBar(content: Text('Number not Found'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }


  Widget listCard() {
    return activitiesList.isEmpty
        ? Center(
      child: Text(
        "No activities found",
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    )
        : ListView.builder(
      itemCount: activitiesList.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final lead = activitiesList[index];
        final leadId = lead['id'];
        final name = lead['name'] ?? '';
        final revenue = lead['expected_revenue']?.toString() ?? '';
        final customerName = lead['contact_name'] == false
            ? 'None'
            : lead['contact_name']?.toString() ?? 'None';
        final email = lead['email_from'] ?? 'None';
        final stageName = lead['stage_id'] != null &&
            lead['stage_id'] is List &&
            lead['stage_id'].length > 1
            ? lead['stage_id'][1]
            : "None";
        final salesperson = lead['activity_user_id'] != null &&
            lead['activity_user_id'] is List &&
            lead['activity_user_id'].length > 1
            ? lead['activity_user_id'][1]
            : "None";
        final mrr = lead['recurring_revenue_monthly'] ?? 'None';
        final hasActivity = lead['activity_ids'] != null &&
            lead['activity_ids'] is List &&
            lead['activity_ids'].isNotEmpty;
        final activityState =
            lead['activity_state']?.toString().toLowerCase() ?? 'None';

        Color stageColor;
        if (stageName.toLowerCase().contains('new')) {
          stageColor = Colors.red.shade200;
        } else if (stageName.toLowerCase().contains('qualified')) {
          stageColor = Colors.orange.shade200;
        } else if (stageName.toLowerCase().contains('proposition')) {
          stageColor = Colors.blue.shade200;
        } else if (stageName.toLowerCase().contains('won')) {
          stageColor = Colors.green.shade200;
        } else {
          stageColor = Colors.purple.shade200;
        }

        return isLoading
            ? Center(
          child: LoadingAnimationWidget.fourRotatingDots(
            color: Color(0xFF9EA700),
            size: 100,
          ),
        )
            : GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Activityview(leadId: leadId),
              ),
            );
          },
              child: Card(
                        color: Colors.white,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                        child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
                color: Color(0x69EA700),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: stageColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: stageColor.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: Offset(0, 2))
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: stageColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: stageColor, width: 1.5),
                          ),
                          child: Text(
                            stageName,
                            style: TextStyle(
                              color: stageColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                        height: 24,
                        thickness: 1,
                        color: Colors.grey.shade200),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border:
                        Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Contact',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  customerName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Colors.grey.shade900,
                                  ),
                                ),
                                SizedBox(height: 4),
                                email.isNotEmpty
                                    ? Row(
                                  children: [
                                    Icon(Icons.email_outlined,
                                        size: 14,
                                        color: Colors.blue),
                                    SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        email,
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 13,
                                        ),
                                        overflow: TextOverflow
                                            .ellipsis,
                                      ),
                                    ),
                                  ],
                                )
                                    : SizedBox(),
                                SizedBox(height: 16),
                                Text(
                                  'Assigned User',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    profileImage != null
                                        ? Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius
                                            .circular(6),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black
                                                .withOpacity(
                                                0.1),
                                            blurRadius: 4,
                                            offset:
                                            Offset(0, 2),
                                          ),
                                        ],
                                        image: DecorationImage(
                                          image: MemoryImage(
                                              profileImage!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                        : Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius
                                            .circular(6),
                                        gradient:
                                        LinearGradient(
                                          colors: [
                                            Colors
                                                .blue.shade700,
                                            Colors.blue.shade500
                                          ],
                                          begin:
                                          Alignment.topLeft,
                                          end: Alignment
                                              .bottomRight,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.blue
                                                .withOpacity(
                                                0.3),
                                            blurRadius: 4,
                                            offset:
                                            Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Icon(Icons.person,
                                          size: 18,
                                          color: Colors.white),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        userName ?? 'Loading...',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Expected Revenue',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF9EA700)
                                        .withOpacity(0.15),
                                    borderRadius:
                                    BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '\$${revenue}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF9EA700),
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Expected MRR',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF9EA700)
                                        .withOpacity(0.15),
                                    borderRadius:
                                    BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '\$${mrr}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF9EA700),
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          icon: Icon(
                            Icons.email_outlined,
                            size: 16,
                            color: Colors.black,
                          ),
                          label: Text('Email'),
                          onPressed: () {
                            openEmail(context, lead);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            Color(0xFF9EA700).withOpacity(0.15),
                            foregroundColor: Color(0xFF9EA700),
                            elevation: 0,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        ElevatedButton.icon(
                          icon: Icon(
                            Icons.message_outlined,
                            size: 16,
                            color: Colors.black,
                          ),
                          label: Text('Message'),
                          onPressed: () {
                            openMessage(context, lead);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            Color(0xFF9EA700).withOpacity(0.15),
                            foregroundColor: Color(0xFF9EA700),
                            elevation: 0,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        if (hasActivity)
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: Icon(
                                Icons.snooze_rounded,
                                size: 16,
                                color: Colors.black,
                              ),
                              label: Text(
                                'Snooze 7d',
                                overflow: TextOverflow.ellipsis,
                              ),
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                Colors.grey.withOpacity(0.15),
                                foregroundColor: Colors.grey,
                                elevation: 0,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
                        ),
                      ),
            );
      },
    );
  }
  void _showAddLeadDialog(BuildContext context, AppFlowyGroupData columnData) {
    final TextEditingController organizationController = TextEditingController();
    final TextEditingController opportunityController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController revenueController = TextEditingController();
    String? selectedFrequency; // Maps to recurring_plan
    final TextEditingController recurringRevenueController = TextEditingController(text: "0.00");

    // Fetch partners for the dropdown
    List<Map<String, dynamic>> partners = [];
    Future<void> fetchPartners() async {
      if (client != null) {
        try {
          final response = await client!.callKw({
            'model': 'res.partner',
            'method': 'search_read',
            'args': [],
            'kwargs': {
              'fields': ['id', 'name'],
              'limit': 50,
            },
          });
          if (response != null) {
            partners = List<Map<String, dynamic>>.from(response);
          }
        } catch (e) {
          log("Failed to fetch partners: $e");
        }
      }
    }

    // Fetch recurring plans for the dropdown
    List<Map<String, dynamic>> recurringPlans = [];
    Future<void> fetchRecurringPlans() async {
      if (client != null) {
        try {
          final response = await client!.callKw({
            'model': 'crm.recurring.plan',
            'method': 'search_read',
            'args': [],
            'kwargs': {
              'fields': ['id', 'name'],
              'limit': 50,
            },
          });
          if (response != null) {
            recurringPlans = List<Map<String, dynamic>>.from(response);
          }
        } catch (e) {
          log("Failed to fetch recurring plans: $e");
        }
      }
    }

    // Initialize data
    fetchPartners();
    fetchRecurringPlans();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        int starRating = 0; // Local state for star rating
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            width: 300,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: SingleChildScrollView(
              child: FutureBuilder(
                future: Future.wait([fetchPartners(), fetchRecurringPlans()]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Organization/Contact Field with dropdown
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Organization / Contact",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    " ?",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Container(
                                height: 40,
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(color: Colors.grey.shade300),
                                    ),
                                  ),
                                  items: partners.map((partner) {
                                    return DropdownMenuItem<String>(
                                      value: partner['id'].toString(),
                                      child: Text(partner['name'] ?? ''),
                                    );
                                  }).toList(),
                                  value: organizationController.text.isNotEmpty
                                      ? organizationController.text
                                      : null,
                                  onChanged: (value) {
                                    setState(() {
                                      organizationController.text = value ?? '';
                                    });
                                  },
                                  isExpanded: true,
                                  icon: Icon(Icons.arrow_drop_down),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),

                          // Opportunity Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Opportunity",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                height: 40,
                                child: TextField(
                                  controller: opportunityController,
                                  decoration: InputDecoration(
                                    hintText: "e.g. Product Pricing",
                                    hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(color: Colors.grey.shade300),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),

                          // Email Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                height: 40,
                                child: TextField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    hintText: 'e.g. "email@address.com"',
                                    hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(color: Colors.grey.shade300),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),

                          // Phone Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Phone",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                height: 40,
                                child: TextField(
                                  controller: phoneController,
                                  decoration: InputDecoration(
                                    hintText: 'e.g. "0123456789"',
                                    hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(color: Colors.grey.shade300),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),

                          // Expected Revenue and Priority (Star Rating) Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Expected Revenue",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 40,
                                      child: TextField(
                                        controller: revenueController,
                                        decoration: InputDecoration(
                                          hintText: "0.00",
                                          hintStyle: TextStyle(color: Colors.black87),
                                          prefixIcon: Text(
                                            "\$ ",
                                            style: TextStyle(fontSize: 16, color: Colors.black87),
                                            textAlign: TextAlign.center,
                                          ),
                                          prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                          contentPadding: EdgeInsets.only(left: 12, top: 10, bottom: 10),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(4),
                                            borderSide: BorderSide(color: Colors.grey.shade300),
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  // Star Rating (Priority)
                                  Row(
                                    children: List.generate(3, (index) {
                                      return IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                        icon: Icon(
                                          index < starRating ? Icons.star : Icons.star_border,
                                          color: index < starRating ? Colors.amber : Colors.grey,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            starRating = index + 1;
                                          });
                                        },
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 8),

                          // Frequency (Recurring Plan) and Recurring Revenue Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Frequency",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Container(
                                    width: 120,
                                    height: 40,
                                    child: TextField(
                                      controller: recurringRevenueController,
                                      enabled: selectedFrequency != null, // Enable only when frequency is selected
                                      decoration: InputDecoration(
                                        hintText: "0.00",
                                        hintStyle: TextStyle(color: Colors.black87),
                                        prefixIcon: Text(
                                          "\$ ",
                                          style: TextStyle(fontSize: 16, color: Colors.black87),
                                          textAlign: TextAlign.center,
                                        ),
                                        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                        contentPadding: EdgeInsets.only(left: 12, top: 10, bottom: 10),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(4),
                                          borderSide: BorderSide(color: Colors.grey.shade300),
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Container(
                                      height: 40,
                                      child: DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(4),
                                            borderSide: BorderSide(color: Colors.grey.shade300),
                                          ),
                                        ),
                                        items: recurringPlans.map((plan) {
                                          return DropdownMenuItem<String>(
                                            value: plan['id'].toString(),
                                            child: Text(plan['name'] ?? ''),
                                          );
                                        }).toList(),
                                        value: selectedFrequency,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedFrequency = value;
                                            if (value != null && recurringRevenueController.text == "0.00") {
                                              // Only set initial value if recurringRevenueController is still default
                                              recurringRevenueController.text = revenueController.text.replaceAll('\$', '').trim().isNotEmpty
                                                  ? revenueController.text.replaceAll('\$', '').trim()
                                                  : "0.00";
                                            }
                                          });
                                        },
                                        isExpanded: true,
                                        icon: Icon(Icons.arrow_drop_down),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 16),

                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    // Fetch stage_id based on group name
                                    int? stageId = await _getStageId(columnData.headerData.groupName);
                                    if (stageId == null) {
                                      log("Stage not found for name: ${columnData.headerData.groupName}");
                                      return;
                                    }

                                    // Map star rating to Odoo priority values
                                    String priorityValue;
                                    switch (starRating) {
                                      case 1:
                                        priorityValue = '0'; // Low
                                        break;
                                      case 2:
                                        priorityValue = '1'; // Medium
                                        break;
                                      case 3:
                                        priorityValue = '2'; // High
                                        break;
                                      default:
                                        priorityValue = '0'; // Default to Low
                                    }

                                    // Handle the addition of the new lead
                                    final newLead = {
                                      'name': opportunityController.text,
                                      'expected_revenue': double.tryParse(revenueController.text.replaceAll('\$', '').trim()) ?? 0.0,
                                      'email_from': emailController.text,
                                      'phone': phoneController.text,
                                      'partner_id': int.tryParse(organizationController.text) ?? false,
                                      'priority': priorityValue, // Use string value for priority
                                      'recurring_plan': int.tryParse(selectedFrequency ?? '') ?? false,
                                      'recurring_revenue': selectedFrequency != null
                                          ? double.tryParse(recurringRevenueController.text) ?? 0.0
                                          : 0.0,
                                      'stage_id': stageId,
                                      'activity_user_id': [currentUserId ?? 0, userName ?? ''],
                                      'type': 'opportunity',
                                    };
                                    log('New Lead: $newLead');
                                    final response = await _addLeadToOdoo(newLead);
                                    Navigator.pop(context); // Close the dialog after adding
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFAFBA00),
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  child: Text(
                                    "Add",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () async {
                                  // Check if any field has a value
                                  bool hasValue = opportunityController.text.isNotEmpty ||
                                      emailController.text.isNotEmpty ||
                                      phoneController.text.isNotEmpty ||
                                      revenueController.text.isNotEmpty ||
                                      organizationController.text.isNotEmpty ||
                                      selectedFrequency != null ||
                                      recurringRevenueController.text != "0.00";

                                  if (hasValue) {
                                    // Fetch stage_id based on group name
                                    int? stageId = await _getStageId(columnData.headerData.groupName);
                                    if (stageId == null) {
                                      log("Stage not found for name: ${columnData.headerData.groupName}");
                                      return;
                                    }

                                    // Map star rating to Odoo priority values
                                    String priorityValue;
                                    switch (starRating) {
                                      case 1:
                                        priorityValue = '0'; // Low
                                        break;
                                      case 2:
                                        priorityValue = '1'; // Medium
                                        break;
                                      case 3:
                                        priorityValue = '2'; // High
                                        break;
                                      default:
                                        priorityValue = '0'; // Default to Low
                                    }

                                    // Handle the addition of the new lead
                                    final newLead = {
                                      'name': opportunityController.text,
                                      'expected_revenue': double.tryParse(revenueController.text.replaceAll('\$', '').trim()) ?? 0.0,
                                      'email_from': emailController.text,
                                      'phone': phoneController.text,
                                      'partner_id': int.tryParse(organizationController.text) ?? false,
                                      'priority': priorityValue, // Use string value for priority
                                      'recurring_plan': int.tryParse(selectedFrequency ?? '') ?? false,
                                      'recurring_revenue': selectedFrequency != null
                                          ? double.tryParse(recurringRevenueController.text) ?? 0.0
                                          : 0.0,
                                      'stage_id': stageId,
                                      'activity_user_id': [currentUserId ?? 0, userName ?? ''],
                                      'type': 'opportunity',
                                    };
                                    log('New Lead: $newLead');
                                    final response = await _addLeadToOdoo(newLead);
                                    if (response != null) {
                                      // Navigate to LeadDetailPage with the leadId
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LeadDetailPage(leadId: response as int),
                                        ),
                                      );
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade200,
                                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                ),
                                child: Text(
                                  "Edit",
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                              SizedBox(width: 8),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
// Method to fetch stage_id based on stage name
  Future<int?> _getStageId(String stageName) async {
    if (client == null) return null;
    try {
      final response = await client!.callKw({
        'model': 'crm.stage',
        'method': 'search_read',
        'args': [
          [['name', '=', stageName]]
        ],
        'kwargs': {
          'fields': ['id'],
          'limit': 1,
        },
      });
      if (response != null && response.isNotEmpty) {
        return response[0]['id'] as int?;
      }
      return null;
    } catch (e) {
      log("Failed to fetch stage_id: $e");
      return null;
    }
  }
  Future<int?> _addLeadToOdoo(Map<String, dynamic> leadData) async {
    if (client == null) return  null;

    try {
      final response = await client!.callKw({
        'model': 'crm.lead',
        'method': 'create',
        'args': [leadData],
        'kwargs': {},
      });
      print('Lead created: $response');
      await pipe(); // Refresh the data
      setState(() {});
      return response as int?;
    } catch (e) {
      log("Failed to create lead: $e");
    }
  }

  Widget iconSelectedView() {
    final config = AppFlowyBoardConfig(
      groupBackgroundColor: Colors.grey.shade100,
      stretchGroupHeight: false,
    );
    switch (selectedView) {
      case 0:
        return AppFlowyBoard(
            controller: controller,
            cardBuilder: (context, group, groupItem) {
              return AppFlowyGroupCard(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                key: ValueKey(groupItem.id),
                child: customCard(groupItem),
              );
            },
            boardScrollController: boardController,
            footerBuilder: (context, columnData) {
              return AppFlowyGroupFooter(
                height: 50,
                margin: config.groupBodyPadding,
                onAddButtonClick: () {
                  boardController.scrollToBottom(columnData.id);
                },
              );
            },
            headerBuilder: (context, columnData) {
              return AppFlowyGroupHeader(
                icon: const Icon(Icons.lightbulb_circle),
                title: SizedBox(
                  width: 60,
                  child: TextField(
                    controller: TextEditingController()
                      ..text = columnData.headerData.groupName,
                    onSubmitted: (val) {
                      controller
                          .getGroupController(columnData.headerData.groupId)!
                          .updateGroupName(val);
                    },
                  ),
                ),
                addIcon: const Icon(Icons.add, size: 20),
                onAddButtonClick:() {
                  _showAddLeadDialog(context, columnData);
                },
                moreIcon: const Icon(Icons.more_horiz, size: 20),
                height: 50,
                margin: config.groupBodyPadding,
              );
            },
            groupConstraints: const BoxConstraints.tightFor(width: 240),
            config: config);
      case 1:
        return listCard();
      case 2:
        return calendarView();
      case 3:
        return fetchData();
      case 4:
        return buildChart();
      case 5:
        return SalesDataGridWidget(
          opportunitiesList: activitiesList,
          activityTypes: activityTypes,
        );
      default:
        return Container();
    }
  }

  Widget calendarView() {
    List<Appointment> appointments = [];
    Map<String, Map<String, dynamic>> appointmentLeadMap = {};

    for (var lead in activitiesList) {
      if (lead['activity_date_deadline'] != null && lead['activity_date_deadline'] != false) {
        DateTime deadlineDate;
        try {
          if (lead['activity_date_deadline'] is String) {
            deadlineDate = DateTime.parse(lead['activity_date_deadline']);
          } else {
            deadlineDate = lead['activity_date_deadline'];
          }

          String appointmentId = "${lead['id']}_${deadlineDate.toString()}";

          appointments.add(
            Appointment(
              startTime: deadlineDate,
              endTime: deadlineDate.add(Duration(hours: 1)),
              subject: lead['name'] ?? 'No Title',
              color: Color(0xFF9EA700),
              isAllDay: true,
              id: appointmentId,
            ),
          );
          appointmentLeadMap[appointmentId] = lead;
        } catch (e) {
          print('Error parsing deadline date: $e');
        }
      }
    }

    return Container(
      child: SfCalendar(
        view: CalendarView.month,
        headerStyle: CalendarHeaderStyle(backgroundColor: Color(0x69EA700)),
        dataSource: AppointmentDataSource(appointments),
        monthViewSettings: MonthViewSettings(
          showAgenda: true,
          agendaViewHeight: 200,
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        ),
        todayHighlightColor: Color(0xFF9EA700),
        selectionDecoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Color(0xFF9EA700), width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          shape: BoxShape.rectangle,
        ),
        onTap: (CalendarTapDetails details) {
          if (details.targetElement == CalendarElement.appointment) {
            Appointment appointment = details.appointments![0];
            String appointmentId = appointment.id.toString();

            if (appointmentLeadMap.containsKey(appointmentId)) {
              calendarDialogue(context, appointmentLeadMap[appointmentId]!);
            }
          }
        },
      ),
    );
  }
  Future<void> deleteLead(int leadId) async {
    try {
      if (client == null) {
        throw Exception('Odoo client is not initialized');
      }

      // Call the unlink method on crm.lead model
      final response = await client!.callKw({
        'model': 'crm.lead',
        'method': 'unlink',
        'args': [
          [leadId] // Array of IDs to delete
        ],
        'kwargs': {},
      });

      print('Lead deletion response: $response');
    } catch (e) {
      throw Exception('Failed to delete lead: $e');
    }
  }

  void calendarDialogue(BuildContext context, Map<String, dynamic> lead){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text(
            'Opportunity Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF9EA700),
            ),
          ),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4),
                Text(
                  lead['name'] ?? 'None ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Expected Revenue',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '\$${lead['expected_revenue']?.toString() ?? '0.00'}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF9EA700),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Customer',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  lead['partner_id'] != null &&
                      lead['partner_id'] is List &&
                      lead['partner_id'].length > 1
                      ? lead['partner_id'][1]
                      : 'None',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Activity Deadline',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  lead['activity_date_deadline'] != null && lead['activity_date_deadline'] != false
                      ? lead['activity_date_deadline'] is DateTime
                      ? lead['activity_date_deadline'].toString().split(' ')[0]
                      : lead['activity_date_deadline'].toString()
                      : 'No deadline',
                  style: TextStyle(
                    fontSize: 16,
                    color: lead['activity_state'] == 'overdue' ? Colors.red : null,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.edit, size: 16, color: Colors.black,),
                  label: Text('Edit'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LeadDetailPage(leadId: lead["id"]),

                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Color(0xFF9EA700),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.delete, size: 16,color: Colors.black,),
                  label: Text('Delete'),
                  onPressed: () async{
                    bool? confirmDelete = await showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Bye-bye, record!',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.close, size: 20),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ],
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ready to make your record disappear into thin air? Are you sure?',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'It will be gone forever!',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Think twice before you click that \'Delete\' button!',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true); // Confirm delete
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF9EA700), // Green color for Delete
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text('Delete'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false); // Cancel
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                  child: Text('No, keep it'),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );

                    // If user confirmed deletion
                    if (confirmDelete == true) {
                      try {
                        await deleteLead(lead['id']); // Delete the lead in Odoo
                        Navigator.of(context).pop(); // Close the details dialog

                        // Refresh the leads list by calling pipe()
                        setState(() => isLoading = true);
                        await pipe();
                        setState(() => isLoading = false);

                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Lead deleted successfully')),
                        );
                      } catch (e) {
                        // Show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error deleting lead: $e')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Colors.grey[200],
                    foregroundColor: Color(0xFF9EA700),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }


  Widget ActivityIconDesign(String activityState, String activityType) {
    IconData iconData;
    Color iconColor;
    if (activityType.isEmpty) {
      iconData = Icons.access_time;
    } else if (activityType.toLowerCase().contains('call') ||
        activityType.toLowerCase().contains('phone')) {
      iconData = Icons.phone_outlined;
    } else if (activityType.toLowerCase().contains('email') ||
        activityType.toLowerCase().contains('mail')) {
      iconData = Icons.email_outlined;
    } else if (activityType.toLowerCase().contains('meeting')) {
      iconData = Icons.event;
    } else if (activityType.toLowerCase().contains('todo')) {
      iconData = Icons.check_circle;
    } else {
      iconData = Icons.calendar_today;
    }

    if (activityState == 'overdue') {
      iconColor = Colors.red;
    } else if (activityState == 'today') {
      iconColor = Colors.orange;
    } else if (activityState == 'planned') {
      iconColor = Colors.green;
    } else {
      iconColor = Colors.grey;
    }

    if (activityState.isEmpty) {
      return SizedBox();
    }

    return Container(
      child: Icon(
        iconData,
        size: 16,
        color: iconColor,
      ),
    );
  }

  Widget fetchData() {
    if (activitiesList.isEmpty) {
      return Center(child: Text("No data available"));
    }

    Set<String> uniqueStages = {};
    Map<String, Map<String, dynamic>> groupedData = {};
    Map<String, double> columnTotals = {};

    for (var lead in activitiesList) {
      String stage = (lead['stage_id'] is List && lead['stage_id'].length > 1)
          ? lead['stage_id'][1]
          : 'Unknown';
      if (!uniqueStages.contains(stage)) {
        uniqueStages.add(stage);
      }
      String date = lead['create_date'] ?? "None";
      String formattedDate = formatDate(date);
      double revenue = double.tryParse(lead['expected_revenue']?.toString() ?? "0") ?? 0.0;

      if (!groupedData.containsKey(formattedDate)) {
        groupedData[formattedDate] = {'date': formattedDate};
      }

      groupedData[formattedDate]![stage] =
          ((double.tryParse(groupedData[formattedDate]![stage]?.toString() ?? "0") ?? 0.0) + revenue).toString();
      columnTotals[stage] = (columnTotals[stage] ?? 0.0) + revenue;
    }

    List<GridColumn> columns = [
      GridColumn(
        columnName: 'date',
        label: Container(
          alignment: Alignment.center,
          child: Text(
            '',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      ...uniqueStages.map(
            (stage) => GridColumn(
          columnName: stage,
          label: Container(
            alignment: Alignment.center,
            child: Text(
              stage,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    ];

    List<DataGridRow> rows = groupedData.entries.map((entry) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(columnName: 'date', value: entry.value['date']),
          ...uniqueStages.map(
                (stage) => DataGridCell<String>(
              columnName: stage,
              value: entry.value[stage] ?? "0",
            ),
          ),
        ],
      );
    }).toList();

    rows.add(DataGridRow(
      cells: [
        DataGridCell<String>(columnName: 'date', value: "Total"),
        ...uniqueStages.map(
              (stage) => DataGridCell<String>(
            columnName: stage,
            value: columnTotals[stage]?.toStringAsFixed(2) ?? "0",
          ),
        ),
      ],
    ));

    return SfDataGrid(
      source: tableSource(rows),
      columns: columns,
      columnWidthMode: ColumnWidthMode.fill,
    );
  }

  Widget buildChart() {
    if (selectedChart == "bar") {
      return showNoDataMessage
          ? Column(
        children: [
          Center(child: Image.asset('assets/nodata.png')),
          Text(
            "No data to display",
            style: TextStyle(color: Colors.blueGrey),
          ),
        ],
      )
          : SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <CartesianSeries<ChartData, String>>[
          ColumnSeries<ChartData, String>(
            dataSource: chartDatavalues,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            color: Color(0xFF9EA700),
          ),
        ],
      );
    } else if (selectedChart == "line") {
      return showNoDataMessage
          ? Column(
        children: [
          Center(child: Image.asset('assets/nodata.png')),
          Text(
            "No data to display",
            style: TextStyle(color: Colors.blueGrey),
          ),
        ],
      )
          : SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <CartesianSeries<ChartData, String>>[
          LineSeries<ChartData, String>(
            dataSource: chartDatavalues,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            color: Color(0xFF9EA700),
          ),
        ],
      );
    } else {
      return showNoDataMessage
          ? Column(
        children: [
          Center(child: Image.asset('assets/nodata.png')),
          Text(
            "No data to display",
            style: TextStyle(color: Colors.blueGrey),
          ),
        ],
      )
          : SfCircularChart(
        legend: Legend(isVisible: true),
        series: <CircularSeries<ChartData, String>>[
          PieSeries<ChartData, String>(
            dataLabelSettings: DataLabelSettings(isVisible: true),
            explode: true,
            dataSource: chartDatavalues,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
          ),
        ],
      );
    }
  }

  void changeChartType(String type) {
    setState(() {
      selectedChart = type;
    });
  }

  void filterOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Select Filter",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                        color: selectedFilter == "count"
                            ? Color(0xFF656805)
                            : Colors.transparent,
                        width: 6,
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(
                      selectedFilter == "count" ? Icons.done : Icons.timelapse,
                      color: Color(0xFF9EA700),
                    ),
                    title: Text('Count'),
                    onTap: () {
                      applyFilter("count", 'Count');
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    tileColor: Color(0x1B9EA700),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                        color: selectedFilter == "day_open"
                            ? Color(0xFF656805)
                            : Colors.transparent,
                        width: 7,
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(
                      selectedFilter == "day_open"
                          ? Icons.done
                          : Icons.timelapse,
                      color: Color(0xFF9EA700),
                    ),
                    title: Text('Days to Assign'),
                    onTap: () {
                      applyFilter("day_open", ' Days to Assign');
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    tileColor: Color(0x1B9EA700),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                        color: selectedFilter == "day_close"
                            ? Color(0xFF656805)
                            : Colors.transparent,
                        width: 7,
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(
                      selectedFilter == "day_close"
                          ? Icons.done
                          : Icons.timelapse,
                      color: Color(0xFF9EA700),
                    ),
                    title: Text('Days to Close'),
                    onTap: () {
                      applyFilter("day_close", 'Days to Close');
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    tileColor: Color(0x1B9EA700),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                        color: selectedFilter == "recurring_revenue_monthly"
                            ? Color(0xFF656805)
                            : Colors.transparent,
                        width: 7,
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(
                      selectedFilter == "recurring_revenue_monthly"
                          ? Icons.done
                          : Icons.timelapse,
                      color: Color(0xFF9EA700),
                    ),
                    title: Text('Expected MRR'),
                    onTap: () {
                      applyFilter("recurring_revenue_monthly", 'Expected MRR');
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    tileColor: Color(0x1B9EA700),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                        color: selectedFilter == "expected_revenue"
                            ? Color(0xFF656805)
                            : Colors.transparent,
                        width: 7,
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(
                      selectedFilter == "expected_revenue"
                          ? Icons.done
                          : Icons.timelapse,
                      color: Color(0xFF9EA700),
                    ),
                    title: Text('Expected Revenue'),
                    onTap: () {
                      applyFilter("expected_revenue", 'Expected Revenue');
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    tileColor: Color(0x1B9EA700),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                        color: selectedFilter == "probability"
                            ? Color(0xFF656805)
                            : Colors.transparent,
                        width: 7,
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(
                      selectedFilter == "probability"
                          ? Icons.done
                          : Icons.timelapse,
                      color: Color(0xFF9EA700),
                    ),
                    title: Text('Probability'),
                    onTap: () {
                      applyFilter("probability", 'Probability');
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    tileColor: Color(0x1B9EA700),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                        color: selectedFilter == "recurring_revenue_monthly_prorated"
                            ? Color(0xFF656805)
                            : Colors.transparent,
                        width: 7,
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(
                      selectedFilter == "recurring_revenue_monthly_prorated"
                          ? Icons.done
                          : Icons.timelapse,
                      color: Color(0xFF9EA700),
                    ),
                    title: Text('Prorated MRR'),
                    onTap: () {
                      applyFilter("recurring_revenue_monthly_prorated", 'Prorated MRR');
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    tileColor: Color(0x1B9EA700),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                        color: selectedFilter == "recurring_revenue_prorated"
                            ? Color(0xFF656805)
                            : Colors.transparent,
                        width: 7,
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(
                      selectedFilter == "recurring_revenue_prorated"
                          ? Icons.done
                          : Icons.timelapse,
                      color: Color(0xFF9EA700),
                    ),
                    title: Text('Prorated Recurring Revenues'),
                    onTap: () {
                      applyFilter("recurring_revenue_prorated", 'Prorated Recurring Revenues');
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    tileColor: Color(0x1B9EA700),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                        color: selectedFilter == "prorated_revenue"
                            ? Color(0xFF656805)
                            : Colors.transparent,
                        width: 7,
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(
                      selectedFilter == "prorated_revenue"
                          ? Icons.done
                          : Icons.timelapse,
                      color: Color(0xFF9EA700),
                    ),
                    title: Text('Prorated Revenue'),
                    onTap: () {
                      applyFilter("prorated_revenue", 'Prorated Revenue');
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    tileColor: Color(0x1B9EA700),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                        color: selectedFilter == "recurring_revenue"
                            ? Color(0xFF656805)
                            : Colors.transparent,
                        width: 7,
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(
                      selectedFilter == "recurring_revenue"
                          ? Icons.done
                          : Icons.timelapse,
                      color: Color(0xFF9EA700),
                    ),
                    title: Text('Recurring Revenues'),
                    onTap: () {
                      applyFilter("recurring_revenue", 'Recurring Revenues');
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    tileColor: Color(0x1B9EA700),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void applyFilter(String filter, String showfilterName) {
    setState(() {
      selectedFilter = filter;
      showVariable = showfilterName;
      isLoading = true;
    });
    pipe();
    Navigator.pop(context);
  }

  Widget buildChartSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Container(
            width: 105,
            height: 30,
            child: ElevatedButton(
              onPressed: () => filterOptions(),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: Color(0xFF9EA700),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text('Measures'),
                  ),
                  Expanded(child: Icon(Icons.arrow_drop_down, color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 150),
        Container(
          height: 37,
          width: 37,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Color(0x279EA700),
          ),
          child: IconButton(
              onPressed: () => changeChartType("bar"),
              icon: Icon(Icons.bar_chart_rounded,
                  color: selectedChart == 'bar' ? Color(0xFF9EA700) : Colors.black)),
        ),
        SizedBox(width: 5),
        Container(
          height: 37,
          width: 37,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Color(0x279EA700)),
          child: IconButton(
              onPressed: () => changeChartType("line"),
              icon: Icon(Icons.stacked_line_chart_rounded,
                  color: selectedChart == 'line' ? Color(0xFF9EA700) : Colors.black)),
        ),
        SizedBox(width: 5),
        Padding(
          padding: EdgeInsets.only(right: 6),
          child: Container(
            height: 37,
            width: 37,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Color(0x279EA700)),
            child: IconButton(
                onPressed: () => changeChartType("pie"),
                icon: Icon(Icons.pie_chart_rounded,
                    color: selectedChart == 'pie' ? Color(0xFF9EA700) : Colors.black)),
          ),
        ),
      ],
    );
  }

  Widget customCard(AppFlowyGroupItem item) {
    if (item is LeadItem) {
      return InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Activityview(leadId: item.leadId),
            ),
          );
        },
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFF9EA700).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '\$${item.revenue}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF9EA700),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      item.customerName,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6),
                    Wrap(
                      spacing: 5,
                      children: item.tags.map((tag) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(tag, style: const TextStyle(fontSize: 12)),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        ...List.generate(
                          3,
                              (index) => Icon(
                            index < item.priority ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 8),
                        ActivityIconDesign(item.activityState, item.activityType),
                        SizedBox(width: 58),
                        OdooAvatar(
                          client: client,
                          model: 'res.users',
                          recordId: item.salespersonId!,
                          size: 24,
                          borderRadius: 5,
                          shape: BoxShape.rectangle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
    throw UnimplementedError();
  }

  @override
  void initState() {
    super.initState();
    selectedFilters = {'my_activities'};
    loadFromIsar();
    initializeOdooClient();
    boardController = AppFlowyBoardScrollController();
    searchController.addListener(_onSearchChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            : const Text("Activities",style: TextStyle(color: Colors.white),),
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
                  pipe(); // Reset to full data
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
      backgroundColor: Colors.white,
        body :
        isLoading && leadsList.isEmpty?
        Center(
          child: LoadingAnimationWidget.fourRotatingDots(
            color: Color(0xFF9EA700),
            size: 100,
          ),
        )
            : leadsList.isEmpty
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Image.asset('assets/nodata.png')),
            Text(
              "No data to display",
              style: TextStyle(color: Colors.blueGrey),
            ),
          ],
        )
            :
        Column(
        children: [
          Divider(thickness: 2, color: Colors.grey.shade300),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Activities',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                // ElevatedButton(
                //     onPressed: () {},
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.grey.shade200,
                //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                //       foregroundColor: Color(0xFF9EA700),
                //     ),
                //     child: Text(
                //       'New Activity',
                //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                //     )),
              ],
            ),
          ),
          Divider(thickness: 1, color: Colors.grey.shade300),
          ChartSelection(),
          Divider(thickness: 1, color: Colors.grey.shade300),
          selectedView == 4 ? buildChartSelection() : SizedBox(),
          SizedBox(height: 7),
          Expanded(child: iconSelectedView()),
        ],
      ),
    );
  }
}
