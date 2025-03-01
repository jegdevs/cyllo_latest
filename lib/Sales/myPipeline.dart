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
int selectedView = 0;
List<Map<String, dynamic>> leadsList = [];

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
        await iconSelectedView();
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
            'email_from',
            'recurring_revenue_monthly',
            'contact_name',
          ],
        }
      });
      print('ressss$response');
      if (response != null) {
        leadsList = List<Map<String, dynamic>>.from(response);
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
                imageData:
                    profileImage != null ? base64Encode(profileImage!) : null,
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
                onPressed: () {
                  setState(() {
                    selectedView = 0;
                  });
                },
                icon: Icon(Icons.bar_chart_rounded,
                  color: selectedView == 0 ? Color(0xFF9EA700) : Colors.black,),
              ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedView = 1;
                  });
                },
                icon: Icon(Icons.view_list_rounded,
                  color: selectedView == 1 ? Color(0xFF9EA700) : Colors.black,),
              ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedView = 2;
                  });
                },
                icon: Icon(Icons.calendar_month, color: Colors.black),
              ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedView = 3;
                  });
                },
                icon: Icon(Icons.table_rows_outlined, color: Colors.black),
              ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedView = 4;
                  });
                },
                icon: Icon(Icons.graphic_eq_rounded, color: Colors.black),
              ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedView = 5;
                  });
                },
                icon: Icon(Icons.access_time, color: Colors.black),
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
        final customerName = lead['contact_name'] == false ?'':lead['contact_name']?.toString() ?? '';
        final email = lead['email_from'] ?? '';
        final stageName = lead['stage_id'] != null &&
            lead['stage_id'] is List &&
            lead['stage_id'].length > 1
            ? lead['stage_id'][1]
            : "New";
        final salesperson = lead['user_id'] != null &&
            lead['user_id'] is List &&
            lead['user_id'].length > 1
            ? lead['user_id'][1]
            : "";
        final mrr = lead['recurring_revenue_monthly'] ?? '';
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

        return Card(
          color: Colors.grey.shade200,
          elevation: 2,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.radio_button_unchecked, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: stageColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: stageColor.withOpacity(0.8)),
                      ),
                      child: Text(
                        stageName,
                        style: TextStyle(
                            color: stageColor.withOpacity(1.0) != Colors.white
                                ? Colors.black.withOpacity(0.7)
                                : Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Divider(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Contact',
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 12)),
                          SizedBox(height: 4),
                          Text(customerName,
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          SizedBox(height: 4),
                          email.isNotEmpty
                              ? Text(email,
                              style: TextStyle(color: Colors.blue))
                              : SizedBox(),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Salesperson',
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 12)),
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // profileImage != null
                              //     ? CircleAvatar(
                              //   backgroundImage:
                              //   MemoryImage(profileImage!),
                              //   radius: 12,
                              // ):
                              profileImage != null?
                              Container(
                                width: 24,
                                height: 24,
                                margin: EdgeInsets.only(left: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  image: DecorationImage(
                                    image: MemoryImage(
                                      profileImage!),
                                    fit: BoxFit.cover,
                                  ),
                                  ),
                                ):
                              CircleAvatar(
                                backgroundColor: Colors.blue,
                                radius: 12,
                                child: Icon(Icons.person,
                                    size: 16, color: Colors.white),
                              ),
                              SizedBox(width: 8),
                              Text(salesperson),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Expected Revenue',
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 12)),
                          SizedBox(height: 4),
                          Text('\$${revenue}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF9EA700))),
                          Text('Expected MRR',
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 12)),
                          SizedBox(height: 4),
                          Text('\$${mrr}',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF9EA700))),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.email_outlined, color: Colors.green),
                      onPressed: () {},
                      constraints: BoxConstraints(),
                      padding: EdgeInsets.all(8),
                    ),
                    IconButton(
                      icon: Icon(Icons.message_outlined, color: Colors.green),
                      onPressed: () {},
                      constraints: BoxConstraints(),
                      padding: EdgeInsets.all(8),
                    ),
                  ],
                ),
              ],
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
                    color: Colors.white, borderRadius: BorderRadius.circular(10)),
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
        return Container();

      case 3:
        return Container();

      case 4:
        return Container();

      case 5:
        return Container();

      default:
        return Container();
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
                          index < item.priority ? Icons.star : Icons.star_border,
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
    // final config = AppFlowyBoardConfig(
    //   groupBackgroundColor: Colors.grey.shade100,
    //   stretchGroupHeight: false,
    // );
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
          Expanded(child: iconSelectedView()),
        ],
      ),
    );
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
