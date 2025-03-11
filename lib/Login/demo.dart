import 'dart:convert';
import 'dart:developer';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cyllo_mobile/Profile/profilePage.dart';
import 'package:cyllo_mobile/Sales/myPipeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:typed_data';

import '../Sales/myActivities.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}

class _DemoState extends State<Demo> {
  List<ChartData> chartDatavalues = [];
  OdooClient? client;
  bool isLoading = true;
  String selectedFilter = "count";
  String selectedChart = "bar";
  String showVariable = "count";
  String? selectedReport;
  String model = "";
  String? type;
  List fields = [];
  bool showNoDataMessage = false;
  Uint8List? profileImage;
  bool imageLoad = true;

  @override
  void initState() {
    super.initState();
    initializeOdooClient();
  }

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
        await getChartData();
        await imageData();
      } catch (e) {
        print("Odoo Authentication Failed: $e");
      }
    }
    setState(() => isLoading = false);
  }

  Future<void> getChartData() async {
    if (model.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getInt("userId") ?? "";
    print('sdsdsdsds$userid');
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    if (selectedReport == "Leads" || selectedReport == "Pipeline") {
      try {
        print(model);
        print(type);
        print(fields);
        List conditions = [];
        if (type != null) {
          if (selectedReport == "Leads") {
            conditions.clear();
            conditions.add(
              ['type', '=', type],
            );
          } else {
            conditions.clear();
            conditions.add(
              ['type', '=', type],
            );
            conditions.add(
              ["user_id", "=", userid],
            );
          }

          print("aaaaaaaaaaaaa$conditions");
        }
        final response = await client?.callKw({
          'model': model,
          'method': 'search_read',
          'args': [conditions],
          'kwargs': {
            'fields': fields,
          },
        });

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

            print(selectedReport);

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
      } catch (e) {
        print("Error fetching data: $e");
        setState(() => isLoading = false);
      }
    } else if (selectedReport == 'Forecast') {
      print('1');

      List conditions = [];
      chartDatavalues.clear();
      if (type != null) {
        conditions.add(['type', '=', type]);
      }
      print('2');
      final response = await client?.callKw({
        'model': model,
        'method': 'search_read',
        'args': [
          [
            // ["date_deadline", "=", false],
            ["user_id", "=", userid],
            ['type', '=', 'opportunity'],
          ]
        ],
        'kwargs': {'fields': fields},
      });
      log('3$response');
      if (response == null || response.isEmpty || response is! List) {
        print('No data received or invalid format');
        setState(() => isLoading = false);
        return;
      }
      try {
        final List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(response);
        // Map<String, double> forecastCounts = {};
        Map<String, double> forecastValues = {};
        double noneValue = 0;
        log('dataaaaaaaaaaa$data');
        for (var item in data) {
          if (item['date_deadline'] != null &&
              item['date_deadline'] is String) {
            DateTime currentDate = DateTime.now();
            DateTime tempDate =
                DateFormat("yyyy-MM-dd").parse(item['date_deadline']);
            print("dayyyyyyyyyyyyyyy$tempDate");
            DateTime date = DateTime.parse(item['date_deadline']);
            String monthYear = DateFormat('MMMM yyyy').format(date);
            double value = forecastValues[monthYear] ?? 0;
            log('before check${item.length}');
            if (tempDate
                .isAfter(DateTime(currentDate.year, currentDate.month, 1))) {
              log('after check&${item.length} ');
              if (selectedFilter == "count") {
                value += 1;
              } else if (selectedFilter == "recurring_revenue_monthly" &&
                  item['recurring_revenue_monthly'] != false) {
                value += (item['recurring_revenue_monthly'] as double);
              } else if (selectedFilter == "expected_revenue" &&
                  item['expected_revenue'] != false) {
                value += (item['expected_revenue'] as double);
              } else if (selectedFilter ==
                      "recurring_revenue_monthly_prorated" &&
                  item['recurring_revenue_monthly_prorated'] != false) {
                value += (item['recurring_revenue_monthly_prorated'] as double);
              } else if (selectedFilter == "recurring_revenue_prorated" &&
                  item['recurring_revenue_prorated'] != false) {
                value += (item['recurring_revenue_prorated'] as double);
              } else if (selectedFilter == "prorated_revenue" &&
                  item['prorated_revenue'] != false) {
                value += (item['prorated_revenue'] as double);
              } else if (selectedFilter == "recurring_revenue" &&
                  item['recurring_revenue'] != false) {
                value += (item['recurring_revenue'] as double);
              }
              forecastValues[monthYear] = value;
            }
          } else if (item['date_deadline'] == false) {
            print('itemmmmmm$item');
            print("ansaf");
            log("beffffff${item.length}");
            double itemValue = 0;
            print('wrokingggg');
            if (selectedFilter == "count") {
              itemValue = 1;
            } else if (selectedFilter == "recurring_revenue_monthly" &&
                item['recurring_revenue_monthly'] is num) {
              itemValue = item['recurring_revenue_monthly'].toDouble();
            } else if (selectedFilter == "expected_revenue" &&
                item['expected_revenue'] is num) {
              itemValue = item['expected_revenue'].toDouble();
            } else if (selectedFilter == "recurring_revenue_monthly_prorated" &&
                item['recurring_revenue_monthly_prorated'] is num) {
              itemValue = item['recurring_revenue_monthly_prorated'].toDouble();
            } else if (selectedFilter == "recurring_revenue_prorated" &&
                item['recurring_revenue_prorated'] is num) {
              itemValue = item['recurring_revenue_prorated'].toDouble();
            } else if (selectedFilter == "prorated_revenue" &&
                item['prorated_revenue'] is num) {
              itemValue = item['prorated_revenue'].toDouble();
            } else if (selectedFilter == "recurring_revenue" &&
                item['recurring_revenue'] is num) {
              itemValue = item['recurring_revenue'].toDouble();
            }

            noneValue += itemValue;
          }
        }

        if (noneValue > 0) {
          forecastValues["None"] = noneValue;
          print('nonnnnnn$noneValue');
        }
        setState(() {
          chartDatavalues.clear();
          chartDatavalues = forecastValues.entries
              .map((entry) => ChartData(entry.key, entry.value))
              .toList();
          print('lllloooooooo$chartDatavalues');
          if (chartDatavalues.isEmpty ||
              chartDatavalues.every((data) => data.y == 0)) {
            showNoDataMessage = true;
          } else {
            showNoDataMessage = false;
          }
          isLoading = false;
        });

        print('Chart data updated');
      } catch (e) {
        print("Error processing forecast data ");
        setState(() => isLoading = false);
      }
    } else if (selectedReport == "Activities") {
      final response = await client?.callKw({
        'model': "crm.activity.report",
        'method': 'search_read',
        'args': "",
        'kwargs': {'fields': fields},
      });
      final data = response as List;
      print('findddd$data');
      setState(() {
        chartDatavalues.clear();
        DateTime date = DateTime.parse(data[0]['date']);
        String monthYear = DateFormat('MMMM yyyy').format(date);
        chartDatavalues.add(ChartData(monthYear, data.length.toDouble()));
        isLoading = false;
        if (chartDatavalues.isEmpty) {
          showNoDataMessage = true;
        } else {
          showNoDataMessage = false;
        }
      });
    } else {
      final response = await client?.callKw({
        'model': model,
        'method': 'search_read',
        'args': "",
        'kwargs': {'fields': fields},
      });
      if (response != null && response is List) {
        Map<String, double> stageValues = {};
        print("partner dataa$response");
        for (var item in response) {
          if (item['grade_id'] != null && item['grade_id'] is List) {
            String stageName = item['grade_id'][1].toString();
            double value;
            if (selectedFilter == "count") {
              value = (stageValues[stageName] ?? 0) + 1;
            } else {
              value = 0;
            }
            stageValues[stageName] = value;
          }
          setState(() {
            chartDatavalues.clear();
            Set<String> stageOrderSet = stageValues.keys.toSet();
            List<String> stageOrder = stageOrderSet.toList();
            List<ChartData> sortedData = stageOrder
                .where((stage) => stageValues.containsKey(stage))
                .map((stage) => ChartData(stage, stageValues[stage]!))
                .toList();

            if (sortedData.isEmpty || sortedData.every((data) => data.y == 0)) {
              print("soorrrrrrrr$sortedData");
              chartDatavalues = [];
              showNoDataMessage = true;
            } else {
              chartDatavalues = sortedData;
              showNoDataMessage = false;
            }

            // chartDatavalues = sortedData;

            isLoading = false;
          });
        }
      }
    }
  }

  Widget buildReportTypeDropdown() {
    final dropvalues = [
      'Leads',
      'Activities',
      'Forecast',
      'Pipeline',
      'Partnerships'
    ];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
        child: CustomDropdown<String>(
          decoration:
              CustomDropdownDecoration(closedFillColor: Colors.grey.shade300),
          hintText: 'Reporting',
          items: dropvalues,
          initialItem: selectedReport,
          onChanged: (value) {
            log('changing value to: $value');
            setState(() {
              selectedReport = value!;
              isLoading = true;
              switch (value) {
                case "Leads":
                  model = "crm.lead";
                  type = "lead";
                  fields = [
                    'stage_id',
                    'day_open',
                    'day_close',
                    'recurring_revenue_monthly',
                    'expected_revenue',
                    'probability',
                    'recurring_revenue_monthly_prorated',
                    'recurring_revenue_prorated',
                    'prorated_revenue',
                    'recurring_revenue',
                  ];
                  break;
                case "Pipeline":
                  model = "crm.lead";
                  type = "opportunity";
                  fields = [
                    'stage_id',
                    'day_open',
                    'day_close',
                    'recurring_revenue_monthly',
                    'expected_revenue',
                    'probability',
                    'recurring_revenue_monthly_prorated',
                    'recurring_revenue_prorated',
                    'prorated_revenue',
                    'recurring_revenue',
                  ];
                  break;
                case "Activities":
                  model = "crm.activity.report";
                  type = "";
                  fields = [
                    'id',
                    'date',
                  ];
                  break;
                case "Forecast":
                  model = "crm.lead";
                  type = "opportunity";
                  fields = [
                    'user_id',
                    'id',
                    'date_deadline',
                    'recurring_revenue_monthly',
                    'expected_revenue',
                    'recurring_revenue_monthly_prorated',
                    'recurring_revenue_prorated',
                    'prorated_revenue',
                    'recurring_revenue',
                  ];
                  break;
                case "Partnerships":
                  model = "crm.partner.report.assign";
                  type = "";
                  fields = ['turnover', 'grade_id'];
                default:
                  model = "";
                  type = null;
              }
            });

            getChartData();
          },
        ),
      ),
    );
  }

  Widget buildChartSelection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: 360,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.grey.shade300,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, top: 8, bottom: 8),
              child: ElevatedButton(
                onPressed: () => filterOptions(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF9EA700),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: Text('Measure'),
              ),
            ),
            VerticalDivider(width: 20, thickness: 2, color: Colors.white),
            IconButton(
                onPressed: () => changeChartType("bar"),
                icon: Icon(Icons.bar_chart_rounded,
                    color: selectedChart == 'bar'
                        ? Color(0xFF9EA700)
                        : Colors.black)),
            VerticalDivider(width: 20, thickness: 2, color: Colors.white),
            IconButton(
                onPressed: () => changeChartType("line"),
                icon: Icon(Icons.stacked_line_chart_rounded,
                    color: selectedChart == 'line'
                        ? Color(0xFF9EA700)
                        : Colors.black)),
            VerticalDivider(width: 20, thickness: 2, color: Colors.white),
            Padding(
              padding: EdgeInsets.only(right: 6),
              child: IconButton(
                  onPressed: () => changeChartType("pie"),
                  icon: Icon(Icons.pie_chart_rounded,
                      color: selectedChart == 'pie'
                          ? Color(0xFF9EA700)
                          : Colors.black)),
            ),
          ],
        ),
      ),
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
    getChartData();
    Navigator.pop(context);
  }

  Widget SimmerLoad() {
    return Padding(
      padding: EdgeInsets.all(2),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          children: [
            CircleAvatar(
              radius: 18.0,
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> imageData() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getInt("userId") ?? "";
    print('iddddd$userid');
    try {
      setState(() {
        isLoading = true;
      });
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
          ]
        },
      });
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
        });
        print('dataaaaaaaaaaaaa$data');
        print('response$response');
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        print("Odoo fetch Failed: $e");
      }
    } catch (e) {
      print("Error processing forecast data ");
      setState(() => isLoading = false);
    }
  }

  bool Selected = false;
  int selectedIndex = -1;
  bool expand = false;
  bool subMenus = false;
  List<String> Options = [
    'My Pipeline',
    'My Activities',
    'My Quotations',
    'Teams',
    'Customers'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Color(0xFF9EA700),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/images.png',
                width: 150,
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                      expand = !expand;
                    });
                  },
                  shape: selectedIndex == 1
                      ? RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        )
                      : null,
                  tileColor:
                      selectedIndex == 1 ? Colors.white : Color(0xFF9EA700),
                  title: Text(
                    'Sales',
                    style: TextStyle(
                        color: selectedIndex == 1
                            ? Color(0xFF9EA700)
                            : Colors.white70,
                        fontSize: 20),
                  ),
                  trailing: Icon(
                    expand
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color:
                        selectedIndex == 1 ? Color(0xFF9EA700) : Colors.white70,
                  ),
                ),
              ),
              Visibility(
                visible: expand,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: Column(
                    children: Options.map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          onTap: () {
                            if(item =="My Pipeline"){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Mypipeline()));
                            }
                            else if(item == 'My Activities'){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Myactivity()));
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          tileColor: Colors.white.withOpacity(0.2),
                          title: Text(
                            item,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          leading: Icon(Icons.circle,
                              size: 8, color: Colors.white70),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () {
                    setState(() {
                      selectedIndex = 2;
                      expand = false;
                    });
                  },
                  shape: selectedIndex == 2
                      ? RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        )
                      : null,
                  tileColor:
                      selectedIndex == 2 ? Colors.white : Color(0xFF9EA700),
                  title: Text(
                    'Leads',
                    style: TextStyle(
                        color: selectedIndex == 2
                            ? Color(0xFF9EA700)
                            : Colors.white70,
                        fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Profilepage()));
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: isLoading
                  ? SimmerLoad()
                  : CircleAvatar(
                      backgroundImage: profileImage != null
                          ? MemoryImage(profileImage!)
                          : AssetImage('assets/pf.jpeg') as ImageProvider,
                    ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
        ],
        title: Text(
          'Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF9EA700),
      ),
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
              color: Color(0xFF9EA700),
              size: 100,
            ))
          : Column(
              children: [
                SizedBox(height: 20),
                buildReportTypeDropdown(),
                SizedBox(
                  height: 10,
                ),
                buildChartSelection(),
                SizedBox(
                  height: 12,
                ),
                Text('$showVariable'),
                SizedBox(height: 15),
                Expanded(child: buildChart()),
              ],
            ),
    );
  }
}
