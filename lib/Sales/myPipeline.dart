import 'dart:convert';
import 'dart:typed_data';
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

  Uint8List? profileImage;
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
          'fields': ['id', 'name','color'],
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
          ],
        }
      });
      print('ressss$response');
      if (response != null) {
        Map<String, List<Map<String, dynamic>>> groupedLeads = {};

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
                imageData: profileImage != null ? base64Encode(profileImage!) : null,

              );
            }).toList(),
          );

          controller.addGroup(groupData);
        }

        setState(() {});
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
                onPressed: () {},
                icon: Icon(Icons.bar_chart_rounded, color: Color(0xFF9EA700)),
              ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.view_list_rounded, color: Colors.black),
              ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.calendar_month, color: Colors.black),
              ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.table_rows_outlined, color: Colors.black),
              ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.graphic_eq_rounded, color: Colors.black),
              ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.access_time, color: Colors.black),
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
          ChartSelection(),
          Divider(thickness: 1, color: Colors.grey.shade300),
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
                    child: Card(groupItem),
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

Widget Card(AppFlowyGroupItem item) {
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
                        index < item.priority ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ActivityIconDesign(item.activityState, item.activityType),
                    SizedBox(width: 58,),
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

class LeadItem extends AppFlowyGroupItem {
  final String name;
  final String revenue;
  final String customerName;
  final List<String> tags;
  final int priority;
  final String activityState;
  final String activityType;
  final String? imageData;

  LeadItem({
    required this.name,
    required this.revenue,
    required this.customerName,
    required this.tags,
    required this.priority,
    this.activityState = '',
    this.activityType = '',
    this.imageData,
  });

  @override
  String get id => name;
}
