import 'package:flutter/material.dart';
import 'package:appflowy_board/appflowy_board.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mypipeline extends StatefulWidget {
  const Mypipeline({super.key});

  @override
  State<Mypipeline> createState() => _MypipelineState();
}

OdooClient? client;
bool isLoading = true;
final AppFlowyBoardController controller = AppFlowyBoardController();
late AppFlowyBoardScrollController boardController;

class _MypipelineState extends State<Mypipeline> {
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
        await pipe();
      } catch (e) {
        print("Odoo Authentication Failed: $e");
      }
    }
    setState(() => isLoading = false);
  }

  Future<void> pipe() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getInt("userId") ?? "";
    print('iddddd$userid');
    try {
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
            // 'image_1920',
          ],
        }
      });
      if (response != null) {
        Map<String, List<Map<String, dynamic>>> groupedLeads = {};

        for (var lead in response) {
          String stage = lead['stage_id'][1] ?? '';
          groupedLeads.putIfAbsent(stage, () => []).add(lead);
        }

        controller.clear();

        for (var entry in groupedLeads.entries) {
          final groupData = AppFlowyGroupData(
            id: entry.key,
            name: entry.key,
            items: entry.value
                .map((lead) => LeadItem(
                      name: lead['name'],
                      revenue: lead['expected_revenue'].toString(),
                      customerName: lead['partner_id']!= null && lead['partner_id'] is List && lead['partner_id'].length > 1
                          ? lead['partner_id'][1]
                          : "",
                    ))
                .toList(),
          );

          controller.addGroup(groupData);
        }

        setState(() {});
      }
    } catch (e) {
      print("Odoo Fetch Failed: $e");
    }
  }

  Widget buildChartSelection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: double.infinity, // Make it responsive
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.grey.shade200,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Allow scrolling if needed
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.bar_chart_rounded, color: Color(0xFF9EA700)),
              ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.view_list_rounded, color: Color(0xFF9EA700)),
              ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.calendar_month, color: Color(0xFF9EA700)),
              ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.table_rows_outlined, color: Color(0xFF9EA700)),
              ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.graphic_eq_rounded, color: Color(0xFF9EA700)),
              ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.access_time, color: Color(0xFF9EA700)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  late AppFlowyBoardScrollController boardController;

  @override
  void initState() {
    super.initState();
    super.initState();
    initializeOdooClient();
    boardController = AppFlowyBoardScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final config = AppFlowyBoardConfig(
      groupBackgroundColor: Colors.grey.shade100,
      stretchGroupHeight: false,
    );
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
          buildChartSelection(),
          Divider(
            thickness: 1, color: Colors.grey.shade300
          ),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: AppFlowyBoard(
                controller: controller,
                cardBuilder: (context, group, groupItem) {
                  return AppFlowyGroupCard(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    key: ValueKey(groupItem.id),
                    child: _buildCard(groupItem),
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
                              .getGroupController(
                                  columnData.headerData.groupId)!
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
                config: config),
          ),
        ],
      ),
    );
  }
}

Widget _buildCard(AppFlowyGroupItem item) {
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
              ],
            ),
          ),
        ),
      ],
    );
  }
  throw UnimplementedError();
}

class LeadItem extends AppFlowyGroupItem {
  final String name;
  final String revenue;
  final String customerName;

  LeadItem({required this.name, required this.revenue,required this.customerName});

  @override
  String get id => name;
}
