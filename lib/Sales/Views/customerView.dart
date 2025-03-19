import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'dart:developer' as developer;
import 'dart:convert';

class CustomerView extends StatefulWidget {
  final int customerId;

  const CustomerView({super.key, required this.customerId});

  @override
  State<CustomerView> createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {
  OdooClient? client;
  int? currentUserId;
  bool isLoading = false;
  bool isEditing = false;
  Map<String, dynamic>? customerData;
  List<Map<String, dynamic>> contactList = [];
  String? customerImageBase64;
  Map<int, String> categoryMap = {};
  Map<int, String> categoryPathMap = {};

  String selectedTab = 'Contacts & Addresses';


  late TextEditingController nameController;
  late TextEditingController streetController;
  late TextEditingController cityController;
  late TextEditingController zipController;
  late TextEditingController phoneController;
  late TextEditingController mobileController;
  late TextEditingController emailController;
  late TextEditingController websiteController;
  late TextEditingController vatController;

  // Dropdown data
  List<Map<String, dynamic>> countries = [];
  List<Map<String, dynamic>> states = [];
  int? selectedCountryId;
  int? selectedStateId;

  @override
  void initState() {
    super.initState();
    initializeControllers();
    initializeOdooClient();
  }

  void initializeControllers() {
    nameController = TextEditingController();
    streetController = TextEditingController();
    cityController = TextEditingController();
    zipController = TextEditingController();
    phoneController = TextEditingController();
    mobileController = TextEditingController();
    emailController = TextEditingController();
    websiteController = TextEditingController();
    vatController = TextEditingController();
  }

  Future<void> initializeOdooClient() async {
    setState(() => isLoading = true);
    final prefs = await SharedPreferences.getInstance();
    final baseUrl = prefs.getString("urldata") ?? "";
    final dbName = prefs.getString("selectedDatabase") ?? "";
    final userLogin = prefs.getString("userLogin") ?? "";
    final userPassword = prefs.getString("password") ?? "";
    currentUserId = prefs.getInt("userId");

    if (baseUrl.isNotEmpty && dbName.isNotEmpty && userLogin.isNotEmpty && userPassword.isNotEmpty) {
      client = OdooClient(baseUrl);
      try {
        final auth = await client!.authenticate(dbName, userLogin, userPassword);
        developer.log("Odoo Authenticated: $auth");
        await fetchCustomerData();
        await fetchCategoryData();
        await fetchDropdownData();
      } catch (e) {
        developer.log("Odoo Authentication Failed: $e");
      }
    }
    setState(() => isLoading = false);
  }

  Future<void> fetchCustomerData() async {
    if (client == null) {
      developer.log("Client is null");
      return;
    }

    try {
      final response = await client!.callKw({
        'model': 'res.partner',
        'method': 'search_read',
        'args': [
          [
            ['id', '=', widget.customerId]
          ]
        ],
        'kwargs': {
          'fields': [
            'name',
            'is_company',
            'street',
            'city',
            'state_id',
            'zip',
            'country_id',
            'phone',
            'mobile',
            'email',
            'website',
            'vat',
            'category_id',
            'child_ids',
            'image_1920',
            'assigned_partner_id',
            'receipt_reminder_email',
            'property_payment_term_id',
            'property_delivery_carrier_id',
            'property_product_pricelist',
            'property_account_position_id',
            'property_stock_customer',
            'property_stock_supplier',
            'property_supplier_payment_term_id',
            'company_id',
            'ref',
            'industry_id',
            'grade_id',
            'activation',
            'partner_weight',
            'date_review',
            'date_review_next',
            'date_partnership',
            'date_localization',
          ],
        }
      });

      developer.log("Customer data fetched: $response");

      if (response != null && response.isNotEmpty) {
        setState(() {
          customerData = Map<String, dynamic>.from(response[0]);
          customerImageBase64 = customerData!['image_1920']?.toString();
          if (customerData!['child_ids'] != null && customerData!['child_ids'] is List) {
            fetchContacts(List<int>.from(customerData!['child_ids']));
          }
          updateControllers();
        });
      }
    } catch (e) {
      developer.log("Failed to fetch customer data: $e");
    }
  }

  void updateControllers() {
    nameController.text = customerData!['name']?.toString() ?? '';
    streetController.text = customerData!['street']?.toString() ?? '';
    cityController.text = customerData!['city']?.toString() ?? '';
    zipController.text = customerData!['zip']?.toString() ?? '';
    phoneController.text = customerData!['phone']?.toString() ?? '';
    mobileController.text = customerData!['mobile']?.toString() ?? '';
    emailController.text = customerData!['email']?.toString() ?? '';
    websiteController.text = customerData!['website']?.toString() ?? '';
    vatController.text = customerData!['vat']?.toString() ?? '';
    selectedCountryId = customerData!['country_id'] is List ? customerData!['country_id'][0] : null;
    selectedStateId = customerData!['state_id'] is List ? customerData!['state_id'][0] : null;
  }

  Future<void> fetchDropdownData() async {
    if (client == null) return;

    try {
      // Fetch countries
      final countryResponse = await client!.callKw({
        'model': 'res.country',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {'fields': ['id', 'name']},
      });
      setState(() {
        countries = List<Map<String, dynamic>>.from(countryResponse);
      });

      // Fetch states
      final stateResponse = await client!.callKw({
        'model': 'res.country.state',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {'fields': ['id', 'name', 'country_id']},
      });
      setState(() {
        states = List<Map<String, dynamic>>.from(stateResponse);
      });
    } catch (e) {
      developer.log("Failed to fetch dropdown data: $e");
    }
  }

  Future<void> fetchCategoryData() async {
    if (customerData == null || client == null) return;

    try {
      Set<int> categoryIds = {};
      if (customerData!['category_id'] != null && customerData!['category_id'] is List) {
        final categoryList = customerData!['category_id'] as List;
        for (var category in categoryList) {
          if (category is int) {
            categoryIds.add(category);
          } else if (category is List && category.isNotEmpty && category[0] is int) {
            categoryIds.add(category[0]);
          }
        }
      }

      developer.log("Category IDs from customer: $categoryIds");

      if (categoryIds.isNotEmpty) {
        final initialResponse = await client!.callKw({
          'model': 'res.partner.category',
          'method': 'search_read',
          'args': [
            [['id', 'in', categoryIds.toList()]]
          ],
          'kwargs': {
            'fields': ['id', 'name', 'parent_path'],
          },
        });

        if (initialResponse != null && mounted) {
          Set<int> allCategoryIds = {...categoryIds};
          for (var category in initialResponse) {
            String parentPath = category['parent_path'] ?? '';
            if (parentPath.isNotEmpty) {
              List<String> pathIds = parentPath.split('/').where((id) => id.isNotEmpty).toList();
              pathIds.forEach((id) => allCategoryIds.add(int.tryParse(id) ?? 0));
            }
          }

          developer.log("All Category IDs including parent_path: $allCategoryIds");

          final fullResponse = await client!.callKw({
            'model': 'res.partner.category',
            'method': 'search_read',
            'args': [
              [['id', 'in', allCategoryIds.toList()]]
            ],
            'kwargs': {
              'fields': ['id', 'name', 'parent_path'],
            },
          });

          if (fullResponse != null && mounted) {
            Map<int, String> tempCategoryMap = {for (var cat in fullResponse) cat['id']: cat['name']};
            setState(() {
              categoryMap = tempCategoryMap;
            });

            for (var category in fullResponse) {
              String parentPath = category['parent_path'] ?? '';
              if (parentPath.isNotEmpty) {
                List<String> pathIds = parentPath.split('/').where((id) => id.isNotEmpty).toList();
                List<String> pathNames = pathIds.map((id) {
                  int catId = int.tryParse(id) ?? 0;
                  return tempCategoryMap[catId] ?? 'Unknown';
                }).toList();
                categoryPathMap[category['id']] = pathNames.join('/');
              } else {
                categoryPathMap[category['id']] = category['name'];
              }
            }

            developer.log("Category Map: $categoryMap");
            developer.log("Category Path Map: $categoryPathMap");
          }
        }
      } else {
        developer.log("No category IDs found for this customer");
      }
    } catch (e) {
      developer.log("Error fetching categories: $e");
    }
  }

  Future<void> fetchContacts(List<int> contactIds) async {
    if (contactIds.isEmpty) return;

    try {
      final response = await client?.callKw({
        'model': 'res.partner',
        'method': 'search_read',
        'args': [
          [
            ['id', 'in', contactIds]
          ]
        ],
        'kwargs': {
          'fields': [
            'name',
            'function',
            'email',
            'phone',
            'image_1920',
          ],
        }
      });

      developer.log("Contacts data fetched: $response");

      if (response != null) {
        setState(() {
          contactList = List<Map<String, dynamic>>.from(response);
        });
      }
    } catch (e) {
      developer.log("Failed to fetch contacts: $e");
    }
  }

  Future<void> saveChanges() async {
    if (client == null || customerData == null) {
      developer.log("Client or customer data is null");
      return;
    }

    try {
      setState(() => isLoading = true);

      final payload = {
        'model': 'res.partner',
        'method': 'write',
        'args': [
          [widget.customerId],
          {
            'name': nameController.text,
            // 'street': streetController.text,
            // 'city': cityController.text,
            // 'zip': zipController.text,
            // 'country_id': selectedCountryId ?? false, // Handle null as false for Odoo
            // 'state_id': selectedStateId ?? false, // Handle null as false for Odoo
            // 'phone': phoneController.text,
            // 'mobile': mobileController.text,
            // 'email': emailController.text,
            // 'website': websiteController.text,
            // 'vat': vatController.text,
          }
        ],
      };
      developer.log("Saving changes for customer ID: ${widget.customerId}");
      developer.log("Payload: $payload");

      // Verify session
      await client!.checkSession();
      developer.log("Session is active");

      // Perform the write operation
      final response = await client!.callKw(payload);
      developer.log("Write response: $response");

      // Refresh data
      await fetchCustomerData();
      developer.log("Refreshed customer data: $customerData");

      setState(() => isEditing = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Changes saved successfully')));
    } catch (e) {
      developer.log("Failed to save changes: $e", error: e, stackTrace: StackTrace.current);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to save changes')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Customer Details'),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              if (isEditing) {
                saveChanges();
              } else {
                setState(() => isEditing = true);
              }
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : customerData == null
          ? const Center(child: Text('No customer data available'))
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCustomerHeader(),
            _buildAddressSection(),
            _buildContactInfoSection(),
            _buildTabBar(),
            if (selectedTab == 'Contacts & Addresses') _buildContactCards(),
            if (selectedTab == 'Sales & Purchase') _buildSalesAndPurchaseSection(),
            if (selectedTab == 'Partner Assignment') _buildPartnerAssignmentSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerHeader() {
    final bool isCompany = customerData!['is_company'] == true;
    final String customerType = isCompany ? 'company' : 'individual';

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Radio<String>(
                    value: 'individual',
                    groupValue: customerType,
                    onChanged: (value) {},
                  ),
                  const Text('Individual'),
                  const SizedBox(width: 16),
                  Radio<String>(
                    value: 'company',
                    groupValue: customerType,
                    onChanged: (value) {},
                  ),
                  const Text('Company'),
                ],
              ),
              isEditing
                  ? SizedBox(
                width: 200,
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
              )
                  : Text(
                customerData!['name']?.toString() ?? 'Unknown',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: customerImageBase64 != null && customerImageBase64!.isNotEmpty
                ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(
                base64Decode(customerImageBase64!),
                fit: BoxFit.cover,
                width: 80,
                height: 80,
              ),
            )
                : Container(
              color: Colors.grey[200],
              child: const Icon(
                Icons.person,
                size: 40,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 100,
            child: Text(
              'Address',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isEditing
                    ? TextField(controller: streetController, decoration: const InputDecoration(labelText: 'Street'))
                    : Text(customerData!['street']?.toString() ?? ''),
                isEditing
                    ? TextField(controller: cityController, decoration: const InputDecoration(labelText: 'City'))
                    : Text(customerData!['city']?.toString() ?? ''),
                isEditing && states.isNotEmpty
                    ? DropdownButton<int>(
                  value: selectedStateId,
                  hint: const Text('Select State'),
                  items: states
                      .where((state) =>
                  selectedCountryId == null || state['country_id'][0] == selectedCountryId)
                      .map((state) => DropdownMenuItem<int>(
                    value: state['id'],
                    child: Text(state['name']),
                  ))
                      .toList(),
                  onChanged: (value) => setState(() => selectedStateId = value),
                )
                    : Text(customerData!['state_id'] is List && customerData!['state_id'].length > 1
                    ? customerData!['state_id'][1].toString()
                    : ''),
                isEditing
                    ? TextField(controller: zipController, decoration: const InputDecoration(labelText: 'Zip'))
                    : Text(customerData!['zip']?.toString() ?? ''),
                isEditing && countries.isNotEmpty
                    ? DropdownButton<int>(
                  value: selectedCountryId,
                  hint: const Text('Select Country'),
                  items: countries
                      .map((country) => DropdownMenuItem<int>(
                    value: country['id'],
                    child: Text(country['name']),
                  ))
                      .toList(),
                  onChanged: (value) => setState(() {
                    selectedCountryId = value;
                    selectedStateId = null; // Reset state when country changes
                  }),
                )
                    : Text(customerData!['country_id'] is List && customerData!['country_id'].length > 1
                    ? customerData!['country_id'][1].toString()
                    : ''),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfoSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text('Tax ID', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 4),
                  ],
                ),
                const SizedBox(height: 4),
                isEditing
                    ? TextField(controller: vatController, decoration: const InputDecoration(labelText: 'Tax ID'))
                    : Text(customerData!['vat']?.toString() ?? 'N/A'),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Phone', phoneController, customerData!['phone']?.toString() ?? '',
                    hasIcon: true, isLink: true),
                _buildInfoRow('Mobile', mobileController, customerData!['mobile']?.toString() ?? '',
                    hasIcon: true),
                _buildInfoRow('Email', emailController, customerData!['email']?.toString() ?? '',
                    hasIcon: true, isLink: true),
                _buildInfoRow('Website', websiteController, customerData!['website']?.toString() ?? '',
                    hasIcon: true, isLink: true),
                _buildTagsRow(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, TextEditingController controller, String value,
      {bool hasIcon = false, bool isLink = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Row(
              children: [
                Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
                if (hasIcon) const Padding(padding: EdgeInsets.only(left: 4)),
              ],
            ),
          ),
          Expanded(
            child: isEditing
                ? TextField(controller: controller, decoration: InputDecoration(labelText: label))
                : Text(
              value,
              style: TextStyle(color: isLink ? const Color(0xFF9EA700) : Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagsRow() {
    List<String> categoryPaths = [];
    if (customerData!['category_id'] != null && customerData!['category_id'] is List) {
      final categoryList = customerData!['category_id'] as List;
      for (var category in categoryList) {
        int categoryId = category is int ? category : (category is List && category.isNotEmpty ? category[0] : null);
        if (categoryId != null && categoryPathMap.containsKey(categoryId)) {
          categoryPaths.add(categoryPathMap[categoryId]!);
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 80,
            child: Row(
              children: [
                Text(
                  'Tags',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 4),
              ],
            ),
          ),
          Expanded(
            child: Wrap(
              spacing: 4,
              children: categoryPaths.isNotEmpty
                  ? categoryPaths.take(2).map((path) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: getCategoryColor(path),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  path,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )).toList()
                  : [const Text('N/A')],
            ),
          ),
        ],
      ),
    );
  }

  Color getCategoryColor(String path) {
    String category = path.split('/').last.toLowerCase();
    if (category.contains('vendor') || category.contains('desk')) {
      return Colors.green[600]!;
    } else if (category.contains('service')) {
      return Colors.cyan[600]!;
    } else if (category.contains('office')) {
      return Colors.blue[600]!;
    } else if (category.contains('consult')) {
      return Colors.purple[300]!;
    }
    return Colors.grey[600]!;
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey[300]!),
          bottom: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildTabItem('Contacts & Addresses', isSelected: selectedTab == 'Contacts & Addresses'),
            _buildTabItem('Sales & Purchase', isSelected: selectedTab == 'Sales & Purchase'),
            _buildTabItem('Invoicing'),
            _buildTabItem('Internal Notes'),
            _buildTabItem('Partner Assignment', isSelected: selectedTab == 'Partner Assignment'),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(String title, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = title;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? const Color(0xFF9EA700) : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildContactCards() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: contactList.isNotEmpty
              ? contactList.map((contact) {
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: _buildContactCard(
                contact['image_1920']?.toString(),
                contact['name']?.toString() ?? 'Unknown',
                contact['function']?.toString() ?? 'N/A',
                contact['email']?.toString() ?? 'N/A',
                contact['phone']?.toString() ?? 'N/A',
              ),
            );
          }).toList()
              : [
            const Text('No contacts available'),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(
      String? contactImageBase64, String name, String position, String email, String phone) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: contactImageBase64 != null && contactImageBase64.isNotEmpty
                  ? Image.memory(
                base64Decode(contactImageBase64),
                fit: BoxFit.cover,
                width: 60,
                height: 60,
              )
                  : const Icon(Icons.person, size: 40, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  position,
                  style: TextStyle(color: Colors.grey[700]),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  email,
                  style: const TextStyle(color: Color(0xFF9EA700)),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Phone: $phone',
                  style: TextStyle(color: Colors.grey[700]),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalesAndPurchaseSection() {
    String _getDisplayName(dynamic field, {String defaultValue = ''}) {
      if (field is List && field.length > 1) {
        return field[1].toString();
      }
      return field?.toString() ?? defaultValue;
    }

    String salesperson = _getDisplayName(customerData!['user_id']);
    String salesTeam = _getDisplayName(customerData!['team_id']);
    String paymentTermsSales = _getDisplayName(customerData!['property_payment_term_id']);
    String implementedBy = _getDisplayName(customerData!['assigned_partner_id'], defaultValue: '');
    String pricelist = _getDisplayName(customerData!['property_product_pricelist']);
    String deliveryMethod = _getDisplayName(customerData!['property_delivery_carrier_id']);

    String buyer = _getDisplayName(customerData!['purchase_user_id'], defaultValue: '');
    String paymentTermsPurchase = _getDisplayName(customerData!['property_supplier_payment_term_id']);
    String paymentMethod = _getDisplayName(customerData!['property_supplier_payment_method_id'], defaultValue: '');
    String receiptReminder = customerData!['receipt_reminder_email']?.toString() ?? '';

    String fiscalPosition = _getDisplayName(customerData!['property_account_position_id']);

    String companyId = _getDisplayName(customerData!['company_id']);
    String reference = _getDisplayName(customerData!['ref']);
    String company = _getDisplayName(customerData!['company_id']);
    String website = _getDisplayName(customerData!['website']);
    String industry = _getDisplayName(customerData!['industry_id']);

    String customerLocation = _getDisplayName(customerData!['property_stock_customer'], defaultValue: 'Partners/Customers');
    String vendorLocation = _getDisplayName(customerData!['property_stock_supplier'], defaultValue: 'Partners/Vendors');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: const Text(
                'SALES',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildSalesPurchaseRow('Salesperson', salesperson),
            const SizedBox(height: 16),
            _buildSalesPurchaseRow('Sales Team', salesTeam),
            const SizedBox(height: 16),
            _buildSalesPurchaseRow('PAYMENT TERMS', paymentTermsSales),
            const SizedBox(height: 16),
            _buildSalesPurchaseRow('IMPLEMENTED BY', implementedBy, isHighlighted: true),
            const SizedBox(height: 16),
            _buildSalesPurchaseRow('DELIVERY METHOD', deliveryMethod, isHighlighted: true),
            const SizedBox(height: 32),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: const Text(
                'PURCHASE',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildSalesPurchaseRow('Buyer', buyer),
            const SizedBox(height: 16),
            _buildSalesPurchaseRow('Payment Terms', paymentTermsPurchase),
            const SizedBox(height: 16),
            _buildSalesPurchaseRow('PAYMENT METHOD', paymentMethod),
            const SizedBox(height: 16),
            _buildSalesPurchaseRowWithIcon('Receipt Reminder', receiptReminder, true),
            const SizedBox(height: 32),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: const Text(
                'FISCAL INFORMATION',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildSalesPurchaseRow('Fiscal Position', fiscalPosition),
            const SizedBox(height: 32),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: const Text(
                'MISC',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildSalesPurchaseRow('COMPANY ID', companyId),
            const SizedBox(height: 16),
            _buildSalesPurchaseRow('Reference', reference),
            const SizedBox(height: 16),
            _buildSalesPurchaseRow('COMPANY', company),
            const SizedBox(height: 16),
            _buildSalesPurchaseRow('Website', website),
            const SizedBox(height: 16),
            _buildSalesPurchaseRow('Industry', industry),
            const SizedBox(height: 32),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: const Text(
                'INVENTORY',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildSalesPurchaseRow('CUSTOMER LOCATION', customerLocation),
            const SizedBox(height: 16),
            _buildSalesPurchaseRow('VENDOR LOCATION', vendorLocation),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildPartnerAssignmentSection() {
    String _getDisplayName(dynamic field, {String defaultValue = ''}) {
      if (field is List && field.length > 1) {
        return field[1].toString();
      }
      return field?.toString() ?? defaultValue;
    }

    String partnerLevel = _getDisplayName(customerData!['grade_id']);
    String activation = _getDisplayName(customerData!['activation']);
    String levelWeight = _getDisplayName(customerData!['partner_weight'], defaultValue: '0');
    String latestPartnerReview = _getDisplayName(customerData!['date_review']);
    String nextPartnerReview = _getDisplayName(customerData!['date_review_next']);
    String partnershipDate = _getDisplayName(customerData!['date_partnership']);
    String latitude = _getDisplayName(customerData!['date_localization'], defaultValue: '0.00000000');
    String longitude = _getDisplayName(customerData!['date_localization'], defaultValue: '0.00000000');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: const Text(
                'PARTNER ACTIVATION',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildSalesPurchaseRow('Partner Level', partnerLevel),
            const SizedBox(height: 16),
            _buildSalesPurchaseRow('Activation', activation),
            const SizedBox(height: 16),
            _buildSalesPurchaseRow('Level Weight', levelWeight),
            const SizedBox(height: 32),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: const Text(
                'PARTNER REVIEW',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildSalesPurchaseRow('Latest Partner Review', latestPartnerReview),
            const SizedBox(height: 16),
            _buildSalesPurchaseRow('Next Partner Review', nextPartnerReview),
            const SizedBox(height: 16),
            _buildSalesPurchaseRow('Partnership Date', partnershipDate),
            const SizedBox(height: 32),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: const Text(
                'GEOLOCATION',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildSalesPurchaseRow('Geo Location', 'Lat: $latitude\nLong: $longitude'),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSalesPurchaseRow(String label, String value, {bool isHighlighted = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isNotEmpty ? value : '',
              style: TextStyle(
                color: isHighlighted ? const Color(0xFF9EA700) : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalesPurchaseRowWithIcon(String label, String value, bool hasIcon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Text(
                  value.isNotEmpty ? value : '',
                  style: const TextStyle(
                    color: Color(0xFF9EA700),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (hasIcon) ...[
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.check_circle,
                    color: Color(0xFF9EA700),
                    size: 16,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    streetController.dispose();
    cityController.dispose();
    zipController.dispose();
    phoneController.dispose();
    mobileController.dispose();
    emailController.dispose();
    websiteController.dispose();
    vatController.dispose();
    super.dispose();
  }
}