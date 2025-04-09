import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:cyllo_mobile/getUserImage.dart';
import 'package:flutter/material.dart';
import 'package:appflowy_board/appflowy_board.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'Views/pipeLineView.dart';

class Mypipeline extends StatefulWidget {

  final int? teamId;
  final List<List< Object>>? domain;
  final String? title;


  const Mypipeline({super.key,  this.teamId , this.domain,this.title});

  @override
  State<Mypipeline> createState() => _MypipelineState();
}

OdooClient? client;
bool isLoading = true;
final AppFlowyBoardController controller = AppFlowyBoardController();
late AppFlowyBoardScrollController boardController;
int selectedView = 0;
List<Map<String, dynamic>> leadsList = [];
List<Map<String, dynamic>> opportunitiesList = [];

class _MypipelineState extends State<Mypipeline> {
  List<ChartData> chartDatavalues = [];
  List<String> activityTypes = [];
  Uint8List? profileImage;
  String? userName;
  bool showNoDataMessage = false;
  String selectedChart = "bar";
  String selectedFilter = "count";
  String showVariable = "count";
  String? selectedReport = "Pipeline";

  List<dynamic> filterList = [];
  String filterName = '';

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
    return {
        'my_pipeline': {
          'name': 'My Pipeline',
          'domain': [
            ['user_id', '=', currentUserId]
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
      'open_opportunties': {
        'name': 'Open Opportunties',
        'domain': [
          '&',
          '&',
          ['probability', '<', 100],
          ['type', '=', 'opportunity'],
          ['active', '!=', false]
        ]
      },
      'won': {
        'name': 'Won',
        'domain': [
          '&',
          ['active', '!=', false],
          ['stage_id.is_won', '=', true]
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
      'archived': {
        'name': 'Archived',
        'domain': [
          '&',
          ['active', '=', false],
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
    };
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
        await userImage();
        await pipe();
        await tag();
        await iconSelectedView();
        await fetchData();
        await buildChart();
        await fetchFilteredData();
        await act();
      } catch (e) {
        print("Odoo Authentication Failed: $e");
      }
    }
    setState(() => isLoading = false);
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
              return FutureBuilder<Map<String, List<String>>>(
                future: fetchAllDates(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return SizedBox(
                      height: 100,
                      child: Center(child: CircularProgressIndicator(color: Colors.blue)),
                    );
                  }

                  List<String> creationDates = snapshot.data!['creationDates']!;
                  List<String> closedDates = snapshot.data!['closedDates']!;

                  if (!creationDates.contains("None")) {
                    creationDates.insert(0, "None");
                  }
                  if (!closedDates.contains("None")) {
                    closedDates.insert(0, "None");
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
                backgroundColor: Color(0xFF9EA700) ,
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
          []
        ],
        'kwargs': {
          'fields': ['date_closed'],
        },
      });

      print("Closed dates response: $response");

      if (response == null || response.isEmpty) return [];

      Set<String> uniqueDates = {};
      for (var lead in response) {
        if (lead['date_closed'] != null && lead['date_closed'] != false && lead['date_closed'] is String) {
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
        'args': [
          []
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

    setState(() {
      isLoading = true;
    });

    try {
      await pipe();
      await buildChart();

    } catch (e) {
      log("Error fetching filtered data: $e");
      setState(() {
        isLoading = false;
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
      print('lolkoko$response');
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
          'fields': ['name',],
        }
      });

      print('Tactttt: $response');

      if (response != null && response is List) {
        setState(() {
          activityTypes = response.map((item) => item['name'].toString()).toList();
        });
      }

    } catch (e) {
      print("Failed to fetch tags: $e");
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
      print('imggg$response');
      if (response == null || response.isEmpty || response is! List) {
        print('No data received or invalid format');
        setState(() => isLoading = false);
        return;
      }
      try {
        final List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(response);
        setState(() {
          var imageData = data[0]['image_1920'];
          if (imageData != null && imageData is String) {
            profileImage = base64Decode(imageData);
            print('imageeeeee$profileImage');
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

      Future<void> pipe({String query=""}) async {
        final prefs = await SharedPreferences.getInstance();
        final userid = prefs.getInt("userId") ?? "";
        print('iddddd$userid');
        try {
          Map<int, String> tagMap = await tag();
          final currentFilters = getFilters();
          List<dynamic> finalFilter = [];
          List<dynamic> domain = [
            ['type', '=', 'opportunity']
          ];

          bool hasMyPipeline = selectedFilters.contains('my_pipeline');
          bool hasUnassigned = selectedFilters.contains('unassigned');
          bool hasMyAssignedPartners = selectedFilters.contains('my_assigned_partners');
          bool hasOpenOpportunities = selectedFilters.contains('open_opportunties');
          bool hasWon = selectedFilters.contains('won');
          bool hasLost = selectedFilters.contains('lost');
          bool hasArchived = selectedFilters.contains('archived');
          log('selytt$selectedFilters');

          // Temporary list for "My Pipeline or Unassigned or My Assigned Partners or Open Opportunities"
          List<dynamic> pipelineDomain = [];

          // Handle "My Pipeline or Unassigned or My Assigned Partners or Open Opportunities" with OR logic
          if (hasMyPipeline && hasUnassigned && hasMyAssignedPartners && hasOpenOpportunities) {
            pipelineDomain.add('|');
            pipelineDomain.add('|');
            pipelineDomain.add('|');
            pipelineDomain.addAll(currentFilters['my_pipeline']!['domain']);
            pipelineDomain.addAll(currentFilters['unassigned']!['domain']);
            pipelineDomain.addAll(currentFilters['my_assigned_partners']!['domain']);
            pipelineDomain.addAll(currentFilters['open_opportunties']!['domain']);
          } else if (hasMyPipeline && hasUnassigned && hasMyAssignedPartners) {
            pipelineDomain.add('|');
            pipelineDomain.add('|');
            pipelineDomain.addAll(currentFilters['my_pipeline']!['domain']);
            pipelineDomain.addAll(currentFilters['unassigned']!['domain']);
            pipelineDomain.addAll(currentFilters['my_assigned_partners']!['domain']);
          } else if (hasMyPipeline && hasUnassigned && hasOpenOpportunities) {
            pipelineDomain.add('|');
            pipelineDomain.add('|');
            pipelineDomain.addAll(currentFilters['my_pipeline']!['domain']);
            pipelineDomain.addAll(currentFilters['unassigned']!['domain']);
            pipelineDomain.addAll(currentFilters['open_opportunties']!['domain']);
          } else if (hasMyPipeline && hasMyAssignedPartners && hasOpenOpportunities) {
            pipelineDomain.add('|');
            pipelineDomain.add('|');
            pipelineDomain.addAll(currentFilters['my_pipeline']!['domain']);
            pipelineDomain.addAll(currentFilters['my_assigned_partners']!['domain']);
            pipelineDomain.addAll(currentFilters['open_opportunties']!['domain']);
          } else if (hasUnassigned && hasMyAssignedPartners && hasOpenOpportunities) {
            pipelineDomain.add('|');
            pipelineDomain.add('|');
            pipelineDomain.addAll(currentFilters['unassigned']!['domain']);
            pipelineDomain.addAll(currentFilters['my_assigned_partners']!['domain']);
            pipelineDomain.addAll(currentFilters['open_opportunties']!['domain']);
          } else if (hasMyPipeline && hasUnassigned) {
            pipelineDomain.add('|');
            pipelineDomain.addAll(currentFilters['my_pipeline']!['domain']);
            pipelineDomain.addAll(currentFilters['unassigned']!['domain']);
          } else if (hasMyPipeline && hasMyAssignedPartners) {
            pipelineDomain.add('|');
            pipelineDomain.addAll(currentFilters['my_pipeline']!['domain']);
            pipelineDomain.addAll(currentFilters['my_assigned_partners']!['domain']);
          } else if (hasMyPipeline && hasOpenOpportunities) {
            pipelineDomain.add('|');
            pipelineDomain.addAll(currentFilters['my_pipeline']!['domain']);
            pipelineDomain.addAll(currentFilters['open_opportunties']!['domain']);
          } else if (hasUnassigned && hasMyAssignedPartners) {
            pipelineDomain.add('|');
            pipelineDomain.addAll(currentFilters['unassigned']!['domain']);
            pipelineDomain.addAll(currentFilters['my_assigned_partners']!['domain']);
          } else if (hasUnassigned && hasOpenOpportunities) {
            pipelineDomain.add('|');
            pipelineDomain.addAll(currentFilters['unassigned']!['domain']);
            pipelineDomain.addAll(currentFilters['open_opportunties']!['domain']);
          } else if (hasMyAssignedPartners && hasOpenOpportunities) {
            pipelineDomain.add('|');
            pipelineDomain.addAll(currentFilters['my_assigned_partners']!['domain']);
            pipelineDomain.addAll(currentFilters['open_opportunties']!['domain']);
          } else if (hasMyPipeline) {
            pipelineDomain.addAll(currentFilters['my_pipeline']!['domain']);
          } else if (hasUnassigned) {
            pipelineDomain.addAll(currentFilters['unassigned']!['domain']);
          } else if (hasMyAssignedPartners) {
            pipelineDomain.addAll(currentFilters['my_assigned_partners']!['domain']);
          } else if (hasOpenOpportunities) {
            pipelineDomain.addAll(currentFilters['open_opportunties']!['domain']);
          }

          // Temporary list for "Won or Lost"
          List<dynamic> wonLostDomain = [];

          // Handle "Won or Lost" with OR logic
          if (hasWon && hasLost) {
            wonLostDomain.add('|');
            wonLostDomain.addAll(currentFilters['won']!['domain']);
            wonLostDomain.addAll(currentFilters['lost']!['domain']);
          } else if (hasWon) {
            wonLostDomain.addAll(currentFilters['won']!['domain']);
          } else if (hasLost) {
            wonLostDomain.addAll(currentFilters['lost']!['domain']);
          }

          // Handle date filters
          bool hasDateFilter = false;
          for (String filterKey in selectedFilters) {
            if (filterKey == 'created_on' && selectedCreationDate != null) {
              DateTime selectedMonth = DateFormat('MMMM yyyy').parse(selectedCreationDate!);
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
              DateTime selectedMonth = DateFormat('MMMM yyyy').parse(selectedClosedDate!);
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

          // Combine pipeline domain
          if (pipelineDomain.isNotEmpty) {
            if (hasDateFilter) {
              domain = ['&', ...domain, ...pipelineDomain];
            } else {
              domain = [...domain, ...pipelineDomain];
            }
          }

          // Combine won/lost domain
          if (wonLostDomain.isNotEmpty) {
            if (pipelineDomain.isNotEmpty || hasDateFilter) {
              domain = ['&', ...domain, ...wonLostDomain];
            } else {
              domain = [...domain, ...wonLostDomain];
            }
          }


          if (hasArchived) {
            // Explicitly create a properly formatted domain
            List<dynamic> archivedCondition = [['active', '=', false]];

            if (domain.length > 1) {  // If domain already has conditions
              domain = ['&', ...domain, ...archivedCondition];
            } else {  // If domain only has the initial ['type', '=', 'opportunity']
              domain = [['type', '=', 'opportunity'], ...archivedCondition];
            }
          }

        // Add widget domain/team_id if present
        if (widget.domain != null && widget.domain!.isNotEmpty) {
        domain = ['&', ...widget.domain!, ...domain];
        } else if (widget.teamId != null) {
        domain = ['&', ['team_id', '=', widget.teamId], ...domain];
        }

          if(query.isNotEmpty){
            List<dynamic> searchDomain = [
              "|",
              "|",
              "|",
              "|",
              ["partner_id", "ilike", query],
              ["partner_name", "ilike", query],
              ["email_from", "ilike", query],
              ["name", "ilike", query],
              ["contact_name", "ilike", query],
            ];

            domain=[...domain,...searchDomain];
          }

        log('aasas${finalFilter.toString()}');
      final response = await client?.callKw({
        'model': 'crm.lead',
        'method': 'search_read',
        'args': [domain],
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
            'recurring_revenue_monthly',
            'probability',
            'recurring_revenue_monthly_prorated',
            'recurring_revenue_prorated',
            'prorated_revenue',
            'recurring_revenue',
            'activity_user_id',
            'date_closed',
            'type',
            'user_id',
            'team_id',
            'phone',

          ],
        }
      });
      log('dmn$domain');
      log('ressss$response');
      if (response != null) {
        leadsList = List<Map<String, dynamic>>.from(response);
        opportunitiesList = leadsList
            .where((lead) => lead['type'] == "opportunity")
            .toList();

        Map<String, List<Map<String, dynamic>>> groupedLeads = {};
        Map<String, int> stageIdMap = {};

        for (var lead in opportunitiesList) {
          if (lead['stage_id'] != null && lead['stage_id'] is List && lead['stage_id'].length > 1) {
            int stageId = lead['stage_id'][0]; // Numeric ID
            String stageName = lead['stage_id'][1] ?? ''; // Stage name
            stageIdMap[stageName] = stageId; // Map stage name to its ID
            groupedLeads.putIfAbsent(stageName, () => []).add(lead);
          }
        }

        // Sort groups by stage_id
        List<MapEntry<String, List<Map<String, dynamic>>>> sortedGroups = groupedLeads.entries.toList()
          ..sort((a, b) {
            int stageIdA = stageIdMap[a.key] ?? 0;
            int stageIdB = stageIdMap[b.key] ?? 0;
            return stageIdA.compareTo(stageIdB); // Sort by stage_id
          });

        controller.clear();

        for (var entry in sortedGroups) {
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
                leadId : lead['id'],
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
                activityIds:
                lead['activity_ids'] != null && lead['activity_ids'] is List
                    ? List<String>.from(
                    lead['activity_ids'].map((e) => e.toString()))
                    : [],
                salespersonId: lead['user_id'] != null && // Added this
                    lead['user_id'] is List &&
                    lead['user_id'].length > 0
                    ? lead['user_id'][0]
                    : null,
                imageData:
                profileImage != null ? base64Encode(profileImage!) : null,
              );
            }).toList(),
          );

          controller.addGroup(groupData);
        }

        if (opportunitiesList.isNotEmpty) {
          Map<String, double> stageValues = {};

          for (var item in opportunitiesList) {
            if (item['stage_id'] != null &&
                item['stage_id'] is List &&
                item['stage_id'].length > 1) {
              String stageName = item['stage_id'][1].toString();
              double value;
              if (selectedFilter == "count") {
                value = (stageValues[stageName] ?? 0) + 1;
              } else if (selectedFilter == "day_open" &&
                  item['day_open'] != false) {
                value = (stageValues[stageName] ?? 0) +
                    (item['day_open'] as double);
              } else if (selectedFilter == "day_close" &&
                  item['day_close'] != false) {
                value = (stageValues[stageName] ?? 0) +
                    (item['day_close'] as double);
              } else if (selectedFilter == "recurring_revenue_monthly" &&
                  item['recurring_revenue_monthly'] != false) {
                value = (stageValues[stageName] ?? 0) +
                    (item['recurring_revenue_monthly'] as double);
              } else if (selectedFilter == "expected_revenue" &&
                  item['expected_revenue'] != false) {
                value = (stageValues[stageName] ?? 0) +
                    (item['expected_revenue'] as double);
              } else if (selectedFilter == "probability" &&
                  item['probability'] != false) {
                value = (stageValues[stageName] ?? 0) +
                    (item['probability'] as double);
              } else if (selectedFilter ==
                  "recurring_revenue_monthly_prorated" &&
                  item['recurring_revenue_monthly_prorated'] != false) {
                value = (stageValues[stageName] ?? 0) +
                    (item['recurring_revenue_monthly_prorated'] as double);
              } else if (selectedFilter == "recurring_revenue_prorated" &&
                  item['recurring_revenue_prorated'] != false) {
                value = (stageValues[stageName] ?? 0) +
                    (item['recurring_revenue_prorated'] as double);
              } else if (selectedFilter == "prorated_revenue" &&
                  item['prorated_revenue'] != false) {
                value = (stageValues[stageName] ?? 0) +
                    (item['prorated_revenue'] as double);
              } else if (selectedFilter == "recurring_revenue" &&
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
      log("Odoo Fetch Failed: $e");
      setState(() {
        isLoading = false;
        showNoDataMessage = true;
      });
    }
  }
  Widget ChartSelection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
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
                icon: Icon(Icons.calendar_month,
                  color: selectedView == 2 ? Color(0xFF9EA700) : Colors.black,),
              ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedView = 3;
                  });
                },
                icon: Icon(Icons.table_rows_outlined,
                  color: selectedView == 3 ? Color(0xFF9EA700) : Colors.black,),
              ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedView = 4;
                  });
                },
                icon: Icon(Icons.graphic_eq_rounded,
                  color: selectedView == 4 ? Color(0xFF9EA700) : Colors.black,),
              ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedView = 5;
                  });
                },
                icon: Icon(Icons.access_time,
                  color: selectedView == 5 ? Color(0xFF9EA700) : Colors.black,),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listCard() {
    print('ghghghhg$leadsList');
    if (isLoading) {
      return Center(
        child: LoadingAnimationWidget.fourRotatingDots(
          color: Color(0xFF9EA700),
          size: 100,
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
              final revenue = lead['expected_revenue']?.toString() ?? '';
              final customerName = lead['contact_name'] == false
                  ? 'None'
                  : lead['contact_name']?.toString() ?? 'None';
              final email = lead['email_from'] == false ? 'None'
                  : lead['email_from']?.toString() ?? 'None';
              final stageName = lead['stage_id'] != null &&
                      lead['stage_id'] is List &&
                      lead['stage_id'].length > 1
                  ? lead['stage_id'][1]
                  : "None";
              final salesperson = lead['user_id'] != null &&
                      lead['user_id'] is List &&
                      lead['user_id'].length > 1
                  ? lead['user_id'][1]
                  : "None";
              final mrr = lead['recurring_revenue_monthly'] ?? 'None';
              final hasActivity = lead['activity_ids'] != null &&
                  lead['activity_ids'] is List &&
                  lead['activity_ids'].isNotEmpty;
              final activityIds =
                  lead['activity_ids'] != null && lead['activity_ids'] is List
                      ? List<int>.from(lead['activity_ids'])
                      : [];
              final activityState =
                  lead['activity_state']?.toString().toLowerCase() ?? 'None';
              imageData:
              profileImage != null ? base64Encode(profileImage!) : null;

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
                    ))
                  : GestureDetector(
                  onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LeadDetailPage(leadId: leadId),
                  ),
                );
              },
                    child: Card(
                        color: Colors.white,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        // Rounded corners
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
                                          //   // side: BorderSide(color: Colors.green.shade200),
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
                                          // side: BorderSide(color: Colors.green.shade200),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    if (hasActivity &&
                                        activityState.toLowerCase() != "overdue")
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          icon: Icon(
                                            Icons.snooze_rounded,
                                            size: 16,
                                            color: Colors.black,
                                          ),
                                          label: Text(
                                            'Snooze 7d',
                                            overflow: TextOverflow
                                                .ellipsis,
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
                // icon: const Icon(Icons.add, size: 20),
                // title: const Text('New'),
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
          opportunitiesList: opportunitiesList,
            activityTypes: activityTypes,
        );
      default:
        return Container();
    }
  }


  Widget activityView(){

    return Column(
      children: [
        Container(
          color: Colors.red,
          child: Text('data'),
        )

      ],
    );
  }





  Widget calendarView() {
    List<Appointment> appointments = [];
    Map<String, Map<String, dynamic>> appointmentLeadMap = {};

    for (var lead in leadsList) {
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
              id: appointmentId
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
        headerStyle: CalendarHeaderStyle(backgroundColor:  Color(0x69EA700),),
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
      double revenue = double.tryParse(lead['expected_revenue']?.toString() ?? "0") ?? 0.0;

      // groupedData.putIfAbsent(formattedDate, () => {'date': formattedDate});
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
                if (selectedReport == 'Partnerships')
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border(
                        left: BorderSide(
                          color: selectedFilter == "turnover"
                              ? Color(0xFF656805)
                              : Colors.transparent,
                          width: 6, // Border thickness
                        ),
                      ),
                    ),
                    child: ListTile(
                      leading: Icon(
                        selectedFilter == "turnover"
                            ? Icons.done
                            : Icons.timelapse,
                        color: Color(0xFF9EA700),
                      ),
                      title: Text('Turnover'),
                      onTap: () {
                        applyFilter("turnover", 'Turnover');
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
                if (selectedReport != "Activities" &&
                    selectedReport != "Partnerships") ...[
                  if (selectedReport == 'Leads' || selectedReport == 'Pipeline')
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
                  if (selectedReport == 'Leads' || selectedReport == 'Pipeline')
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
                        applyFilter(
                            "recurring_revenue_monthly", 'Expected MRR');
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
                  if (selectedReport == 'Leads' || selectedReport == 'Pipeline')
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
                        applyFilter("recurring_revenue_monthly_prorated",
                            'Prorated MRR');
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
          padding: EdgeInsets.only(left: 10, ),
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
                  Expanded(child: Icon(Icons.arrow_drop_down,color: Colors.white,)),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 150,),
        Container(
          height: 37,
          width: 37,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Color(0x279EA700)
          ),
          child: IconButton(
              onPressed: () => changeChartType("bar"),
              icon: Icon(Icons.bar_chart_rounded,
                  color: selectedChart == 'bar'
                      ? Color(0xFF9EA700)
                      : Colors.black)),
        ),
        SizedBox(width: 5,),
        Container(
          height: 37,
          width: 37,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Color(0x279EA700)
          ),
          child: IconButton(
              onPressed: () => changeChartType("line"),
              icon: Icon(Icons.stacked_line_chart_rounded,
                  color: selectedChart == 'line'
                      ? Color(0xFF9EA700)
                      : Colors.black)),
        ),
        SizedBox(width: 5,),
        Padding(
          padding: EdgeInsets.only(right: 6),
          child: Container(
            height: 37,
            width: 37,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Color(0x279EA700)
            ),
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

  Widget customCard(AppFlowyGroupItem item) {
    if (item is LeadItem) {
      return InkWell( onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LeadDetailPage(leadId: item.leadId),
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
                    SizedBox(
                      height: 6,
                    ),
                    Wrap(
                      spacing: 5,
                      children: item.tags.map((tag) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
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
                            index < item.priority
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 8),
                        ActivityIconDesign(item.activityState, item.activityType),
                        SizedBox(
                          width: 58,
                        ),
                        FutureBuilder<Uint8List?>(
                          future: item.salespersonId != null && client != null
                              ? GetImage().fetchImage(item.salespersonId!, client!)
                              : Future.value(null),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Container(
                                width: 24,
                                height: 24,
                                margin: EdgeInsets.only(left: 8),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.grey,
                                ),
                              );
                            } else if (snapshot.hasData && snapshot.data != null) {
                              return Container(
                                width: 24,
                                height: 24,
                                margin: EdgeInsets.only(left: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  image: DecorationImage(
                                    image: MemoryImage(snapshot.data!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            } else {
                              return Container(
                                width: 24,
                                height: 24,
                                margin: EdgeInsets.only(left: 8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade300,
                                ),
                                child: Icon(
                                  Icons.person,
                                  size: 16,
                                  color: Colors.grey.shade700,
                                ),
                              );
                            }
                          },
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
    if (widget.teamId == null && (widget.domain == null || widget.domain!.isEmpty)) {
      selectedFilters = {'my_pipeline'};
    } else {
      selectedFilters = {};
    }
    initializeOdooClient();
    boardController = AppFlowyBoardScrollController();
    searchController.addListener(_onSearchChanged);
  }


  Future<void> getSession()async{
    final prefs = await SharedPreferences.getInstance();
    final session = prefs.getString("sessionId") ?? "";


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            : const Text("Pipeline"),
        elevation: 0,
        backgroundColor: const Color(0xFF9EA700),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (isSearching) {
                  searchController.clear();
                  isSearching = false;
                  pipe();
                } else {
                  isSearching = true;
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => showFilterDialog(context),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body:isLoading
          ? Center(
        child: LoadingAnimationWidget.fourRotatingDots(
          color: Color(0xFF9EA700),
          size: 100,
        ),
      )
          : leadsList.isEmpty
          ? const Center(child: Text('No data found'))
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
                  'Pipeline',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ],
            ),
          ),
          Divider(thickness: 1, color: Colors.grey.shade300),
          ChartSelection(),
          Divider(thickness: 1, color: Colors.grey.shade300),
          selectedView == 4 ?
          buildChartSelection():SizedBox(),
          SizedBox(height: 7,),
          Expanded(child: iconSelectedView()),
        ],
      ),
    );
  }
}

class SalesDataGridWidget extends StatefulWidget {
  final List<Map<String, dynamic>> opportunitiesList;
  final List<String> activityTypes;

  const SalesDataGridWidget({
    Key? key,
    required this.opportunitiesList,
    required this.activityTypes,
  }) : super(key: key);

  @override
  _SalesDataGridWidgetState createState() => _SalesDataGridWidgetState();
}

class _SalesDataGridWidgetState extends State<SalesDataGridWidget> {
  late SalesDataSource salesDataSource;
  bool isLoading = true;
  bool processing = false;
  Map<int, Uint8List> userImages = {};

  Future<int?> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  void processData() async {
    setState(() {
      isLoading = true;
    });

    List<Map<String, dynamic>> filteredOpportunities = widget.opportunitiesList
        .where((opportunity) =>
    opportunity['activity_type_id'] != null &&
        opportunity['activity_type_id'] is List &&
        opportunity['activity_type_id'].length > 1)
        .toList();

    final currentUserId = await getCurrentUserId();
    if (currentUserId != null && !userImages.containsKey(currentUserId)) {
      try {
        final response = await client?.callKw({
          'model': 'res.users',
          'method': 'search_read',
          'args': [
            [
              ['id', '=', currentUserId],
            ]
          ],
          'kwargs': {
            'fields': ['image_1920'],
          },
        });

        if (response != null && response is List && response.isNotEmpty) {
          final userData = response[0];
          var imageData = userData['image_1920'];
          if (imageData != null && imageData is String) {
            userImages[currentUserId] = base64Decode(imageData);
          }
        }
      } catch (e) {
        print("Error fetching current user image: $e");
      }
    }

    salesDataSource = SalesDataSource(
      processOpportunities(filteredOpportunities),
      widget.activityTypes,
      userImages,
      context, // Pass the context here
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });

    await fetchUserImages();
    processData();
  }

  @override
  void didUpdateWidget(SalesDataGridWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.opportunitiesList != widget.opportunitiesList ||
        oldWidget.activityTypes != widget.activityTypes) {
      processData();
    }
  }

  Future<void> fetchUserImages() async {
    final prefs = await SharedPreferences.getInstance();
    final userIds = widget.opportunitiesList
        .where((opp) => opp['activity_user_id'] != null && opp['activity_user_id'] is List)
        .map((opp) => opp['activity_user_id'][0] as int)
        .toSet()
        .toList();

    if (userIds.isEmpty) {
      setState(() => isLoading = false);
      return;
    }

    try {
      final response = await client?.callKw({
        'model': 'res.users',
        'method': 'search_read',
        'args': [
          [
            ['id', 'in', userIds],
          ]
        ],
        'kwargs': {
          'fields': ['image_1920', 'name'],
        },
      });
      print('opppoo$response');
      if (response == null || response.isEmpty || response is! List) {
        print('No user data received or invalid format');
        setState(() => isLoading = false);
        return;
      }

      final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(response);
      setState(() {
        for (var user in data) {
          var imageData = user['image_1920'];
          if (imageData != null && imageData is String) {
            userImages[user['id']] = base64Decode(imageData);
          }
        }
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching user images: $e");
      setState(() => isLoading = false);
    }
  }

  List<Map<String, dynamic>> processOpportunities(List<Map<String, dynamic>> opportunities) {
    return opportunities.map((opportunity) {
      Map<String, dynamic> salesData = {
        'id': opportunity['id'],
        'name': opportunity['name'] ?? 'None',
        'expected_revenue': opportunity['expected_revenue'] != null
            ? '\$${opportunity['expected_revenue'].toString()}'
            : '\$0',
        'stage_id': opportunity['stage_id'] != null && opportunity['stage_id'] is List
            ? opportunity['stage_id'][1].toString()
            : 'New',
        'partner_id': opportunity['partner_id'] != null && opportunity['partner_id'] is List
            ? opportunity['partner_id'][1].toString()
            : '',
        'activity_user_id': opportunity['activity_user_id'] != null &&
            opportunity['activity_user_id'] is List
            ? opportunity['activity_user_id'][0] as int
            : null,
        'user_id' :opportunity['user_id'] != null &&
            opportunity['user_id'] is List
            ? opportunity['user_id'][0] as int
            : null,
      };

      for (var type in widget.activityTypes) {
        salesData[type] = '';
      }

      if (opportunity['activity_type_id'] != null &&
          opportunity['activity_type_id'] is List &&
          opportunity['activity_type_id'].length > 1) {
        String activityType = opportunity['activity_type_id'][1].toString();
        if (widget.activityTypes.contains(activityType)) {
          salesData[activityType] = opportunity['activity_date_deadline'] ?? '';
        }
      }

      return salesData;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (processing) {
      processData();
      processing = false;
    }
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SfDataGrid(
      source: salesDataSource,
      columns: getColumns(),
      gridLinesVisibility: GridLinesVisibility.both,
      headerGridLinesVisibility: GridLinesVisibility.both,
    );
  }

  List<GridColumn> getColumns() {
    List<GridColumn> columns = [
      GridColumn(
        columnName: 'opportunity',
        label: Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: const Text(''),
        ),
        width: 300,
      ),
    ];

    for (var activityType in widget.activityTypes) {
      columns.add(
        GridColumn(
          columnName: activityType,
          label: buildHeader(activityType),
          width: 120,
        ),
      );
    }

    return columns;
  }

  Widget buildHeader(String text) {
    return Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class SalesDataSource extends DataGridSource {
  List<DataGridRow> dataGridRows = [];
  final List<String> activityTypes;
  final Map<int, Uint8List> userImages;
  Uint8List? currentUserImage;
  final BuildContext context;

  SalesDataSource(List<Map<String, dynamic>> salesList, this.activityTypes,
      this.userImages, this.context) {
    currentUserImage = null;
    _getCurrentUserImage();

    dataGridRows = salesList.map<DataGridRow>((salesData) {
      List<DataGridCell> cells = [];

      cells.add(DataGridCell<Map<String, dynamic>>(
        columnName: 'opportunity',
        value: salesData,
      ));

      for (var activityType in activityTypes) {
        cells.add(
          DataGridCell<String>(
            columnName: activityType,
            value: salesData.containsKey(activityType)
                ? salesData[activityType]
                : '',
          ),
        );
      }

      return DataGridRow(cells: cells);
    }).toList();
  }

  Future<void> _getCurrentUserImage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentUserId = prefs.getInt('userId');

      if (currentUserId != null && userImages.containsKey(currentUserId)) {
        currentUserImage = userImages[currentUserId];
      } else if (currentUserId != null) {
        final response = await client?.callKw({
          'model': 'res.users',
          'method': 'search_read',
          'args': [
            [
              ['id', '=', currentUserId],
            ]
          ],
          'kwargs': {
            'fields': ['image_1920'],
          },
        });

        if (response != null && response is List && response.isNotEmpty) {
          final userData = response[0];
          var imageData = userData['image_1920'];
          if (imageData != null && imageData is String) {
            currentUserImage = base64Decode(imageData);
          }
        }
      }
    } catch (e) {
      print("Error fetching current user image: $e");
    }
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataCell) {
        if (dataCell.columnName == 'opportunity') {
          final salesData = dataCell.value as Map<String, dynamic>;
          return OpportunityColumn(salesData, currentUserImage, context); // Pass context here
        }

        String activityDate = dataCell.value.toString();
        DateTime? parsedDate = activityDate.isNotEmpty ? DateTime.tryParse(activityDate) : null;
        DateTime today = DateTime.now();

        Color cellColor = Colors.transparent;
        if (parsedDate != null) {
          if (parsedDate.isBefore(today)) {
            cellColor = Colors.red;
          } else {
            cellColor = Colors.green;
          }
        }

        final opportunityCell = row.getCells().firstWhere((cell) => cell.columnName == 'opportunity');
        final salesData = opportunityCell.value as Map<String, dynamic>;
        int? userId = salesData['activity_user_id'];
        Uint8List? userImage = userId != null ? userImages[userId] : null;
        bool hasActivity = parsedDate != null && userImage != null;

        return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          color: cellColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dataCell.value.toString(),
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
              if (hasActivity) ...[
                const SizedBox(height: 4),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    image: DecorationImage(
                      image: MemoryImage(userImage!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget OpportunityColumn(Map<String, dynamic> salesData, Uint8List? userImage, BuildContext context) {


    return InkWell(
      onTap: () {
        final leadId = salesData['id'];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LeadDetailPage(leadId: leadId),
          ),
        );
      },
      child: Row(
        children: [
          const SizedBox(width: 5),
          FutureBuilder<Uint8List?>(
            future: salesData['user_id'] != null && client != null
                ? GetImage().fetchImage(salesData['user_id'], client!)
                : Future.value(null),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.grey,
                  ),
                );
              } else if (snapshot.hasData && snapshot.data != null) {
                return Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    image: DecorationImage(
                      image: MemoryImage(snapshot.data!),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              } else {
                return Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade700,
                        Colors.blue.shade500,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.person, size: 18, color: Colors.white),
                );
              }
            },
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      salesData['name'] ?? 'No Name',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 7),
                      child: Text(
                        salesData['expected_revenue'] ?? '\$0',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      salesData['partner_id'] ?? '',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, top: 2.0),
                      child: Container(
                        height: 25,
                        width: 50,
                        color: Colors.grey.shade300,
                        child: Center(
                          child: Text(
                            salesData['stage_id'] ?? 'New',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF9EA700),
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
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


class LeadItem extends AppFlowyGroupItem {
  final int  leadId ;
  final String name;
  final String revenue;
  final String customerName;
  final List<String> tags;
  final int priority;
  final String activityState;
  final String activityType;
  final String? imageData;
  final bool hasActivity;
  final int? salespersonId;
  final List<String> activityIds;

  LeadItem({
    required this.leadId,
    required this.name,
    required this.revenue,
    required this.customerName,
    required this.tags,
    required this.priority,
    this.activityState = '',
    this.activityType = '',
    this.imageData,
    this.salespersonId,
    required this.hasActivity,
    required this.activityIds,
  });

  @override
  String get id => name;
}
