import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Leadview extends StatefulWidget {
  final int leadId ;
  const Leadview({super.key,required this.leadId});

  @override
  State<Leadview> createState() => _LeadviewState();
}

class _LeadviewState extends State<Leadview> {
  OdooClient? client;
  bool isLoading = true;
  int? currentUserId;
  List<Map<String, dynamic>> leadsList = [];


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
        final auth = await client!.authenticate(
            dbName, userLogin, userPassword);
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
            ['type', '=', widget.leadId]
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lead Details'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              // Convert to Opportunity functionality
            },
            child: const Text('Convert to Opportunity'),
          ),
          const SizedBox(width: 8),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[300],
            ),
            onPressed: () {
              // Lost functionality
            },
            child: const Text('Lost'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title section
            Text(
              'Specifications and price of your phones',
              // Replace with actual lead name
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),

            // Probability section
            Row(
              children: [
                const Text(
                  'Probability',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const Icon(Icons.help_outline, size: 16),
                const SizedBox(width: 16),
                Text(
                  '50.00 %', // Replace with actual probability
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Customer info and contact info sections
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabeledField(context, 'Customer', ''),
                      _buildLabeledField(context, 'Company Name', ''),
                      _buildLabeledField(context, 'Address', 'Edinburgh'),
                      const SizedBox(height: 8),
                      const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text('United Kingdom'),
                      ),
                      _buildLabeledField(context, 'Website', ''),
                      _buildLabeledField(context, 'Salesperson', ''),
                      _buildLabeledField(context, 'Sales Team', 'Pre-Sales'),
                    ],
                  ),
                ),

                // Right column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabeledField(
                          context, 'Contact Name', 'Steve Martinez'),
                      _buildLabeledField(context, 'Email', ''),
                      _buildLabeledField(context, 'Email cc', ''),
                      _buildLabeledField(context, 'Job Position', 'Reseller'),
                      _buildLabeledField(context, 'Phone', ''),
                      _buildLabeledField(context, 'Mobile', ''),

                      // Priority field with stars
                      Row(
                        children: [
                          const Text(
                            'Priority',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const Icon(Icons.help_outline, size: 16),
                          const SizedBox(width: 16),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber),
                              Icon(Icons.star, color: Colors.amber),
                              Icon(Icons.star_border),
                            ],
                          ),
                        ],
                      ),

                      // Tags field
                      Row(
                        children: [
                          const Text(
                            'Tags',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const Icon(Icons.help_outline, size: 16),
                          const SizedBox(width: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red[100],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text('Product'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Tabs section
            const SizedBox(height: 32),
            DefaultTabController(
              length: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: 'Internal Notes'),
                      Tab(text: 'Extra Info'),
                      Tab(text: 'Assigned Partner'),
                    ],
                    isScrollable: true,
                    labelColor: Colors.green,
                    unselectedLabelColor: Colors.black,
                    indicatorColor: Colors.green,
                  ),
                  SizedBox(
                    height: 200,
                    child: TabBarView(
                      children: [
                        Center(child: Text('Internal Notes Content')),
                        Center(child: Text('Extra Info Content')),
                        Center(child: Text('Assigned Partner Content')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabeledField(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const Icon(Icons.help_outline, size: 16),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}