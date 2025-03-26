import 'dart:convert';
import 'dart:developer';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cyllo_mobile/Sales/Views/quotationsView.dart';
import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';
import 'package:intl/intl.dart';

class LeadDetailPage extends StatefulWidget {
  final dynamic leadId;

  const LeadDetailPage({Key? key, required this.leadId}) : super(key: key);

  @override
  _LeadDetailPageState createState() => _LeadDetailPageState();
}

class _LeadDetailPageState extends State<LeadDetailPage> with SingleTickerProviderStateMixin {
  bool isLoading = true;
  bool isEditing = false;
  Map<String, dynamic> leadData = {};
  late TabController _tabController;
  OdooClient? client;
  Uint8List? profileImage;
  List<Map<String, dynamic>> tagsList = [];
  List<Map<String, dynamic>> salesPersons = [];
  List<Map<String, dynamic>> partners = [];
  List<Map<String, dynamic>> countries = [];
  List<Map<String, dynamic>> states = [];
  List<Map<String, dynamic>> campaigns = [];
  List<Map<String, dynamic>> mediums = [];
  List<Map<String, dynamic>> sources = [];
  List<Map<String, dynamic>> companies = [];
  List<Map<String, dynamic>> salesTeams = [];

  late TextEditingController nameController;
  late TextEditingController expectedRevenueController;
  late TextEditingController probabilityController;
  late TextEditingController recurringRevenueController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController descriptionController;
  late TextEditingController dateDeadlineController;
  late TextEditingController contactNameController;
  late TextEditingController companyNameController;
  late TextEditingController addressController;
  late TextEditingController streetController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController zipController;
  late TextEditingController countryController;
  late TextEditingController websiteController;
  late TextEditingController campaignController;
  late TextEditingController mediumController;
  late TextEditingController sourceController;
  late TextEditingController referredByController;
  late TextEditingController trackingCompanyController;
  late TextEditingController salesTeamController;
  late TextEditingController daysToAssignController;
  late TextEditingController daysToCloseController;

  String? selectedSalesperson;
  String? selectedPartner;
  List<dynamic> selectedTags = [];
  int priority = 0;
  String? selectedState;
  String? selectedCountry;
  String? selectedCampaign;
  String? selectedMedium;
  String? selectedSource;
  String? selectedCompany;
  String? selectedSalesTeam;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    nameController = TextEditingController();
    expectedRevenueController = TextEditingController();
    probabilityController = TextEditingController();
    recurringRevenueController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    descriptionController = TextEditingController();
    dateDeadlineController = TextEditingController();
    contactNameController = TextEditingController();
    companyNameController = TextEditingController();
    addressController = TextEditingController();
    streetController = TextEditingController();
    cityController = TextEditingController();
    stateController = TextEditingController();
    zipController = TextEditingController();
    countryController = TextEditingController();
    websiteController = TextEditingController();
    campaignController = TextEditingController();
    mediumController = TextEditingController();
    sourceController = TextEditingController();
    referredByController = TextEditingController();
    trackingCompanyController = TextEditingController();
    salesTeamController = TextEditingController();
    daysToAssignController = TextEditingController();
    daysToCloseController = TextEditingController();

    initializeOdooClient();
  }

  @override
  void dispose() {
    _tabController.dispose();
    client?.close();

    nameController.dispose();
    expectedRevenueController.dispose();
    probabilityController.dispose();
    recurringRevenueController.dispose();
    emailController.dispose();
    phoneController.dispose();
    descriptionController.dispose();
    dateDeadlineController.dispose();
    contactNameController.dispose();
    companyNameController.dispose();
    addressController.dispose();
    streetController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipController.dispose();
    countryController.dispose();
    websiteController.dispose();
    campaignController.dispose();
    mediumController.dispose();
    sourceController.dispose();
    referredByController.dispose();
    trackingCompanyController.dispose();
    salesTeamController.dispose();
    daysToAssignController.dispose();
    daysToCloseController.dispose();

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
        await userImage();
        await fetchTags();
        await fetchSalesPersons();
        await fetchPartners();
        await fetchCountries();
        await fetchStates();
        await fetchCampaigns();
        await fetchMediums();
        await fetchSources();
        await fetchCompanies();
        await fetchSalesTeams();
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

  Future<void> fetchTags() async {
    if (client == null) return;
    try {
      final response = await client!.callKw({
        'model': 'crm.tag',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {'fields': ['id', 'name', 'color']},
      });
      if (response is List) {
        setState(() {
          tagsList = List<Map<String, dynamic>>.from(response);
        });
      }
    } catch (e) {
      print("Error fetching tags: $e");
    }
  }

  Future<void> fetchSalesPersons() async {
    if (client == null) return;
    try {
      final response = await client!.callKw({
        'model': 'res.users',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {'fields': ['id', 'name']},
      });
      if (response is List) {
        setState(() {
          salesPersons = List<Map<String, dynamic>>.from(response);
        });
      }
    } catch (e) {
      print("Error fetching salespersons: $e");
    }
  }

  Future<void> fetchPartners() async {
    if (client == null) return;
    try {
      final response = await client!.callKw({
        'model': 'res.partner',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {'fields': ['id', 'name']},
      });
      if (response is List) {
        setState(() {
          partners = List<Map<String, dynamic>>.from(response);
        });
      }
    } catch (e) {
      print("Error fetching partners: $e");
    }
  }

  Future<void> fetchCountries() async {
    try {
      final response = await client!.callKw({
        'model': 'res.country',
        'method': 'search_read',
        'args': [],
        'kwargs': {'fields': ['name', 'id']},
      });
      if (response is List) {
        setState(() {
          countries = List<Map<String, dynamic>>.from(response);
        });
      }
    } catch (e) {
      print("Error fetching countries: $e");
    }
  }

  Future<void> fetchStates() async {
    try {
      final response = await client!.callKw({
        'model': 'res.country.state',
        'method': 'search_read',
        'args': [],
        'kwargs': {'fields': ['name', 'id']},
      });
      if (response is List) {
        setState(() {
          states = List<Map<String, dynamic>>.from(response);
        });
      }
    } catch (e) {
      print("Error fetching states: $e");
    }
  }

  Future<void> fetchCampaigns() async {
    try {
      final response = await client!.callKw({
        'model': 'utm.campaign',
        'method': 'search_read',
        'args': [],
        'kwargs': {'fields': ['name', 'id']},
      });
      if (response is List) {
        setState(() {
          campaigns = List<Map<String, dynamic>>.from(response);
        });
      }
    } catch (e) {
      print("Error fetching campaigns: $e");
    }
  }

  Future<void> fetchMediums() async {
    try {
      final response = await client!.callKw({
        'model': 'utm.medium',
        'method': 'search_read',
        'args': [],
        'kwargs': {'fields': ['name', 'id']},
      });
      if (response is List) {
        setState(() {
          mediums = List<Map<String, dynamic>>.from(response);
        });
      }
    } catch (e) {
      print("Error fetching mediums: $e");
    }
  }

  Future<void> fetchSources() async {
    try {
      final response = await client!.callKw({
        'model': 'utm.source',
        'method': 'search_read',
        'args': [],
        'kwargs': {'fields': ['name', 'id']},
      });
      if (response is List) {
        setState(() {
          sources = List<Map<String, dynamic>>.from(response);
        });
      }
    } catch (e) {
      print("Error fetching sources: $e");
    }
  }

  Future<void> fetchCompanies() async {
    try {
      final response = await client!.callKw({
        'model': 'res.company',
        'method': 'search_read',
        'args': [],
        'kwargs': {'fields': ['name', 'id']},
      });
      if (response is List) {
        setState(() {
          companies = List<Map<String, dynamic>>.from(response);
        });
      }
    } catch (e) {
      print("Error fetching companies: $e");
    }
  }

  Future<void> fetchSalesTeams() async {
    try {
      final response = await client!.callKw({
        'model': 'crm.team',
        'method': 'search_read',
        'args': [],
        'kwargs': {'fields': ['name', 'id']},
      });
      if (response is List) {
        setState(() {
          salesTeams = List<Map<String, dynamic>>.from(response);
        });
      }
    } catch (e) {
      print("Error fetching sales teams: $e");
    }
  }

  Future<void> userImage() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getInt("userId") ?? 0;
    if (userid == 0) return;
    try {
      final response = await client?.callKw({
        'model': 'res.users',
        'method': 'search_read',
        'args': [[["id", "=", userid]]],
        'kwargs': {'fields': ['image_1920', 'name']},
      });
      if (response != null && response.isNotEmpty && response is List) {
        setState(() {
          var imageData = response[0]['image_1920'];
          if (imageData != null && imageData is String) {
            profileImage = base64Decode(imageData);
          }
        });
      }
    } catch (e) {
      print("Error fetching user image: $e");
    }
  }

  Future<void> fetchLeadDetails() async {
    if (client == null) return;
    try {
      final response = await client!.callKw({
        'model': 'crm.lead',
        'method': 'read',
        'args': [[widget.leadId]],
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
            'partner_id',
            'partner_name',
            'street',
            'city',
            'state_id',
            'zip',
            'country_id',
            'website',
            'campaign_id',
            'medium_id',
            'source_id',
            'referred',
            'company_id',
            'team_id',
            'day_open',
            'day_close',
          ],
        },
      });

      print('Lead Details Response for leadId ${widget.leadId}: $response');

      if (response is List && response.isNotEmpty && mounted) {
        setState(() {
          leadData = response[0];

          nameController.text = leadData['name'] is String ? leadData['name'] : '';
          expectedRevenueController.text = leadData['expected_revenue'] != null ? leadData['expected_revenue'].toString() : '0.0';
          probabilityController.text = leadData['probability'] != null ? leadData['probability'].toString() : '0.0';
          recurringRevenueController.text = leadData['recurring_revenue_monthly'] != null ? leadData['recurring_revenue_monthly'].toString() : '0.0';
          emailController.text = leadData['email_from'] is String ? leadData['email_from'] : '';
          phoneController.text = leadData['phone'] is String ? leadData['phone'] : '';
          descriptionController.text = leadData['description'] is String ? leadData['description'] : '';
          dateDeadlineController.text = leadData['date_deadline'] is String ? leadData['date_deadline'] : '';
          priority = int.tryParse(leadData['priority']?.toString() ?? '0') ?? 0;
          selectedTags = leadData['tag_ids'] is List ? List.from(leadData['tag_ids']) : [];
          selectedSalesperson = leadData['user_id'] is List && leadData['user_id'].length > 1 ? leadData['user_id'][1].toString() : null;
          selectedPartner = leadData['partner_id'] is List && leadData['partner_id'].length > 1 ? leadData['partner_id'][1].toString() : null;

          contactNameController.text = leadData['contact_name'] is String ? leadData['contact_name'] : 'No data';
          companyNameController.text = leadData['partner_name'] is String ? leadData['partner_name'] : 'No data';

          String street = leadData['street'] is String ? leadData['street'] : '';
          String city = leadData['city'] is String ? leadData['city'] : '';
          String state = leadData['state_id'] is List && leadData['state_id'].length > 1 ? leadData['state_id'][1].toString() : '';
          String zip = leadData['zip'] is String ? leadData['zip'] : '';
          String country = leadData['country_id'] is List && leadData['country_id'].length > 1 ? leadData['country_id'][1].toString() : '';
          addressController.text = [street, city, state, zip, country].where((e) => e.isNotEmpty).join(', ');

          streetController.text = street;
          cityController.text = city;
          stateController.text = state;
          zipController.text = zip;
          countryController.text = country;
          selectedState = state.isNotEmpty ? state : null;
          selectedCountry = country.isNotEmpty ? country : null;

          websiteController.text = leadData['website'] is String ? leadData['website'] : 'No data';

          selectedCampaign = leadData['campaign_id'] is List && leadData['campaign_id'].length > 1 ? leadData['campaign_id'][1].toString() : null;
          selectedMedium = leadData['medium_id'] is List && leadData['medium_id'].length > 1 ? leadData['medium_id'][1].toString() : null;
          selectedSource = leadData['source_id'] is List && leadData['source_id'].length > 1 ? leadData['source_id'][1].toString() : null;
          campaignController.text = selectedCampaign ?? 'No data';
          mediumController.text = selectedMedium ?? 'No data';
          sourceController.text = selectedSource ?? 'No data';
          referredByController.text = leadData['referred'] is String ? leadData['referred'] : 'No data';

          selectedCompany = leadData['company_id'] is List && leadData['company_id'].length > 1 ? leadData['company_id'][1].toString() : null;
          selectedSalesTeam = leadData['team_id'] is List && leadData['team_id'].length > 1 ? leadData['team_id'][1].toString() : null;
          trackingCompanyController.text = selectedCompany ?? 'No data';
          salesTeamController.text = selectedSalesTeam ?? 'No data';
          daysToAssignController.text = leadData['day_open'] != null ? leadData['day_open'].toString() : 'No data';
          daysToCloseController.text = leadData['day_close'] != null ? leadData['day_close'].toString() : 'No data';

          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          leadData = {};
          nameController.text = 'No data';
          contactNameController.text = 'No data';
          companyNameController.text = 'No data';
          addressController.text = 'No data';
          streetController.text = '';
          cityController.text = '';
          stateController.text = '';
          zipController.text = '';
          countryController.text = '';
          websiteController.text = 'No data';
          campaignController.text = 'No data';
          mediumController.text = 'No data';
          sourceController.text = 'No data';
          referredByController.text = 'No data';
          trackingCompanyController.text = 'No data';
          salesTeamController.text = 'No data';
          daysToAssignController.text = 'No data';
          daysToCloseController.text = 'No data';
        });
        print('No data returned or invalid response format for leadId ${widget.leadId}');
      }
    } catch (e) {
      print("Error fetching lead details for leadId ${widget.leadId}: $e");
      if (mounted) {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching lead details: $e')),
        );
      }
    }
  }

  Future<void> saveLeadChanges() async {
    if (client == null) return;

    setState(() => isLoading = true);
    try {
      final salespersonId = selectedSalesperson != null
          ? salesPersons.firstWhere((data) => data['name'] == selectedSalesperson, orElse: () => {'id': false})['id']
          : false;

      final partnerId = selectedPartner != null
          ? partners.firstWhere((data) => data['name'] == selectedPartner, orElse: () => {'id': false})['id']
          : false;

      final stateId = selectedState != null && states.any((s) => s['name'] == selectedState)
          ? states.firstWhere((s) => s['name'] == selectedState)['id']
          : false;

      final countryId = selectedCountry != null && countries.any((c) => c['name'] == selectedCountry)
          ? countries.firstWhere((c) => c['name'] == selectedCountry)['id']
          : false;

      final campaignId = selectedCampaign != null && campaigns.any((c) => c['name'] == selectedCampaign)
          ? campaigns.firstWhere((c) => c['name'] == selectedCampaign)['id']
          : false;

      final mediumId = selectedMedium != null && mediums.any((m) => m['name'] == selectedMedium)
          ? mediums.firstWhere((m) => m['name'] == selectedMedium)['id']
          : false;

      final sourceId = selectedSource != null && sources.any((s) => s['name'] == selectedSource)
          ? sources.firstWhere((s) => s['name'] == selectedSource)['id']
          : false;

      final companyId = selectedCompany != null && companies.any((c) => c['name'] == selectedCompany)
          ? companies.firstWhere((c) => c['name'] == selectedCompany)['id']
          : false;

      final teamId = selectedSalesTeam != null && salesTeams.any((t) => t['name'] == selectedSalesTeam)
          ? salesTeams.firstWhere((t) => t['name'] == selectedSalesTeam)['id']
          : false;

      final updatedData = {
        'name': nameController.text,
        'expected_revenue': double.tryParse(expectedRevenueController.text) ?? 0.0,
        'probability': double.tryParse(probabilityController.text) ?? 0.0,
        'recurring_revenue_monthly': double.tryParse(recurringRevenueController.text) ?? 0.0,
        'email_from': emailController.text,
        'phone': phoneController.text,
        'description': descriptionController.text,
        'date_deadline': dateDeadlineController.text,
        'priority': priority.toString(),
        'tag_ids': selectedTags,
        'user_id': salespersonId != false ? salespersonId : null,
        'partner_id': partnerId != false ? partnerId : null,
        'contact_name': contactNameController.text,
        'partner_name': companyNameController.text,
        'street': streetController.text,
        'city': cityController.text,
        'state_id': stateId != false ? stateId : null,
        'zip': zipController.text,
        'country_id': countryId != false ? countryId : null,
        'website': websiteController.text,
        'campaign_id': campaignId != false ? campaignId : null,
        'medium_id': mediumId != false ? mediumId : null,
        'source_id': sourceId != false ? sourceId : null,
        'referred': referredByController.text,
        'company_id': companyId != false ? companyId : null,
        'team_id': teamId != false ? teamId : null,
        'day_open': double.tryParse(daysToAssignController.text) ?? 0.0,
        'day_close': double.tryParse(daysToCloseController.text) ?? 0.0,
      };

      final response = await client!.callKw({
        'model': 'crm.lead',
        'method': 'write',
        'args': [[widget.leadId], updatedData],
        'kwargs': {},
      });

      if (response == true) {
        await fetchLeadDetails();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Lead updated successfully')),
          );
          setState(() => isEditing = false);
        }
      } else {
        throw Exception("Failed to update lead: Invalid response from server");
      }
    } catch (e) {
      print('Error updating lead: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating lead: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
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
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              if (isEditing) {
                saveLeadChanges();
              } else {
                setState(() => isEditing = true);
              }
            },
          ),
          if (isEditing)
            IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                setState(() {
                  isEditing = false;
                  fetchLeadDetails();
                });
              },
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

  Widget _buildLeadTitle() {
    return Container(
      margin: EdgeInsets.only(top: 24),
      child: isEditing
          ? TextField(
        controller: nameController,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          labelText: 'Lead Title',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.title, color: Color(0xFF9EA700)),
        ),
      )
          : Text(
        leadData['name']?.toString() ?? 'Lead Title',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildFinancialDetails() {
    return Container(
      margin: EdgeInsets.only(top: 24),
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
                  textController: expectedRevenueController,
                ),
              ),
              Expanded(
                child: _buildInfoField(
                  'Probability',
                  '${leadData['probability']?.toString() ?? '0.0'} %',
                  textController: probabilityController,
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
      margin: EdgeInsets.only(top: 24),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: isEditing
                    ? _buildPartnerDropdown()
                    : _buildInfoField(
                  'Customer',
                  leadData['partner_id'] is List && leadData['partner_id'].length > 1 ? leadData['partner_id'][1].toString() : 'None',
                ),
              ),
              Expanded(
                child: isEditing
                    ? _buildSalespersonDropdown()
                    : _buildInfoField(
                  'Salesperson',
                  leadData['user_id'] is List && leadData['user_id'].length > 1 ? leadData['user_id'][1].toString() : 'N/A',
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
                  textController: emailController,
                ),
              ),
              Expanded(
                child: _buildInfoField(
                  'Expected Closing',
                  leadData['date_deadline'] is String ? leadData['date_deadline'] : 'N/A',
                  textController: dateDeadlineController,
                  isDateField: true,
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
                  textController: phoneController,
                ),
              ),
              Expanded(
                child: isEditing
                    ? _buildTagsSelector()
                    : _buildInfoField(
                  'Tags',
                  leadData['tag_ids']?.isNotEmpty == true ? '' : 'N/A',
                  hasTags: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          _buildInfoField(
            'Priority',
            '',
            hasStarRating: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPartnerDropdown() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Customer', style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
              SizedBox(width: 4),
              Icon(Icons.help_outline, size: 12, color: Colors.grey),
            ],
          ),
          SizedBox(height: 8),
          CustomDropdown<String>(
            decoration: CustomDropdownDecoration(
              closedFillColor: Color(0x1B9EA700),
              closedBorderRadius: BorderRadius.circular(12),
            ),
            hintText: 'Select Customer',
            items: partners.map<String>((data) => data['name'].toString()).toList(),
            initialItem: selectedPartner,
            onChanged: (value) {
              setState(() => selectedPartner = value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSalespersonDropdown() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Salesperson', style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
              SizedBox(width: 4),
              Icon(Icons.help_outline, size: 12, color: Colors.grey),
            ],
          ),
          SizedBox(height: 8),
          CustomDropdown<String>(
            decoration: CustomDropdownDecoration(
              closedFillColor: Color(0x1B9EA700),
              closedBorderRadius: BorderRadius.circular(12),
            ),
            hintText: 'Select Salesperson',
            items: salesPersons.map<String>((data) => data['name'].toString()).toList(),
            initialItem: selectedSalesperson,
            onChanged: (value) {
              setState(() => selectedSalesperson = value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoField(String label, String value,
      {bool hasAvatar = false,
        bool hasStarRating = false,
        bool hasTags = false,
        TextEditingController? textController,
        bool isDateField = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(label, style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
              SizedBox(width: 4),
              Icon(Icons.help_outline, size: 12, color: Colors.grey),
            ],
          ),
          SizedBox(height: 8),
          if (isEditing && textController != null)
            isDateField
                ? TextField(
              controller: textController,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today, color: Color(0xFF9EA700)),
                filled: true,
                fillColor: Color(0x1B9EA700),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  textController.text = formattedDate;
                }
              },
            )
                : TextField(
              controller: textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  label.contains('Revenue')
                      ? Icons.attach_money
                      : label.contains('Probability')
                      ? Icons.percent
                      : label.contains('Email')
                      ? Icons.email
                      : label.contains('Phone')
                      ? Icons.phone
                      : label.contains('Website')
                      ? Icons.link
                      : label.contains('Days')
                      ? Icons.timer
                      : label.contains('Address')
                      ? Icons.location_city
                      : Icons.info,
                  color: Color(0xFF9EA700),
                ),
                filled: true,
                fillColor: Color(0x1B9EA700),
              ),
              keyboardType: label.contains('Revenue') || label.contains('Probability') || label.contains('Days')
                  ? TextInputType.numberWithOptions(decimal: true)
                  : label.contains('Phone')
                  ? TextInputType.phone
                  : label.contains('Website')
                  ? TextInputType.url
                  : TextInputType.text,
            )
          else if (hasStarRating)
            Row(
              children: List.generate(
                3,
                    (index) => GestureDetector(
                  onTap: isEditing ? () => setState(() => priority = index + 1) : null,
                  child: Icon(
                    index < priority ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 20,
                  ),
                ),
              ),
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
                      image: profileImage != null ? DecorationImage(image: MemoryImage(profileImage!), fit: BoxFit.cover) : null,
                    ),
                    child: profileImage == null
                        ? Center(
                      child: Text(
                        value.isNotEmpty ? value[0] : '?',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
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
                  children: (leadData['tag_ids'] as List).map((tagId) {
                    final tag = tagsList.firstWhere((t) => t['id'] == tagId, orElse: () => {});
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        tag['name'] ?? 'Unknown',
                        style: TextStyle(color: Colors.red.shade800, fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    );
                  }).toList(),
                )
              else
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: label.contains('Website') ? Colors.blue : Colors.black,
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildStatusButtons() {
    return Container(
      margin: EdgeInsets.only(top: 16),
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
          ],
        ),
      ),
    );
  }

  // Widget _buildStatusButton(String text, Color color, bool isActive) {
  //   return ElevatedButton(
  //     onPressed: () async {
  //       if (text == 'New Quotation') {
  //         if (client == null) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(content: Text('Odoo client not initialized')),
  //           );
  //           return;
  //         }
  //
  //         try {
  //           // Call the action_quotation_new method on the crm.lead
  //           final response = await client!.callKw({
  //             'model': 'crm.lead',
  //             'method': 'action_sale_quotations_new',
  //             'args': [widget.leadId],
  //             'kwargs': {},
  //           });
  //           log('qtaaaa$response');
  //
  //           // The response should contain the action to open the new quotation
  //           if (response != null && response['res_id'] != null) {
  //             final quotationId = response['res_id'];
  //             // Navigate to QuotationPage with the new quotation ID
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => QuotationPage(quotationId: quotationId,customerName: leadData['partner_id'][1].toString(),),
  //               ),
  //             );
  //           } else {
  //             throw Exception('Failed to create new quotation');
  //           }
  //         } catch (e) {
  //             log('Error creating quotation: $e');
  //         }
  //       }
  //       // Add logic for other buttons (Won, Lost) if needed
  //     },
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: isActive ? color : Colors.grey.shade200,
  //       foregroundColor: isActive ? Colors.white : Colors.black87,
  //       elevation: isActive ? 2 : 0,
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  //     ),
  //     child: Text(text),
  //   );
  // }

  Widget _buildStatusButton(String text, Color color, bool isActive) {
    return ElevatedButton(
      onPressed: () async {
        if (client == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Odoo client not initialized')),
          );
          return;
        }

        try {
          if (text == 'New Quotation') {
            // Fetch opportunity data to ensure partner_id exists
            final leadResponse = await client!.callKw({
              'model': 'crm.lead',
              'method': 'read',
              'args': [
                [widget.leadId],
                ['partner_id', 'name'], // Fetch partner_id and name for validation
              ],
              'kwargs': {},
            });

            if (leadResponse == null || leadResponse.isEmpty) {
              throw Exception('Opportunity not found');
            }

            final leadData = leadResponse[0];
            final partnerId = leadData['partner_id'] is List && leadData['partner_id'].isNotEmpty
                ? leadData['partner_id'][0] as int
                : null;
            final customerName = leadData['partner_id'] is List && leadData['partner_id'].length > 1
                ? leadData['partner_id'][1].toString()
                : leadData['name']?.toString() ?? 'Unknown';

            if (partnerId == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cannot create quotation: Opportunity has no customer (partner_id) set.'),
                ),
              );
              return;
            }

            // Create a new sale.order linked to the opportunity
            final createResponse = await client!.callKw({
              'model': 'sale.order',
              'method': 'create',
              'args': [
                {
                  'opportunity_id': widget.leadId, // Link to the opportunity
                  'partner_id': partnerId, // Mandatory customer field
                  'state': 'draft', // Set initial state as draft
                }
              ],
              'kwargs': {},
            });

            log('New Quotation Created: $createResponse');

            if (createResponse != null) {
              final quotationId = createResponse as int;
              // Navigate to QuotationPage with the new quotation ID
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuotationPage(
                    quotationId: quotationId,
                    customerName: customerName,
                    partnerId: partnerId,
                  ),
                ),
              );
            } else {
              throw Exception('Failed to create new quotation');
            }
          } else if (text == 'Won') {
            // Call action_set_won_rainbowman to mark the opportunity as won
            final wonResponse = await client!.callKw({
              'model': 'crm.lead',
              'method': 'action_set_won_rainbowman',
              'args': [
                [widget.leadId]
              ],
              'kwargs': {},
            });

            log('Mark as Won Response: $wonResponse');

            // Refresh lead details to reflect the updated state
            await fetchLeadDetails();

            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Opportunity marked as Won!'),
                  backgroundColor: Color(0xFF9EA700),
                ),
              );
            }
          } else if (text == 'Lost') {
            // Since the Lost button triggers a wizard (action ID 415), we can either:
            // 1. Directly call action_set_lost (if no reason is required)
            // 2. Create a wizard and call action_set_lost on it (if a reason is needed)

            // For simplicity, let's directly call action_set_lost
            // If you need to specify a reason, we can implement the wizard flow instead

            final lostResponse = await client!.callKw({
              'model': 'crm.lead',
              'method': 'action_set_lost',
              'args': [
                [widget.leadId]
              ],
              'kwargs': {
                'context': {
                  'default_lead_ids': [widget.leadId],
                },
              },
            });

            log('Mark as Lost Response: $lostResponse');

            // Refresh lead details to reflect the updated state
            await fetchLeadDetails();

            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Opportunity marked as Lost!'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        } catch (e) {
          log('Error for $text action: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error for $text action: $e')),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? color : Colors.grey.shade200,
        foregroundColor: isActive ? Colors.white : Colors.black87,
        elevation: isActive ? 2 : 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Text(text),
    );
  }

  Widget _buildTagsSelector() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Tags', style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
              SizedBox(width: 4),
              Icon(Icons.help_outline, size: 12, color: Colors.grey),
            ],
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: tagsList.map((tag) {
              final isSelected = selectedTags.contains(tag['id']);
              return FilterChip(
                label: Text(tag['name']),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      selectedTags.add(tag['id']);
                    } else {
                      selectedTags.remove(tag['id']);
                    }
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade300))),
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
          height: isEditing ? 600 : 400,
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
          isEditing
              ? TextField(
            controller: descriptionController,
            maxLines: 5,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          )
              : Text(leadData['description'] is String ? leadData['description'] : 'No notes available'),
        ],
      ),
    );
  }

  Widget _buildExtraInfoTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CONTACT INFORMATION',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey.shade700),
            ),
            SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildInfoField(
                    'Contact Name',
                    contactNameController.text,
                    textController: contactNameController,
                  ),
                ),
                Expanded(
                  child: _buildInfoField(
                    'Company Name',
                    companyNameController.text,
                    textController: companyNameController,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            if (!isEditing)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildInfoField(
                      'Address',
                      addressController.text,
                      textController: addressController,
                    ),
                  ),
                  Expanded(
                    child: _buildInfoField(
                      'Website',
                      websiteController.text,
                      textController: websiteController,
                    ),
                  ),
                ],
              )
            else
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildInfoField(
                          'Street',
                          streetController.text,
                          textController: streetController,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _buildInfoField(
                          'City',
                          cityController.text,
                          textController: cityController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomDropdown<String>(
                          decoration: CustomDropdownDecoration(
                            closedFillColor: Color(0x1B9EA700),
                            closedBorderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Select State',
                          items: states.map<String>((data) => data['name'].toString()).toList(),
                          initialItem: selectedState,
                          onChanged: (value) {
                            setState(() {
                              selectedState = value;
                              stateController.text = value ?? '';
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _buildInfoField(
                          'Zip',
                          zipController.text,
                          textController: zipController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  CustomDropdown<String>(
                    decoration: CustomDropdownDecoration(
                      closedFillColor: Color(0x1B9EA700),
                      closedBorderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Select Country',
                    items: countries.map<String>((data) => data['name'].toString()).toList(),
                    initialItem: selectedCountry,
                    onChanged: (value) {
                      setState(() {
                        selectedCountry = value;
                        countryController.text = value ?? '';
                      });
                    },
                  ),
                  SizedBox(height: 12),
                  _buildInfoField(
                    'Website',
                    websiteController.text,
                    textController: websiteController,
                  ),
                ],
              ),
            SizedBox(height: 16),
            Text(
              'MARKETING',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey.shade700),
            ),
            SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: isEditing
                      ? CustomDropdown<String>(
                    decoration: CustomDropdownDecoration(
                      closedFillColor: Color(0x1B9EA700),
                      closedBorderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Select Campaign',
                    items: campaigns.map<String>((data) => data['name'].toString()).toList(),
                    initialItem: selectedCampaign,
                    onChanged: (value) {
                      setState(() {
                        selectedCampaign = value;
                        campaignController.text = value ?? '';
                      });
                    },
                  )
                      : _buildInfoField(
                    'Campaign',
                    campaignController.text,
                    textController: campaignController,
                  ),
                ),
                Expanded(
                  child: isEditing
                      ? CustomDropdown<String>(
                    decoration: CustomDropdownDecoration(
                      closedFillColor: Color(0x1B9EA700),
                      closedBorderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Select Medium',
                    items: mediums.map<String>((data) => data['name'].toString()).toList(),
                    initialItem: selectedMedium,
                    onChanged: (value) {
                      setState(() {
                        selectedMedium = value;
                        mediumController.text = value ?? '';
                      });
                    },
                  )
                      : _buildInfoField(
                    'Medium',
                    mediumController.text,
                    textController: mediumController,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: isEditing
                      ? CustomDropdown<String>(
                    decoration: CustomDropdownDecoration(
                      closedFillColor: Color(0x1B9EA700),
                      closedBorderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Select Source',
                    items: sources.map<String>((data) => data['name'].toString()).toList(),
                    initialItem: selectedSource,
                    onChanged: (value) {
                      setState(() {
                        selectedSource = value;
                        sourceController.text = value ?? '';
                      });
                    },
                  )
                      : _buildInfoField(
                    'Source',
                    sourceController.text,
                    textController: sourceController,
                  ),
                ),
                Expanded(
                  child: _buildInfoField(
                    'Referred By',
                    referredByController.text,
                    textController: referredByController,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'TRACKING',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey.shade700),
            ),
            SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: isEditing
                      ? CustomDropdown<String>(
                    decoration: CustomDropdownDecoration(
                      closedFillColor: Color(0x1B9EA700),
                      closedBorderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Select Company',
                    items: companies.map<String>((data) => data['name'].toString()).toList(),
                    initialItem: selectedCompany,
                    onChanged: (value) {
                      setState(() {
                        selectedCompany = value;
                        trackingCompanyController.text = value ?? '';
                      });
                    },
                  )
                      : _buildInfoField(
                    'Company',
                    trackingCompanyController.text,
                    textController: trackingCompanyController,
                  ),
                ),
                Expanded(
                  child: isEditing
                      ? CustomDropdown<String>(
                    decoration: CustomDropdownDecoration(
                      closedFillColor: Color(0x1B9EA700),
                      closedBorderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Select Sales Team',
                    items: salesTeams.map<String>((data) => data['name'].toString()).toList(),
                    initialItem: selectedSalesTeam,
                    onChanged: (value) {
                      setState(() {
                        selectedSalesTeam = value;
                        salesTeamController.text = value ?? '';
                      });
                    },
                  )
                      : _buildInfoField(
                    'Sales Team',
                    salesTeamController.text,
                    textController: salesTeamController,
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
                    'Days to Assign',
                    daysToAssignController.text,
                    textController: daysToAssignController,
                  ),
                ),
                Expanded(
                  child: _buildInfoField(
                    'Days to Close',
                    daysToCloseController.text,
                    textController: daysToCloseController,
                  ),
                ),
              ],
            ),
          ],
        ),
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
          Text(
            leadData['partner_id'] is List && leadData['partner_id'].length > 1 ? leadData['partner_id'][1].toString() : 'No partner assigned',
          ),
        ],
      ),
    );
  }
}