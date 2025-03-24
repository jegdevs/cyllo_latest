import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Views/leadView.dart';

class Leads extends StatefulWidget {
  const Leads({super.key});

  @override
  State<Leads> createState() => _LeadsState();
}

int selectedView = 0;
List<Map<String, dynamic>> leadsList = [];
OdooClient? client;
bool isLoading = true;

class _LeadsState extends State<Leads> {
  int? currentUserId;
  Map<int, Uint8List?> salespersonImages = {};


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
    currentUserId = prefs.getInt("userId");

    if (baseUrl.isNotEmpty &&
        dbName.isNotEmpty &&
        userLogin.isNotEmpty &&
        userPassword.isNotEmpty) {
      client = OdooClient(baseUrl);
      try {
        final auth = await client!.authenticate(dbName, userLogin, userPassword);
        print("Odoo Authenticated: $auth");
        await leadData();
      } catch (e) {
        print("Odoo Authentication Failed: $e");
      }
    }
    setState(() => isLoading = false);
  }

  Future<void> leadData() async {
    try {
      final response = await client?.callKw({
        'model': 'crm.lead',
        'method': 'search_read',
        'args': [
          [
            ['type', '=', 'lead']
          ]
        ],
        'kwargs': {
          'fields': [
            'name',
            'email_from',
            'city',
            'country_id',
            'user_id',
            'partner_assigned_id',
            'team_id',
          ],
        }
      });
      print('leadRes$response');
      if (response != null) {
        leadsList = List<Map<String, dynamic>>.from(response);
      }
    } catch (e) {
      print("error loading data$e");
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

      final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(response);
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
                onPressed: () => setState(() => selectedView = 0),
                icon: Icon(Icons.bar_chart_rounded,
                    color: selectedView == 0 ? Color(0xFF9EA700) : Colors.black),
              ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () => setState(() => selectedView = 1),
                icon: Icon(Icons.view_list_rounded,
                    color: selectedView == 1 ? Color(0xFF9EA700) : Colors.black),
              ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () => setState(() => selectedView = 2),
                icon: Icon(Icons.calendar_month,
                    color: selectedView == 2 ? Color(0xFF9EA700) : Colors.black),
              ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () => setState(() => selectedView = 3),
                icon: Icon(Icons.table_rows_outlined,
                    color: selectedView == 3 ? Color(0xFF9EA700) : Colors.black),
              ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () => setState(() => selectedView = 4),
                icon: Icon(Icons.graphic_eq_rounded,
                    color: selectedView == 4 ? Color(0xFF9EA700) : Colors.black),
              ),
              VerticalDivider(thickness: 2, color: Colors.white),
              IconButton(
                onPressed: () => setState(() => selectedView = 5),
                icon: Icon(Icons.access_time,
                    color: selectedView == 5 ? Color(0xFF9EA700) : Colors.black),
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
        final city = lead['city'] == false ? 'None' : lead['city']?.toString() ?? 'None';
        final assignedPartner = lead['partner_assigned_id'] != null &&
            lead['partner_assigned_id'] is List &&
            lead['partner_assigned_id'].length > 1
            ? lead['partner_assigned_id'][1]
            : 'None';
        final email = lead['email_from'] == false ? 'None' : lead['email_from']?.toString() ?? 'None';
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                    Divider(height: 24, thickness: 1, color: Colors.grey.shade200),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    FutureBuilder<Uint8List?>(
                                      future: salespersonId != null
                                          ? fetchSalespersonImage(salespersonId)
                                          : Future.value(null),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Container(
                                            width: 32,
                                            height: 32,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Color(0xFF9EA700),
                                            ),
                                          );
                                        }
                                        final imageBytes = snapshot.data;
                                        return imageBytes != null
                                            ? Container(
                                          width: 32,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(6),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                blurRadius: 4,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                            image: DecorationImage(
                                              image: MemoryImage(imageBytes),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                            : Container(
                                          width: 32,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(6),
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.blue.shade700,
                                                Colors.blue.shade500
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.blue
                                                    .withOpacity(0.3),
                                                blurRadius: 4,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Icon(Icons.person,
                                              size: 18, color: Colors.white),
                                        );
                                      },
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        salesperson,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
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
                                      horizontal: 10,
                                      vertical: 8
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF9EA700).withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.account_balance_wallet_outlined,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          teamId.toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF9EA700).withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(4),
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
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF9EA700).withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(4),
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
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF9EA700).withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(4),
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

  Widget iconSelectedView() {
    switch (selectedView) {
      case 1:
        return listCard();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9EA700),
        title: Text('Leads'),
      ),
      body: Column(
        children: [
          Divider(thickness: 2, color: Colors.grey.shade300),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Leads',
                  style: TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                      foregroundColor: Color(0xFF9EA700),
                    ),
                    child: Text(
                      'Generate Leads',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )),
              ],
            ),
          ),
          Divider(thickness: 1, color: Colors.grey.shade300),
          ChartSelection(),
          Divider(thickness: 1, color: Colors.grey.shade300),
          SizedBox(height: 7),
          Expanded(child: iconSelectedView()),
        ],
      ),
    );
  }
}