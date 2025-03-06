import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:appflowy_board/appflowy_board.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Mypipeline extends StatefulWidget {
  const Mypipeline({super.key});

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
  Future<void> initializeOdooClient() async {
    final prefs = await SharedPreferences.getInstance();
    final baseUrl = prefs.getString("urldata") ?? "";
    final dbName = prefs.getString("selectedDatabase") ?? "";
    final userLogin = prefs.getString("userLogin") ?? "";
    final userPassword = prefs.getString("password") ?? "";

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
        await act();

      } catch (e) {
        print("Odoo Authentication Failed: $e");
      }
    }
    setState(() => isLoading = false);
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

  Future<void> pipe() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getInt("userId") ?? "";
    print('iddddd$userid');
    try {
      Map<int, String> tagMap = await tag();
      final response = await client?.callKw({
        'model': 'crm.lead',
        'method': 'search_read',
        'args': [
          [
            ["type", "=", "opportunity"],
            ["user_id", "=", userid],
          ]
        ],
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
          ],
        }
      });
      print('ressss$response');
      if (response != null) {
        leadsList = List<Map<String, dynamic>>.from(response);
        // calendarOppurtunity(leadsList);
        Map<String, List<Map<String, dynamic>>> groupedLeads = {};
        opportunitiesList = List<Map<String, dynamic>>.from(response);


        for (var lead in response) {
          String stage = lead['stage_id'][1] ?? '';
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
                name: lead['name'],
                revenue: lead['expected_revenue'].toString(),
                customerName: lead['partner_id'] != null &&
                    lead['partner_id'] is List &&
                    lead['partner_id'].length > 1
                    ? lead['partner_id'][1]
                    : "",
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
                imageData:
                profileImage != null ? base64Encode(profileImage!) : null,
              );
            }).toList(),
          );

          controller.addGroup(groupData);
        }

        if (response != null && response is List) {
          Map<String, double> stageValues = {};

          for (var item in response) {
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
              //print('adadadad${stageName}');
            }
          }


          setState(() {
            chartDatavalues.clear();

            // print(selectedReport);

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
        }
      }
    } catch (e) {
      print("Odoo Fetch Failed: $e");
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
                  : Card(
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
                                    onPressed: () {},
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
                                    onPressed: () {},
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
                    );
            },
          );
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
                    Navigator.of(context).pop();
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
                  onPressed: () {
                    Navigator.of(context).pop();
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
      return Row(
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
                      if (item.imageData != null && item.imageData!.isNotEmpty)
                        Container(
                          width: 24,
                          height: 24,
                          margin: EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                              image: MemoryImage(
                                base64Decode(item.imageData!),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      else
                        Container(
                          width: 24,
                          height: 24,
                          margin: EdgeInsets.only(left: 55),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade300,
                          ),
                          child: Icon(
                            Icons.person,
                            size: 16,
                            color: Colors.grey.shade700,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
    throw UnimplementedError();
  }

  @override
  void initState() {
    super.initState();
    initializeOdooClient();
    boardController = AppFlowyBoardScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9EA700),
        title: Text('Pipeline'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded)),
          SizedBox(
            width: 4,
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.filter_list_sharp)),
          SizedBox(
            width: 4,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Divider(thickness: 2, color: Colors.grey.shade300),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pipeline',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      foregroundColor: Color(0xFF9EA700),
                    ),
                    child: Text(
                      'Generate Leads',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )),
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


  @override
  void initState() {
    super.initState();
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


  void processData() {
    setState(() {
      isLoading = true;
    });
    List<Map<String, dynamic>> filteredOpportunities = widget.opportunitiesList
        .where((opportunity) =>
    opportunity['activity_type_id'] != null &&
        opportunity['activity_type_id'] is List &&
        opportunity['activity_type_id'].length > 1)
        .toList();

    salesDataSource = SalesDataSource(
      processOpportunities(filteredOpportunities),
      widget.activityTypes,
    );

    setState(() {
      isLoading = false;
    });
  }

  List<Map<String, dynamic>> processOpportunities(List<Map<String, dynamic>> opportunities) {
    return opportunities.map((opportunity) {
      Map<String, dynamic> salesData = {
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
        'imagePath': 'assets/user1.png',
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
      processing = true;
    }
    if(isLoading)
      {
      return  Center(child: CircularProgressIndicator());
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

  SalesDataSource(List<Map<String, dynamic>> salesList, this.activityTypes) {
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
            value: salesData.containsKey(activityType) ? salesData[activityType] : '',
          ),
        );
      }

      return DataGridRow(cells: cells);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataCell) {
        if (dataCell.columnName == 'opportunity') {
          final salesData = dataCell.value as Map<String, dynamic>;
          return buildOpportunityCell(salesData);
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
        return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          color: cellColor,
          child: Text(
            dataCell.value.toString(),
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        );
      }).toList(),
    );
  }

  Widget buildOpportunityCell(Map<String, dynamic> salesData) {
    return Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundImage: AssetImage(salesData['imagePath']),
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
                    salesData['name'],
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 7),
                    child: Text(
                      salesData['expected_revenue'],
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
                    salesData['partner_id'],
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
                          salesData['stage_id'],
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
  final String name;
  final String revenue;
  final String customerName;
  final List<String> tags;
  final int priority;
  final String activityState;
  final String activityType;
  final String? imageData;
  final bool hasActivity;
  final List<String> activityIds;

  LeadItem({
    required this.name,
    required this.revenue,
    required this.customerName,
    required this.tags,
    required this.priority,
    this.activityState = '',
    this.activityType = '',
    this.imageData,
    required this.hasActivity,
    required this.activityIds,
  });

  @override
  String get id => name;
}
