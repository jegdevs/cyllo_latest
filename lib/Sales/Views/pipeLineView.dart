import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';
class LeadDetailPage extends StatefulWidget {
  final dynamic leadId;

  const LeadDetailPage({Key? key, required this.leadId}) : super(key: key);

  @override
  _LeadDetailPageState createState() => _LeadDetailPageState();
}

class _LeadDetailPageState extends State<LeadDetailPage> with SingleTickerProviderStateMixin {
  bool isLoading = true;
  Map<String, dynamic> leadData = {};
  late TabController _tabController;
  OdooClient? client;
  Uint8List? profileImage;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    initializeOdooClient();
  }

  @override
  void dispose() {
    _tabController.dispose();
    client?.close();
    super.dispose();
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
        await fetchLeadDetails();
        await userImage(); // Fetch user image after lead details
      } catch (e) {
        print("Odoo Authentication Failed: $e");
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to connect to Odoo: $e")),
          );
        }
      }
    }
    if (mounted) {
      setState(() => isLoading = false);
    }
  }

  Future<void> userImage() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getInt("userId") ?? 0; // Changed "" to 0 as it's an int
    if (userid == 0) return;

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
      print('User image response: $response');
      if (response == null || response.isEmpty || response is! List) {
        print('No data received or invalid format');
        return;
      }
      final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(response);
      setState(() {
        var imageData = data[0]['image_1920'];
        if (imageData != null && imageData is String) {
          profileImage = base64Decode(imageData);
          print('Profile image decoded, length: ${profileImage?.length}');
        }
      });
    } catch (e) {
      print("Error fetching user image: $e");
    }
  }

  Future<void> fetchLeadDetails() async {
    if (client == null) {
      throw Exception('Odoo client not initialized');
    }

    try {
      final response = await client!.callKw({
        'model': 'crm.lead',
        'method': 'read',
        'args': [
          [widget.leadId],
        ],
        'kwargs': {
          'fields': [
            'name',
            'expected_revenue',
            'probability',
            'contact_name',
            'user_id',
            'email_from',
            'phone',
            'description',
            'recurring_revenue_monthly',
            'date_deadline',
            'tag_ids',
            'priority',
            'partner_id'
          ],
        },
      });

      if (response.isNotEmpty) {
        setState(() {
          leadData = response[0];
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() => isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching lead details: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9EA700),
        title: Text('Lead Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Color(0xFF9EA700)))
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatusButtons(),
              _buildLeadTitle(),
              _buildFinancialDetails(),
              _buildContactInfo(),
              _buildTabs(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusButtons() {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildStatusButton('New Quotation', Color(0xFF9EA700), true),
            SizedBox(width: 8),
            _buildStatusButton('Won', Colors.green, false),
            SizedBox(width: 8),
            _buildStatusButton('Lost', Colors.red.shade300, false),
            SizedBox(width: 24),
            Row(
              children: [
                Text('New', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF9EA700))),
                Text(' 2M '),
                Icon(Icons.chevron_right, size: 16),
                Text(' Qualified'),
                Text(' 1m '),
                Icon(Icons.chevron_right, size: 16),
                Text(' Proposition '),
                Icon(Icons.chevron_right, size: 16),
                Text(' Won '),
                Icon(Icons.chevron_right, size: 16),
                Text(' double won'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusButton(String text, Color color, bool isActive) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? color : Colors.grey.shade200,
        foregroundColor: isActive ? Colors.white : Colors.black87,
        elevation: isActive ? 2 : 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Text(text),
    );
  }

  Widget _buildLeadTitle() {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      child: Text(
        leadData['name']?.toString() ?? 'Lead Title',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey.shade800),
      ),
    );
  }

  Widget _buildFinancialDetails() {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildInfoField(
                  'Expected Revenue',
                  leadData['expected_revenue']?.toString() ?? '0.0',
                  Icons.help_outline,
                ),
              ),
              Expanded(
                child: _buildInfoField(
                  'Probability',
                  '${leadData['probability']?.toString() ?? '0.0'} %',
                  Icons.help_outline,
                  hasInfoIcon: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                '\$ ${leadData['expected_revenue']?.toString() ?? '0.00'}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(' + '),
              Text('\$ ${leadData['recurring_revenue_monthly']?.toString() ?? '0.00'}'),
              Text('  at  '),
              Text(
                '${leadData['probability']?.toString() ?? '0.00'} %',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildInfoField(
                  'Customer',
                  leadData['partner_id'] != null &&
                      leadData['partner_id'] is List &&
                      leadData['partner_id'].length > 1
                      ? leadData['partner_id'][1]
                      : "None",
                  Icons.help_outline,
                ),
              ),
              Expanded(
                child: _buildInfoField(
                  'Salesperson',
                  (leadData['user_id'] is List && leadData['user_id'].length > 1)
                      ? leadData['user_id'][1].toString()
                      : 'N/A',
                  Icons.help_outline,
                  hasAvatar: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildInfoField(
                  'Email',
                  leadData['email_from']?.toString() ?? 'N/A',
                  Icons.help_outline,
                ),
              ),
              Expanded(
                child: _buildInfoField(
                  'Expected Closing',
                  leadData['date_deadline']?.toString() ?? 'N/A',
                  Icons.help_outline,
                  hasStarRating: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildInfoField(
                  'Phone',
                  leadData['phone']?.toString() ?? 'N/A',
                  Icons.help_outline,
                ),
              ),
              Expanded(
                child: _buildInfoField(
                  'Tags',
                  leadData['tag_ids']?.isNotEmpty == true ? '' : 'N/A',
                  Icons.help_outline,
                  hasTags: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoField(String label, String value, IconData icon, {
    bool hasInfoIcon = false,
    bool hasAvatar = false,
    bool hasStarRating = false,
    bool hasTags = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(label, style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
              SizedBox(width: 4),
              Icon(icon, size: 12, color: Colors.grey),
            ],
          ),
          SizedBox(height: 8),
          if (hasStarRating)
            Row(
              children: _buildStarRating(leadData['priority']),
            )
          else if (hasAvatar)
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: profileImage == null ? Colors.blue : null,
                    image: profileImage != null
                        ? DecorationImage(
                      image: MemoryImage(profileImage!),
                      fit: BoxFit.cover,
                    )
                        : null,
                  ),
                  child: profileImage == null
                      ? Center(
                    child: Text(
                      value.isNotEmpty ? value[0] : '?',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  )
                      : null,
                ),
                SizedBox(width: 8),
                Text(value, style: TextStyle(fontWeight: FontWeight.w500)),
              ],
            )
          else if (hasTags && leadData['tag_ids']?.isNotEmpty == true)
              Wrap(
                spacing: 8,
                children: (leadData['tag_ids'] as List).map((tag) =>
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: FutureBuilder(
                        future: _getTagName(tag),
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.data?.toString() ?? 'Loading...',
                            style: TextStyle(color: Colors.red.shade800, fontSize: 12, fontWeight: FontWeight.w500),
                          );
                        },
                      ),
                    )
                ).toList(),
              )
            else
              Text(value, style: TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Future<String> _getTagName(int tagId) async {
    if (client == null) return 'N/A';
    try {
      final response = await client!.callKw({
        'model': 'crm.tag',
        'method': 'read',
        'args': [[tagId]],
        'kwargs': {'fields': ['name']},
      });
      return response.isNotEmpty ? response[0]['name'] : 'N/A';
    } catch (e) {
      return 'N/A';
    }
  }

  List<Widget> _buildStarRating(dynamic priority) {
    int stars = int.tryParse(priority?.toString() ?? '0') ?? 0;
    List<Widget> starWidgets = [];
    for (int i = 0; i < 3; i++) {
      starWidgets.add(
        Icon(
          i < stars ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 20,
        ),
      );
    }
    return starWidgets;
  }

  Widget _buildTabs() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
          child: TabBar(
            controller: _tabController,
            labelColor: Color(0xFF9EA700),
            unselectedLabelColor: Colors.grey.shade600,
            indicatorColor: Color(0xFF9EA700),
            tabs: [
              Tab(text: 'Internal Notes'),
              Tab(text: 'Extra Information'),
              Tab(text: 'Assigned Partner'),
            ],
          ),
        ),
        Container(
          height: 200,
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildNotesTab(),
              _buildExtraInfoTab(),
              _buildPartnerTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotesTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Internal Notes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 8),
          Text(leadData['description']?.toString() ?? 'No notes available'),
        ],
      ),
    );
  }

  Widget _buildExtraInfoTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Extra Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 8),
          Text('No extra information available'),
        ],
      ),
    );
  }

  Widget _buildPartnerTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Assigned Partner', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 8),
          Text('No partner assigned'),
        ],
      ),
    );
  }
}