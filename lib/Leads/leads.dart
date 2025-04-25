import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:cyllo_mobile/isarModel/leadModel.dart';
import 'package:cyllo_mobile/isarModel/pipelineModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../getUserImage.dart';
import '../main.dart';
import 'Views/leadView.dart';

class Leads extends StatefulWidget {
  const Leads({super.key});

  @override
  State<Leads> createState() => _LeadsState();
}

int selectedView = 0;
List<Map<String, dynamic>> leadsList = [];
List<Map<String, dynamic>> newLeadList = [];
Map<int, Uint8List?> activityUserImages = {};
OdooClient? client;
bool isLoading = true;

class _LeadsState extends State<Leads> {
  List<String> _creationDates = [];
  List<String> _closedDates = [];
  int? currentUserId;
  Map<int, Uint8List?> salespersonImages = {};
  List<ChartData> chartDatavalues = [];
  String selectedChart = "bar";
  String selectedFilter = "count";
  String showVariable = "count";
  bool showNoDataMessage = false;
  String? selectedReport = "Pipeline";
  Set<String> selectedFilters = {};
  String? selectedCreationDate;
  String? selectedClosedDate;

  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    loadLeadsFromIsar();
    initializeOdooClient();
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (searchController.text.isNotEmpty) {
        leadData(query: searchController.text);
      } else {
        leadData();
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  Future<void> initializeOdooClient() async {
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
        final auth =
            await client!.authenticate(dbName, userLogin, userPassword);
        print("Odoo Authenticated: $auth");
        await syncTagsFromOdoo();
        await leadData(savetoIsar: true);
        await buildChart();
        await fetchActivityTypes();
        await fetchLeadActivities();
        final dates = await fetchAllDates();
        setState(() {
          _creationDates = dates['creationDates']!;
          _closedDates = dates['closedDates']!;
        });
      } catch (e) {
        await loadLeadsFromIsar();
        print("Odoo Authentication Failed: $e");
      }
    }
    setState(() => isLoading = false);
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
        'domain': [
          ['user_id', '=', false]
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
          ['probability', '=', 0],
          ['active', '=', false]
        ]
      },
      'created_on': {
        'name': 'Creation Date',
        'domain': [],
      },
      'closed_on': {
        'name': 'Closed Date',
        'domain': [],
      },
      'late_activities': {
        'name': 'Late Activities',
        'domain': [
          ['activity_date_deadline', '<', todayDate]
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
          ['active', '=', false]
        ]
      },
    };
  }

  // Show filter dialog
  void showFilterDialog(BuildContext context) {
    final currentFilters = getFilters();
    Set<String> tempSelectedFilters = Set.from(selectedFilters);
    String? tempSelectedCreationDate = selectedCreationDate;
    String? tempSelectedClosedDate = selectedClosedDate;

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
                                    border:
                                        Border.all(color: Colors.grey[300]!),
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
                                        tempSelectedCreationDate =
                                            newValue == "None"
                                                ? null
                                                : newValue;
                                        if (newValue != "None") {
                                          tempSelectedFilters.add('created_on');
                                        } else {
                                          tempSelectedFilters
                                              .remove('created_on');
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
                                    border:
                                        Border.all(color: Colors.grey[300]!),
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
                                        tempSelectedClosedDate =
                                            newValue == "None"
                                                ? null
                                                : newValue;
                                        if (newValue != "None") {
                                          tempSelectedFilters.add('closed_on');
                                        } else {
                                          tempSelectedFilters
                                              .remove('closed_on');
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
                            activeColor: Color(0xFF9EA700),
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
                  isLoading = true;
                });
                Navigator.pop(context);
                leadData(); // Fetch filtered data
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
        'args': [[]],
        'kwargs': {
          'fields': ['date_closed'],
        },
      });

      print("Closed dates response: $response");

      if (response == null || response.isEmpty) return [];

      Set<String> uniqueDates = {};
      for (var lead in response) {
        if (lead['date_closed'] != null &&
            lead['date_closed'] != false &&
            lead['date_closed'] is String) {
          print("Found date_closed value: ${lead['date_closed']}");
          try {
            DateTime date = DateTime.parse(lead['date_closed']);
            String formattedDate = DateFormat('MMMM yyyy').format(date);
            uniqueDates.add(formattedDate);
          } catch (e) {
            print("Error parsing date: ${lead['date_closed']} - $e");
          }
        }
      }

      print("Unique closed dates: $uniqueDates");

      if (uniqueDates.isEmpty) {
        return [];
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
        'args': [[]],
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

  Future<void> loadLeadsFromIsar() async {
    setState(() {
      isLoading = true;
      selectedView = 0;
    });
    try {
      final leads = await isar.leadisars.where().findAll();

      if (leads.isNotEmpty) {
        leadsList = leads.map((lead) {
          return {
            'id': lead.leadId,
            'name': lead.name,
            'email_from': lead.emailFrom,
            'city': lead.city,
            'country_id': lead.countryId,
            'user_id': lead.userId,
            'partner_assigned_id': lead.partnerAssignedId,
            'team_id': lead.teamId,
            'contact_name': lead.contactName,
            'priority': lead.priority,
            'tag_ids': lead.tagIds,
            'activity_date_deadline': lead.activityDateDeadline,
            'expected_revenue': lead.expectedRevenue,
            'partner_id': lead.partnerId,
            'stage_id': lead.stageId != null
                ? [
                    lead.stageId![0],
                    lead.stageId!.length > 1 ? lead.stageId![1] : ''
                  ]
                : null,
            'create_date': lead.createDate,
            'day_open': lead.dayOpen,
            'day_close': lead.dayClose,
            'recurring_revenue_monthly': lead.recurringRevenueMonthly,
            'probability': lead.probability,
            'recurring_revenue_monthly_prorated':
                lead.recurringRevenueMonthlyProrated,
            'recurring_revenue_prorated': lead.recurringRevenueProrated,
            'prorated_revenue': lead.proratedRevenue,
            'recurring_revenue': lead.recurringRevenue,
            'activity_user_id': lead.activityUserId,
            'date_closed': lead.dateClosed,
            'activity_ids': lead.activityIds,
            'type': 'lead',
          };
        }).toList();

        Map<String, double> stageValues = {};
        Map<String, int> stageIdToName = {};
        for (var item in leadsList) {
          if (item['stage_id'] != null &&
              item['stage_id'] is List &&
              item['stage_id'].length > 1) {
            String stageName = item['stage_id'][1].toString();
            int stageId = item['stage_id'][0] as int;
            stageIdToName[stageName] = stageId;
            double value;
            if (selectedFilter == "count") {
              value = (stageValues[stageName] ?? 0) + 1;
            } else if (selectedFilter == "day_open" &&
                item['day_open'] != null &&
                item['day_open'] != false) {
              value =
                  (stageValues[stageName] ?? 0) + (item['day_open'] as double);
            } else if (selectedFilter == "day_close" &&
                item['day_close'] != null &&
                item['day_close'] != false) {
              value =
                  (stageValues[stageName] ?? 0) + (item['day_close'] as double);
            } else if (selectedFilter == "recurring_revenue_monthly" &&
                item['recurring_revenue_monthly'] != null &&
                item['recurring_revenue_monthly'] != false) {
              value = (stageValues[stageName] ?? 0) +
                  (item['recurring_revenue_monthly'] as double);
            } else if (selectedFilter == "expected_revenue" &&
                item['expected_revenue'] != null &&
                item['expected_revenue'] != false) {
              value = (stageValues[stageName] ?? 0) +
                  (item['expected_revenue'] as double);
            } else if (selectedFilter == "probability" &&
                item['probability'] != null &&
                item['probability'] != false) {
              value = (stageValues[stageName] ?? 0) +
                  (item['probability'] as double);
            } else if (selectedFilter == "recurring_revenue_monthly_prorated" &&
                item['recurring_revenue_monthly_prorated'] != null &&
                item['recurring_revenue_monthly_prorated'] != false) {
              value = (stageValues[stageName] ?? 0) +
                  (item['recurring_revenue_monthly_prorated'] as double);
            } else if (selectedFilter == "recurring_revenue_prorated" &&
                item['recurring_revenue_prorated'] != null &&
                item['recurring_revenue_prorated'] != false) {
              value = (stageValues[stageName] ?? 0) +
                  (item['recurring_revenue_prorated'] as double);
            } else if (selectedFilter == "prorated_revenue" &&
                item['prorated_revenue'] != null &&
                item['prorated_revenue'] != false) {
              value = (stageValues[stageName] ?? 0) +
                  (item['prorated_revenue'] as double);
            } else if (selectedFilter == "recurring_revenue" &&
                item['recurring_revenue'] != null &&
                item['recurring_revenue'] != false) {
              value = (stageValues[stageName] ?? 0) +
                  (item['recurring_revenue'] as double);
            } else {
              value = 0;
            }
            stageValues[stageName] = value;
          }
        }

        setState(() {
          chartDatavalues.clear();
          List<String> stageNames = stageValues.keys.toList();
          stageNames
              .sort((a, b) => stageIdToName[a]!.compareTo(stageIdToName[b]!));
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
        setState(() {
          chartDatavalues.clear();
          showNoDataMessage = true;
          isLoading = false;
        });
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

  Future<void> leadData({String query = "", bool savetoIsar = false}) async {
    setState(() => isLoading = true);
    try {
      List<dynamic> domain = [
        ['type', '=', 'lead']
      ];
      final filters = getFilters();

      bool hasUnassigned = selectedFilters.contains('unassigned');
      bool hasMyActivities = selectedFilters.contains('my_activities');
      bool hasMyAssignedPartners =
          selectedFilters.contains('my_assigned_partners');
      bool hasLost = selectedFilters.contains('lost');
      bool hasLateActivities = selectedFilters.contains('late_activities');
      bool hasTodayActivities = selectedFilters.contains('today_activities');
      bool hasFutureActivities = selectedFilters.contains('future_activities');
      bool hasArchived = selectedFilters.contains('archived');

      // Temporary list to hold the OR conditions for "Unassigned or My Activities or My Assigned Partners"
      List<dynamic> unassignedOrMyActivitiesDomain = [];

      // Handle "Unassigned or My Activities or My Assigned Partners" with OR logic
      if (hasUnassigned && hasMyActivities && hasMyAssignedPartners) {
        unassignedOrMyActivitiesDomain.add('|');
        unassignedOrMyActivitiesDomain.add('|');
        unassignedOrMyActivitiesDomain.addAll(filters['unassigned']!['domain']);
        unassignedOrMyActivitiesDomain
            .addAll(filters['my_activities']!['domain']);
        unassignedOrMyActivitiesDomain
            .addAll(filters['my_assigned_partners']!['domain']);
      } else if (hasUnassigned && hasMyActivities) {
        unassignedOrMyActivitiesDomain.add('|');
        unassignedOrMyActivitiesDomain.addAll(filters['unassigned']!['domain']);
        unassignedOrMyActivitiesDomain
            .addAll(filters['my_activities']!['domain']);
      } else if (hasUnassigned && hasMyAssignedPartners) {
        unassignedOrMyActivitiesDomain.add('|');
        unassignedOrMyActivitiesDomain.addAll(filters['unassigned']!['domain']);
        unassignedOrMyActivitiesDomain
            .addAll(filters['my_assigned_partners']!['domain']);
      } else if (hasMyActivities && hasMyAssignedPartners) {
        unassignedOrMyActivitiesDomain.add('|');
        unassignedOrMyActivitiesDomain
            .addAll(filters['my_activities']!['domain']);
        unassignedOrMyActivitiesDomain
            .addAll(filters['my_assigned_partners']!['domain']);
      } else if (hasUnassigned) {
        unassignedOrMyActivitiesDomain.addAll(filters['unassigned']!['domain']);
      } else if (hasMyActivities) {
        unassignedOrMyActivitiesDomain
            .addAll(filters['my_activities']!['domain']);
      } else if (hasMyAssignedPartners) {
        unassignedOrMyActivitiesDomain
            .addAll(filters['my_assigned_partners']!['domain']);
      }

      // Temporary list to hold the OR conditions for "Late Activities or Today Activities or Future Activities"
      List<dynamic> activitiesDomain = [];

      // Handle "Late Activities or Today Activities or Future Activities" with OR logic
      if (hasLateActivities && hasTodayActivities && hasFutureActivities) {
        activitiesDomain.add('|');
        activitiesDomain.add('|');
        activitiesDomain.addAll(filters['late_activities']!['domain']);
        activitiesDomain.addAll(filters['today_activities']!['domain']);
        activitiesDomain.addAll(filters['future_activities']!['domain']);
      } else if (hasLateActivities && hasTodayActivities) {
        activitiesDomain.add('|');
        activitiesDomain.addAll(filters['late_activities']!['domain']);
        activitiesDomain.addAll(filters['today_activities']!['domain']);
      } else if (hasLateActivities && hasFutureActivities) {
        activitiesDomain.add('|');
        activitiesDomain.addAll(filters['late_activities']!['domain']);
        activitiesDomain.addAll(filters['future_activities']!['domain']);
      } else if (hasTodayActivities && hasFutureActivities) {
        activitiesDomain.add('|');
        activitiesDomain.addAll(filters['today_activities']!['domain']);
        activitiesDomain.addAll(filters['future_activities']!['domain']);
      } else if (hasLateActivities) {
        activitiesDomain.addAll(filters['late_activities']!['domain']);
      } else if (hasTodayActivities) {
        activitiesDomain.addAll(filters['today_activities']!['domain']);
      } else if (hasFutureActivities) {
        activitiesDomain.addAll(filters['future_activities']!['domain']);
      }

      // Build the domain by combining all conditions
      bool hasDateFilter = false;

      // Handle date filters (created_on and closed_on)
      for (String filterKey in selectedFilters) {
        if (filterKey == 'created_on' && selectedCreationDate != null) {
          DateTime selectedMonth =
              DateFormat('MMMM yyyy').parse(selectedCreationDate!);
          String startDate = DateFormat('yyyy-MM-01').format(selectedMonth);
          String endDate = DateFormat('yyyy-MM-dd')
              .format(DateTime(selectedMonth.year, selectedMonth.month + 1, 0));

          domain = [
            '&',
            ...domain,
            ['create_date', '>=', startDate],
            ['create_date', '<=', endDate],
          ];
          hasDateFilter = true;
        } else if (filterKey == 'closed_on' && selectedClosedDate != null) {
          DateTime selectedMonth =
              DateFormat('MMMM yyyy').parse(selectedClosedDate!);
          String startDate = DateFormat('yyyy-MM-01').format(selectedMonth);
          String endDate = DateFormat('yyyy-MM-dd')
              .format(DateTime(selectedMonth.year, selectedMonth.month + 1, 0));

          domain = [
            '&',
            ...domain,
            ['date_closed', '>=', startDate],
            ['date_closed', '<=', endDate],
          ];
          hasDateFilter = true;
        }
      }

      // Combine the unassigned/my activities/my assigned partners block
      if (unassignedOrMyActivitiesDomain.isNotEmpty) {
        if (hasDateFilter) {
          domain = ['&', ...domain, ...unassignedOrMyActivitiesDomain];
        } else {
          domain = [...domain, ...unassignedOrMyActivitiesDomain];
        }
      }

      // Combine the activities block (Late/Today/Future)
      if (activitiesDomain.isNotEmpty) {
        if (unassignedOrMyActivitiesDomain.isNotEmpty || hasDateFilter) {
          domain = ['&', ...domain, ...activitiesDomain];
        } else {
          domain = [...domain, ...activitiesDomain];
        }
      }

      // Add "Lost" filter with AND logic
      if (hasLost) {
        if (unassignedOrMyActivitiesDomain.isNotEmpty ||
            activitiesDomain.isNotEmpty ||
            hasDateFilter) {
          domain = ['&', ...domain, ...filters['lost']!['domain']];
        } else {
          domain = [...domain, ...filters['lost']!['domain']];
        }
      }

      // Add "Archived" filter with AND logic
      if (hasArchived) {
        if (unassignedOrMyActivitiesDomain.isNotEmpty ||
            activitiesDomain.isNotEmpty ||
            hasLost ||
            hasDateFilter) {
          domain = ['&', ...domain, ...filters['archived']!['domain']];
        } else {
          domain = [...domain, ...filters['archived']!['domain']];
        }
      }

      if (query.isNotEmpty) {
        List<dynamic> domaina = [
          '|',
          '|',
          '|',
          ['partner_name', 'ilike', query],
          ['email_from', 'ilike', query],
          ['contact_name', 'ilike', query],
          ['name', 'ilike', query],
        ];
        domain = ['&', ...domain, ...domaina];
      }

      final response = await client?.callKw({
        'model': 'crm.lead',
        'method': 'search_read',
        'args': [domain],
        'kwargs': {
          'fields': [
            'name',
            'email_from',
            'city',
            'country_id',
            'user_id',
            'partner_assigned_id',
            'team_id',
            'contact_name',
            'priority',
            'tag_ids',
            'activity_date_deadline',
            'expected_revenue',
            'partner_id',
            'stage_id',
            'create_date',
            'day_open',
            'day_close',
            'recurring_revenue_monthly',
            'probability',
            'recurring_revenue_monthly_prorated',
            'recurring_revenue_prorated',
            'prorated_revenue',
            'recurring_revenue',
            'activity_user_id',
            'date_closed',
            'activity_ids',
            'stage_id',
          ],
        }
      });

      if (response != null) {
        leadsList = List<Map<String, dynamic>>.from(response);
      } else {
        leadsList = [];
      }

      // Write to Isar
      await isar.writeTxn(() async {
        // Clear existing leads
        await isar.leadisars.clear();
        log('Cleared leadisars collection');

        for (var lead in leadsList) {
          try {
            if (lead['id'] == null) {
              log('Skipping lead with null ID: $lead');
              continue;
            }

            final leadisar = Leadisar()
              ..leadId = lead['id']
              ..name = lead['name']?.toString()
              ..emailFrom = lead['email_from']?.toString()
              ..city = lead['city']?.toString()
              ..countryId =
                  lead['country_id'] is List && lead['country_id'].isNotEmpty
                      ? [lead['country_id'][0]]
                      : null
              ..userId = lead['user_id'] is List && lead['user_id'].isNotEmpty
                  ? [lead['user_id'][0]]
                  : null
              ..partnerAssignedId = lead['partner_assigned_id'] is List &&
                      lead['partner_assigned_id'].isNotEmpty
                  ? [lead['partner_assigned_id'][0]]
                  : null
              ..teamId = lead['team_id'] is List && lead['team_id'].isNotEmpty
                  ? [lead['team_id'][0]]
                  : null
              ..contactName = lead['contact_name']?.toString()
              ..priority = lead['priority']?.toString()
              ..tagIds = lead['tag_ids'] is List
                  ? List<int>.from(lead['tag_ids'])
                  : null
              ..activityDateDeadline =
                  lead['activity_date_deadline']?.toString()
              ..expectedRevenue = lead['expected_revenue'] is num
                  ? lead['expected_revenue'].toDouble()
                  : null
              ..partnerId =
                  lead['partner_id'] is List && lead['partner_id'].isNotEmpty
                      ? [lead['partner_id'][0]]
                      : null
              ..stageId =
                  lead['stage_id'] is List && lead['stage_id'].isNotEmpty
                      ? [lead['stage_id'][0]]
                      : null
              ..createDate = lead['create_date']?.toString()
              ..dayOpen =
                  lead['day_open'] is num ? lead['day_open'].toDouble() : null
              ..dayClose =
                  lead['day_close'] is num ? lead['day_close'].toDouble() : null
              ..recurringRevenueMonthly =
                  lead['recurring_revenue_monthly'] is num
                      ? lead['recurring_revenue_monthly'].toDouble()
                      : null
              ..probability = lead['probability'] is num
                  ? lead['probability'].toDouble()
                  : null
              ..recurringRevenueMonthlyProrated =
                  lead['recurring_revenue_monthly_prorated'] is num
                      ? lead['recurring_revenue_monthly_prorated'].toDouble()
                      : null
              ..recurringRevenueProrated =
                  lead['recurring_revenue_prorated'] is num
                      ? lead['recurring_revenue_prorated'].toDouble()
                      : null
              ..proratedRevenue = lead['prorated_revenue'] is num
                  ? lead['prorated_revenue'].toDouble()
                  : null
              ..recurringRevenue = lead['recurring_revenue'] is num
                  ? lead['recurring_revenue'].toDouble()
                  : null
              ..activityUserId = lead['activity_user_id'] is List &&
                      lead['activity_user_id'].isNotEmpty
                  ? [lead['activity_user_id'][0]]
                  : null
              ..dateClosed = lead['date_closed']?.toString()
              ..activityIds = lead['activity_ids'] is List
                  ? List<int>.from(lead['activity_ids'])
                  : null;

            await isar.leadisars.put(leadisar);
            log('Successfully saved lead ID: ${lead['id']} to Isar');
          } catch (e, stackTrace) {
            log('Error saving lead ID: ${lead['id']}, Error: $e, StackTrace: $stackTrace');
            log('Lead data: $lead');
          }
        }

        // Verify the data was written
        final savedLeads = await isar.leadisars.where().findAll();
        log('Total leads saved to Isar: ${savedLeads.length}');
      });

      // Update chart data
      if (leadsList.isNotEmpty) {
        Map<String, double> stageValues = {};
        Map<String, int> stageIdToName = {};

        for (var item in leadsList) {
          if (item['stage_id'] != null &&
              item['stage_id'] is List &&
              item['stage_id'].length > 1) {
            String stageName = item['stage_id'][1].toString();
            int stageId = item['stage_id'][0] as int;
            stageIdToName[stageName] = stageId;
            double value;
            if (selectedFilter == "count") {
              value = (stageValues[stageName] ?? 0) + 1;
            } else if (selectedFilter == "day_open" &&
                item['day_open'] != null &&
                item['day_open'] != false) {
              value =
                  (stageValues[stageName] ?? 0) + (item['day_open'] as double);
            } else if (selectedFilter == "day_close" &&
                item['day_close'] != null &&
                item['day_close'] != false) {
              value =
                  (stageValues[stageName] ?? 0) + (item['day_close'] as double);
            } else if (selectedFilter == "recurring_revenue_monthly" &&
                item['recurring_revenue_monthly'] != null &&
                item['recurring_revenue_monthly'] != false) {
              value = (stageValues[stageName] ?? 0) +
                  (item['recurring_revenue_monthly'] as double);
            } else if (selectedFilter == "expected_revenue" &&
                item['expected_revenue'] != null &&
                item['expected_revenue'] != false) {
              value = (stageValues[stageName] ?? 0) +
                  (item['expected_revenue'] as double);
            } else if (selectedFilter == "probability" &&
                item['probability'] != null &&
                item['probability'] != false) {
              value = (stageValues[stageName] ?? 0) +
                  (item['probability'] as double);
            } else if (selectedFilter == "recurring_revenue_monthly_prorated" &&
                item['recurring_revenue_monthly_prorated'] != null &&
                item['recurring_revenue_monthly_prorated'] != false) {
              value = (stageValues[stageName] ?? 0) +
                  (item['recurring_revenue_monthly_prorated'] as double);
            } else if (selectedFilter == "recurring_revenue_prorated" &&
                item['recurring_revenue_prorated'] != null &&
                item['recurring_revenue_prorated'] != false) {
              value = (stageValues[stageName] ?? 0) +
                  (item['recurring_revenue_prorated'] as double);
            } else if (selectedFilter == "prorated_revenue" &&
                item['prorated_revenue'] != null &&
                item['prorated_revenue'] != false) {
              value = (stageValues[stageName] ?? 0) +
                  (item['prorated_revenue'] as double);
            } else if (selectedFilter == "recurring_revenue" &&
                item['recurring_revenue'] != null &&
                item['recurring_revenue'] != false) {
              value = (stageValues[stageName] ?? 0) +
                  (item['recurring_revenue'] as double);
            } else {
              value = 0;
            }
            stageValues[stageName] = value;
          }
        }

        setState(() {
          chartDatavalues.clear();
          List<String> stageNames = stageValues.keys.toList();
          stageNames
              .sort((a, b) => stageIdToName[a]!.compareTo(stageIdToName[b]!));
          List<ChartData> sortedData = stageNames
              .where((stage) => stageValues.containsKey(stage))
              .map((stage) => ChartData(stage, stageValues[stage]!))
              .toList();
          chartDatavalues = sortedData;

          showNoDataMessage =
              stageNames.isEmpty || sortedData.every((data) => data.y == 0);
          isLoading = false;
        });
      } else {
        setState(() {
          chartDatavalues.clear();
          showNoDataMessage = true;
          isLoading = false;
        });
      }
    } catch (e, stackTrace) {
      log("Error loading lead data: $e, StackTrace: $stackTrace");
      setState(() {
        isLoading = false;
        showNoDataMessage = true;
      });
    }
  }

  Future<String> fetchTagNames(List<dynamic>? tagIds) async {
    if (tagIds == null || tagIds.isEmpty) return 'None';

    try {
      List<int> tagIdList = tagIds.map((id) => id as int).toList();

      List<Tag> tags = [];
      for (int tagId in tagIdList) {
        final tag = await isar.tags.where().tagIdEqualTo(tagId).findFirst();
        if (tag != null) {
          tags.add(tag);
        }
      }

      // Extract tag names and join them
      final tagNames = tags.map((tag) => tag.name ?? 'Unknown').join(', ');

      return tagNames.isEmpty ? 'None' : tagNames;
    } catch (e) {
      print("Error fetching tag names from Isar: $e");
      return 'None';
    }
  }

  Future<void> syncTagsFromOdoo() async {
    if (client == null) return;

    try {
      final response = await client!.callKw({
        'model': 'crm.tag',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {
          'fields': ['id', 'name'],
        },
      });

      if (response != null && response is List) {
        await isar.writeTxn(() async {
          await isar.tags.clear();

          // Store new tags
          for (var tag in response) {
            final tagIsar = Tag()
              ..tagId = tag['id']
              ..name = tag['name']?.toString();
            await isar.tags.put(tagIsar);
          }
        });
        print('Successfully synced ${response.length} tags to Isar');
      }
    } catch (e) {
      print("Error syncing tags from Odoo: $e");
    }
  }

  Future<Uint8List?> fetchSalespersonImage(int userId) async {
    if (salespersonImages.containsKey(userId)) {
      return salespersonImages[userId];
    }

    try {
      final response = await client?.callKw({
        'model': 'res.users',
        'method': 'search_read',
        'args': [
          [
            ["id", "=", userId],
          ]
        ],
        'kwargs': {
          'fields': ['image_1920'],
        },
      });
      print('Salesperson image response for user $userId: $response');
      if (response == null || response.isEmpty || response is! List) {
        print('No image data received for user $userId');
        salespersonImages[userId] = null;
        return null;
      }

      final List<Map<String, dynamic>> data =
          List<Map<String, dynamic>>.from(response);
      var imageData = data[0]['image_1920'];
      if (imageData != null && imageData is String) {
        final imageBytes = base64Decode(imageData);
        salespersonImages[userId] = imageBytes;
        return imageBytes;
      } else {
        salespersonImages[userId] = null;
        return null;
      }
    } catch (e) {
      print("Error fetching salesperson image for user $userId: $e");
      salespersonImages[userId] = null;
      return null;
    }
  }

  Widget ChartSelection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
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
                onPressed: () => setState(() => selectedView = 0),
                icon: Icon(Icons.bar_chart_rounded,
                    color:
                        selectedView == 0 ? Color(0xFF9EA700) : Colors.black),
              ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () => setState(() => selectedView = 1),
                icon: Icon(Icons.view_list_rounded,
                    color:
                        selectedView == 1 ? Color(0xFF9EA700) : Colors.black),
              ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () => setState(() => selectedView = 2),
                icon: Icon(Icons.calendar_month,
                    color:
                        selectedView == 2 ? Color(0xFF9EA700) : Colors.black),
              ),
              // VerticalDivider(thickness: 2, color: Colors.white),
              // IconButton(
              //   onPressed: () => setState(() => selectedView = 3),
              //   icon: Icon(Icons.table_rows_outlined,
              //       color:
              //           selectedView == 3 ? Color(0xFF9EA700) : Colors.black),
              // ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () => setState(() => selectedView = 4),
                icon: Icon(Icons.graphic_eq_rounded,
                    color:
                        selectedView == 4 ? Color(0xFF9EA700) : Colors.black),
              ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () => setState(() => selectedView = 5),
                icon: Icon(Icons.access_time,
                    color:
                        selectedView == 5 ? Color(0xFF9EA700) : Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listCard() {
    return leadsList.isEmpty
        ? Center(
            child: Text(
              "No leads found",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          )
        : ListView.builder(
            itemCount: leadsList.length,
            padding: EdgeInsets.all(8),
            itemBuilder: (context, index) {
              final lead = leadsList[index];
              final leadId = lead['id'];
              final name = lead['name'] ?? '';
              final country = lead['country_id'] != null &&
                      lead['country_id'] is List &&
                      lead['country_id'].length > 1
                  ? lead['country_id'][1]
                  : "None";
              final city = lead['city'] == false
                  ? 'None'
                  : lead['city']?.toString() ?? 'None';
              final assignedPartner = lead['partner_assigned_id'] != null &&
                      lead['partner_assigned_id'] is List &&
                      lead['partner_assigned_id'].length > 1
                  ? lead['partner_assigned_id'][1]
                  : 'None';
              final email = lead['email_from'] == false
                  ? 'None'
                  : lead['email_from']?.toString() ?? 'None';
              final salesperson = lead['user_id'] != null &&
                      lead['user_id'] is List &&
                      lead['user_id'].length > 1
                  ? lead['user_id'][1]
                  : "None";
              final salespersonId = lead['user_id'] != null &&
                      lead['user_id'] is List &&
                      lead['user_id'].length > 0
                  ? lead['user_id'][0]
                  : null;
              final teamId = lead['team_id'] != null &&
                      lead['team_id'] is List &&
                      lead['team_id'].length > 0
                  ? lead['team_id'][1]
                  : null;

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
                            builder: (context) => Leadview(leadId: leadId),
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 8),
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
                                        color: Color(0xFF9EA700),
                                        shape: BoxShape.circle,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Email',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              email,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                color: Colors.grey.shade900,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 16),
                                            Text(
                                              'Salesperson',
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
                                                if (salespersonId != null) ...[
                                                  OdooAvatar(
                                                    client: client,
                                                    model: 'res.users',
                                                    recordId: salespersonId,
                                                    size: 32,
                                                    borderRadius: 5,
                                                    shape: BoxShape.rectangle,
                                                  ),
                                                ],
                                                if (salespersonId == null) ...[
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[300],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Icon(
                                                      Icons.person,
                                                      // You can change this to any icon
                                                      size: 18,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                ],
                                                SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                    salesperson,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          Colors.grey.shade800,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Sales Team',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(height: 6),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 8),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF9EA700)
                                                    .withOpacity(0.15),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .account_balance_wallet_outlined,
                                                    color: Colors.black,
                                                    size: 20,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Expanded(
                                                    child: Text(
                                                      teamId.toString(),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
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
                                              'City',
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
                                                city,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF9EA700),
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 16),
                                            Text(
                                              'Country',
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
                                                country,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF9EA700),
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 12),
                                            Text(
                                              'Assigned Partner',
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
                                                assignedPartner,
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
            },
          );
  }

  Widget kanban() {
    return leadsList.isEmpty
        ? Center(
            child: Text(
              "No leads found",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          )
        : ListView.builder(
            itemCount: leadsList.length,
            padding: EdgeInsets.all(8),
            itemBuilder: (context, index) {
              final lead = leadsList[index];
              final leadId = lead['id'];
              final name = lead['name'] ?? 'No Name';
              final contactName = lead['contact_name'] == false
                  ? 'None'
                  : lead['contact_name']?.toString() ?? 'None';
              final priority = lead['priority']?.toString() ?? '0';
              final int priorityLevel = int.tryParse(priority) ?? 0;

              final tagIds = lead['tag_ids'] is List
                  ? lead['tag_ids'] as List<dynamic>
                  : null;

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Leadview(leadId: leadId),
                    ),
                  );
                },
                child: Card(
                  color: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        // Left side: Lead Name and Email
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                contactName,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        // Right side: Salesperson and Icons
                        Row(
                          children: [
                            FutureBuilder<String>(
                              future: fetchTagNames(tagIds),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade100,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: SizedBox(
                                      width: 50,
                                      height: 16,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.blue.shade800),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                final tagNames = snapshot.data ?? 'None';
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade100,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    tagNames,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue.shade800,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(width: 8),
                            // Star icons
                            Row(
                              children: List.generate(
                                3, // Total number of stars
                                (starIndex) => Icon(
                                  Icons.star,
                                  size: 16,
                                  color: starIndex < priorityLevel
                                      ? Colors
                                          .amber // Filled star for priority level
                                      : Colors.grey[300], // Empty star
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            // Link icon
                            Icon(
                              Icons.schedule,
                              size: 16,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }

  Widget calendarView() {
    List<Appointment> appointments = [];
    Map<String, Map<String, dynamic>> appointmentLeadMap = {};

    for (var lead in leadsList) {
      if (lead['activity_date_deadline'] != null &&
          lead['activity_date_deadline'] != false) {
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
                id: appointmentId),
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
        headerStyle: CalendarHeaderStyle(
          backgroundColor: Color(0x69EA700),
        ),
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

  void calendarDialogue(BuildContext context, Map<String, dynamic> lead) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                  lead['activity_date_deadline'] != null &&
                          lead['activity_date_deadline'] != false
                      ? lead['activity_date_deadline'] is DateTime
                          ? lead['activity_date_deadline']
                              .toString()
                              .split(' ')[0]
                          : lead['activity_date_deadline'].toString()
                      : 'No deadline',
                  style: TextStyle(
                    fontSize: 16,
                    color:
                        lead['activity_state'] == 'overdue' ? Colors.red : null,
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
                  icon: Icon(
                    Icons.edit,
                    size: 16,
                    color: Colors.black,
                  ),
                  label: Text('Edit'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Leadview(leadId: lead["id"]),
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
                  icon: Icon(
                    Icons.delete,
                    size: 16,
                    color: Colors.black,
                  ),
                  label: Text('Delete'),
                  onPressed: () async {
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
                                    Navigator.of(context)
                                        .pop(true); // Confirm delete
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF9EA700),
                                    // Green color for Delete
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
                        await leadData();
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
                    backgroundColor: Colors.grey[200],
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

  Widget fetchPivotData() {
    if (leadsList.isEmpty) {
      print("No data ");
      return Center(child: Text("No data available"));
    }

    Set<String> uniqueStages = {};
    Map<String, Map<String, dynamic>> groupedData = {};
    Map<String, double> columnTotals = {};

    for (var lead in leadsList) {
      String stage = (lead['stage_id'] is List && lead['stage_id'].length > 1)
          ? lead['stage_id'][1]
          : 'Unknown';
      if (!uniqueStages.contains(stage)) {
        uniqueStages.add(stage);
      }
      // uniqueStages.add(stage);
      String date = lead['create_date'] ?? "None";
      String formattedDate = formatDate(date);
      print('klkll$date');
      double revenue =
          double.tryParse(lead['expected_revenue']?.toString() ?? "0") ?? 0.0;

      // groupedData.putIfAbsent(formattedDate, () => {'date': formattedDate});
      if (!groupedData.containsKey(formattedDate)) {
        groupedData[formattedDate] = {'date': formattedDate};
      }

      groupedData[formattedDate]![stage] = ((double.tryParse(
                      groupedData[formattedDate]![stage]?.toString() ?? "0") ??
                  0.0) +
              revenue)
          .toString();
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
                SizedBox(
                  height: 12,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                        color: selectedFilter == "count"
                            ? Color(0xFF656805)
                            : Colors.transparent,
                        width: 6, // Border thickness
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
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                        color: selectedFilter == "day_open"
                            ? Color(0xFF656805)
                            : Colors.transparent,
                        width: 6, // Border thickness
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
                      applyFilter("day_open", 'Days to Assign');
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    tileColor: Color(0x1B9EA700),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                        color: selectedFilter == "day_close"
                            ? Color(0xFF656805)
                            : Colors.transparent,
                        width: 6, // Border thickness
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
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                        color: selectedFilter == "recurring_revenue_monthly"
                            ? Color(0xFF656805)
                            : Colors.transparent,
                        width: 7, // Border thickness
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
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                        color: selectedFilter == "expected_revenue"
                            ? Color(0xFF656805)
                            : Colors.transparent,
                        width: 7, // Border thickness
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
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                        color: selectedFilter == "probability"
                            ? Color(0xFF656805)
                            : Colors.transparent,
                        width: 7, // Border thickness
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
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                        color: selectedFilter ==
                                "recurring_revenue_monthly_prorated"
                            ? Color(0xFF656805)
                            : Colors.transparent,
                        width: 7, // Border thickness
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
                      applyFilter(
                          "recurring_revenue_monthly_prorated", 'Prorated MRR');
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    tileColor: Color(0x1B9EA700),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                        color: selectedFilter == "recurring_revenue_prorated"
                            ? Color(0xFF656805)
                            : Colors.transparent,
                        width: 7, // Border thickness
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
                      applyFilter("recurring_revenue_prorated",
                          'Prorated Recurring Revenues');
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    tileColor: Color(0x1B9EA700),
                    focusColor: Colors.red,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                        color: selectedFilter == "prorated_revenue"
                            ? Color(0xFF656805)
                            : Colors.transparent,
                        width: 7, // Border thickness
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
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                        color: selectedFilter == "recurring_revenue"
                            ? Color(0xFF656805)
                            : Colors.transparent,
                        width: 7, // Border thickness
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
    leadData();
    Navigator.pop(context);
  }

  Widget buildChartSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 10,
          ),
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
                  Expanded(
                      child: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  )),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 150,
        ),
        Container(
          height: 37,
          width: 37,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7), color: Color(0x279EA700)),
          child: IconButton(
              onPressed: () => changeChartType("bar"),
              icon: Icon(Icons.bar_chart_rounded,
                  color: selectedChart == 'bar'
                      ? Color(0xFF9EA700)
                      : Colors.black)),
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          height: 37,
          width: 37,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7), color: Color(0x279EA700)),
          child: IconButton(
              onPressed: () => changeChartType("line"),
              icon: Icon(Icons.stacked_line_chart_rounded,
                  color: selectedChart == 'line'
                      ? Color(0xFF9EA700)
                      : Colors.black)),
        ),
        SizedBox(
          width: 5,
        ),
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
                    color: selectedChart == 'pie'
                        ? Color(0xFF9EA700)
                        : Colors.black)),
          ),
        ),
      ],
    );
  }

  Map<int, List<Map<String, dynamic>>> leadActivities = {};

  Future<void> fetchLeadActivities() async {
    try {
      List<int> activityIds = [];
      Set<int> salespersonIds = {};
      for (var lead in leadsList) {
        if (lead['activity_ids'] != null && lead['activity_ids'] is List) {
          activityIds.addAll(List<int>.from(lead['activity_ids']));
        }
        if (lead['user_id'] != null &&
            lead['user_id'] is List &&
            lead['user_id'].length > 0) {
          salespersonIds.add(lead['user_id'][0]);
        }
      }
      print("Activity IDs   : $activityIds");

      if (activityIds.isEmpty) return;

      final response = await client?.callKw({
        'model': 'mail.activity',
        'method': 'search_read',
        'args': [
          [
            ['id', 'in', activityIds]
          ]
        ],
        'kwargs': {
          'fields': [
            'activity_type_id',
            'summary',
            'date_deadline',
            'state',
            'user_id'
          ],
        }
      });
      for (int userId in salespersonIds) {
        if (!salespersonImages.containsKey(userId)) {
          await fetchSalespersonImage(userId);
        }
      }
      print("Pre-fetched salesperson images: $salespersonImages");

      if (activityIds.isEmpty) return;

      if (response != null) {
        List<Map<String, dynamic>> activities =
            List<Map<String, dynamic>>.from(response);
        for (var activity in activities) {
          if (activity['user_id'] != null &&
              activity['user_id'] is List &&
              activity['user_id'].length > 0) {
            int userId = activity['user_id'][0];
            if (!activityUserImages.containsKey(userId)) {
              Uint8List? userImage = await fetchSalespersonImage(userId);
              activityUserImages[userId] = userImage;
              activity['user_image'] =
                  userImage != null ? base64Encode(userImage) : null;
            } else {
              activity['user_image'] = activityUserImages[userId] != null
                  ? base64Encode(activityUserImages[userId]!)
                  : null;
            }
          }
        }

        for (var lead in leadsList) {
          if (lead['activity_ids'] != null && lead['activity_ids'] is List) {
            leadActivities[lead['id']] = activities
                .where(
                    (activity) => lead['activity_ids'].contains(activity['id']))
                .toList();
            print(
                "Lead ${lead['id']} activities: ${leadActivities[lead['id']]}");
          }
        }

        await fetchActivityTypes();
      }
    } catch (e) {
      print("Error fetching lead activities: $e");
    }
  }

  List<Map<String, dynamic>> activityTypes = [];

  Future<void> fetchActivityTypes() async {
    try {
      final response = await client?.callKw({
        'model': 'mail.activity.type',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {
          'fields': ['name'],
        }
      });
      print("Activity types response: $response");
      if (response != null) {
        activityTypes = List<Map<String, dynamic>>.from(response);
      }
    } catch (e) {
      print("Error fetching activity types: $e");
    }
  }

  Widget activityView() {
    if (isLoading || leadActivities.isEmpty) {
      return Center(
        child: LoadingAnimationWidget.fourRotatingDots(
          color: Color(0xFF9EA700),
          size: 100,
        ),
      );
    }

    List<Map<String, dynamic>> leadsWithActivities = leadsList
        .where((lead) =>
            leadActivities.containsKey(lead['id']) &&
            leadActivities[lead['id']]!.isNotEmpty)
        .toList();
    print("Leads with activities: $leadsWithActivities");

    if (leadsWithActivities.isEmpty) {
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

    List<GridColumn> columns = [
      GridColumn(
        columnName: 'lead',
        label: Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Lead',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ),
        width: 200,
      ),
    ];

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
      source: LeadActivityDataSource(leadsWithActivities, leadActivities,
          salespersonImages, activityTypes, context),
      columnWidthMode: ColumnWidthMode.fill,
      gridLinesVisibility: GridLinesVisibility.both,
      headerGridLinesVisibility: GridLinesVisibility.both,
      columns: columns,
    );
  }

  Widget iconSelectedView() {
    switch (selectedView) {
      case 0:
        return kanban();
      case 1:
        return listCard();
      case 2:
        return calendarView();
      case 3:
        return fetchPivotData();
      case 4:
        return buildChart();
      case 5:
        return activityView();
      default:
        return Container();
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
            : const Text(
                "Leads",
                style: TextStyle(color: Colors.white),
              ),
        elevation: 0,
        backgroundColor: const Color(0xFF9EA700),
        actions: [
          IconButton(
            icon: Icon(
              isSearching ? Icons.close : Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                if (isSearching) {
                  searchController.clear();
                  isSearching = false;
                  leadData(); // Reset to full data
                } else {
                  isSearching = true;
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.filter_list,
              color: Colors.white,
            ),
            onPressed: () => showFilterDialog(context),
          ),
        ],
      ),
      //   title: Text('Leads'),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.filter_list, color: Colors.black),
      //       onPressed: () => showFilterDialog(context),
      //     ),
      //   ],
      // ),
      body: isLoading && leadsList.isEmpty
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: Color(0xFF9EA700),
                size: 100,
              ),
            )
          :isLoading==false&& leadsList.isEmpty
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
              : Column(
                  children: [
                    Divider(thickness: 2, color: Colors.grey.shade300),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Leads',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          // ElevatedButton(
                          //     onPressed: () {},
                          //     style: ElevatedButton.styleFrom(
                          //       backgroundColor: Colors.grey.shade200,
                          //       shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(7)),
                          //       foregroundColor: Color(0xFF9EA700),
                          //     ),
                          //     child: Text(
                          //       'Generate Leads',
                          //       style: TextStyle(
                          //           fontWeight: FontWeight.bold, fontSize: 15),
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

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}

class tableSource extends DataGridSource {
  List<DataGridRow> dataGridRows;

  tableSource(this.dataGridRows);

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    bool isTotalRow = row.getCells().first.value == "Total";
    return DataGridRowAdapter(
      cells: row.getCells().map((cell) {
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
          color: isTotalRow ? Colors.grey[300] : null,
          child: Text(cell.value.toString()),
        );
      }).toList(),
    );
  }
}

String formatDate(String date) {
  try {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat("MMMM yyyy").format(parsedDate);
  } catch (e) {
    return "Unknown";
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}

class LeadActivityDataSource extends DataGridSource {
  final List<Map<String, dynamic>> leads;
  final Map<int, List<Map<String, dynamic>>> leadActivities;
  final List<Map<String, dynamic>> activityTypes;
  Map<int, Uint8List?> salespersonImages;
  final BuildContext context;

  LeadActivityDataSource(this.leads, this.leadActivities,
      this.salespersonImages, this.activityTypes, this.context);

  @override
  List<DataGridRow> get rows => leads.map((lead) {
        List<DataGridCell> cells = [
          DataGridCell<Map<String, dynamic>>(
            columnName: 'lead',
            value: {
              'name': lead['name']?.toString() ?? 'Unnamed Lead',
              'customer': lead['partner_id'] != null &&
                      lead['partner_id'] is List &&
                      lead['partner_id'].length > 1
                  ? lead['partner_id'][1]
                  : 'None',
              'salesperson_id': lead['user_id'] != null &&
                      lead['user_id'] is List &&
                      lead['user_id'].length > 0
                  ? lead['user_id'][0]
                  : null,
              'stage': lead['stage_id'] != null &&
                      lead['stage_id'] is List &&
                      lead['stage_id'].length > 1
                  ? lead['stage_id'][1]
                  : 'Unknown',
              'expected_revenue':
                  lead['expected_revenue']?.toString() ?? '0.00',
              'id': lead['id'],
            },
          ),
        ];

        for (var type in activityTypes) {
          String activityTypeName = type['name'];
          var activitiesForLead = leadActivities[lead['id']] ?? [];
          var matchingActivity = activitiesForLead.firstWhere(
            (activity) =>
                activity['activity_type_id'] is List &&
                activity['activity_type_id'].length > 1 &&
                activity['activity_type_id'][1] == activityTypeName,
            orElse: () => <String, dynamic>{},
          );

          cells.add(
            DataGridCell<Map<String, dynamic>>(
              columnName: activityTypeName,
              value: matchingActivity.isNotEmpty
                  ? {
                      'date_deadline':
                          matchingActivity['date_deadline']?.toString() ?? '',
                      'user_image': matchingActivity['user_image'],
                      'state': matchingActivity['state'] ?? ''
                    }
                  : {},
            ),
          );
        }

        return DataGridRow(cells: cells);
      }).toList();

  Color _getActivityColor(String date) {
    if (date.isEmpty) return Colors.transparent;
    try {
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
    } catch (e) {
      print("Error parsing date for color: $e");
      return Colors.transparent;
    }
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map((cell) {
        if (cell.columnName == 'lead') {
          Map<String, dynamic> leadData = cell.value as Map<String, dynamic>;
          String leadName = leadData['name'];
          String customerName = leadData['customer'];
          int? salespersonId = leadData['salesperson_id'];
          final leadId = leadData['id'];
          String stage = leadData['stage'];
          print('oppppooo$leadData');
          String expectedRevenue = leadData['expected_revenue'] ?? '0.00';
          Uint8List? salespersonImage =
              salespersonId != null ? salespersonImages[salespersonId] : null;

          return InkWell(
            onTap: () {
              final leadId = leadData['id'];
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Leadview(leadId: leadId),
                ),
              );
            },
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    child: salespersonImage != null
                        ? ClipOval(
                            child: Image.memory(
                              salespersonImage,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                Icons.person,
                                size: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          )
                        : Icon(
                            Icons.person,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          leadName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          customerName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        '\$$expectedRevenue',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          stage,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }

        Map<String, dynamic> activityData = cell.value as Map<String, dynamic>;
        String date = activityData['date_deadline'] ?? '';
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
                      child: userImage != null
                          ? ClipOval(
                              child: Image.memory(
                                base64Decode(userImage),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(
                                  Icons.person,
                                  size: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
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
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
        );
      }).toList(),
    );
  }
}
