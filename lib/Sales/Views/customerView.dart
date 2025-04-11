import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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

  // Basic controllers
  late TextEditingController nameController;
  late TextEditingController streetController;
  late TextEditingController cityController;
  late TextEditingController zipController;
  late TextEditingController phoneController;
  late TextEditingController mobileController;
  late TextEditingController emailController;
  late TextEditingController websiteController;
  late TextEditingController vatController;

  // Sales & Purchase controllers
  late TextEditingController salespersonController;
  late TextEditingController salesTeamController;
  late TextEditingController paymentTermsSalesController;
  late TextEditingController implementedByController;
  late TextEditingController pricelistController;
  late TextEditingController deliveryMethodController;
  late TextEditingController buyerController;
  late TextEditingController paymentTermsPurchaseController;
  late TextEditingController paymentMethodController;
  late TextEditingController fiscalPositionController;
  late TextEditingController companyIdController;
  late TextEditingController referenceController;
  late TextEditingController companyController;
  late TextEditingController industryController;
  late TextEditingController customerLocationController;
  late TextEditingController vendorLocationController;

  // Partner Assignment controllers
  late TextEditingController partnerLevelController;
  late TextEditingController activationController;
  late TextEditingController levelWeightController;
  late TextEditingController latestReviewController;
  late TextEditingController nextReviewController;
  late TextEditingController partnershipDateController;

  // Dropdown data
  List<Map<String, dynamic>> countries = [];
  List<Map<String, dynamic>> states = [];
  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> teams = [];
  List<Map<String, dynamic>> paymentTerms = [];
  List<Map<String, dynamic>> partners = [];
  List<Map<String, dynamic>> pricelists = [];
  List<Map<String, dynamic>> deliveryCarriers = [];
  List<Map<String, dynamic>> paymentMethods = [];
  List<Map<String, dynamic>> fiscalPositions = [];
  List<Map<String, dynamic>> companies = [];
  List<Map<String, dynamic>> industries = [];
  List<Map<String, dynamic>> locations = [];
  List<Map<String, dynamic>> grades = [];
  List<Map<String, dynamic>> activations = [];
  List<Map<String, dynamic>> websites = [];

  // Selected indices (not IDs)
  int? selectedCountryIndex;
  int? selectedStateIndex;
  int? selectedSalespersonIndex;
  int? selectedSalesTeamIndex;
  int? selectedPaymentTermsSalesIndex;
  int? selectedImplementedByIndex;
  int? selectedPricelistIndex;
  int? selectedDeliveryMethodIndex;
  int? selectedBuyerIndex;
  int? selectedPaymentTermsPurchaseIndex;
  int? selectedPaymentMethodIndex;
  int? selectedFiscalPositionIndex;
  int? selectedCompanyIndex;
  int? selectedIndustryIndex;
  int? selectedCustomerLocationIndex;
  int? selectedVendorLocationIndex;
  int? selectedPartnerLevelIndex;
  int? selectedActivationIndex;
  int? selectedWebsiteIndex;

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

    salespersonController = TextEditingController();
    salesTeamController = TextEditingController();
    paymentTermsSalesController = TextEditingController();
    implementedByController = TextEditingController();
    pricelistController = TextEditingController();
    deliveryMethodController = TextEditingController();
    buyerController = TextEditingController();
    paymentTermsPurchaseController = TextEditingController();
    paymentMethodController = TextEditingController();
    fiscalPositionController = TextEditingController();
    companyIdController = TextEditingController();
    referenceController = TextEditingController();
    companyController = TextEditingController();
    industryController = TextEditingController();
    customerLocationController = TextEditingController();
    vendorLocationController = TextEditingController();

    partnerLevelController = TextEditingController();
    activationController = TextEditingController();
    levelWeightController = TextEditingController();
    latestReviewController = TextEditingController();
    nextReviewController = TextEditingController();
    partnershipDateController = TextEditingController();
  }

  Future<void> initializeOdooClient() async {
    setState(() => isLoading = true);
    final prefs = await SharedPreferences.getInstance();
    final baseUrl = prefs.getString("urldata") ?? "";
    final dbName = prefs.getString("selectedDatabase") ?? "";
    final userLogin = prefs.getString("userLogin") ?? "";
    final userPassword = prefs.getString("password") ?? "";
    currentUserId = prefs.getInt("userId");

    if (baseUrl.isEmpty ||
        dbName.isEmpty ||
        userLogin.isEmpty ||
        userPassword.isEmpty) {
      developer.log(
          "Missing required authentication details: URL: $baseUrl, DB: $dbName, Login: $userLogin");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Missing authentication details. Please check settings.')),
      );
      setState(() => isLoading = false);
      return;
    }

    client = OdooClient(baseUrl);
    try {
      await client!.authenticate(dbName, userLogin, userPassword);
      developer.log("Odoo Authenticated successfully");
      await fetchCustomerData();
      await fetchCategoryData();
      await fetchDropdownData();
    } catch (e) {
      developer.log("Odoo Authentication Failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Authentication failed: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> fetchCustomerData() async {
    if (client == null) {
      developer.log("Odoo client is null");
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
            'user_id',
            'team_id',
            'property_payment_term_id',
            'assigned_partner_id',
            'property_product_pricelist',
            'property_delivery_carrier_id',
            'property_supplier_payment_term_id',
            'property_payment_method_id',
            'receipt_reminder_email',
            'property_account_position_id',
            'company_id',
            'ref',
            'industry_id',
            'property_stock_customer',
            'property_stock_supplier',
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

      developer
          .log("Customer data response for ID ${widget.customerId}: $response");

      if (response != null && response.isNotEmpty && response[0] is Map) {
        setState(() {
          customerData = Map<String, dynamic>.from(response[0]);
          customerImageBase64 = customerData!['image_1920']?.toString();
          if (customerData!['child_ids'] != null &&
              customerData!['child_ids'] is List) {
            fetchContacts(List<int>.from(customerData!['child_ids']));
          }
          updateControllers();
        });
      } else {
        developer.log("No customer data found for ID: ${widget.customerId}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('No customer found with ID: ${widget.customerId}')),
        );
      }
    } catch (e) {
      developer.log("Failed to fetch customer data: $e",
          error: e, stackTrace: StackTrace.current);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching customer data: $e')),
      );
    }
  }

  void updateControllers() {
    nameController.text = (customerData!['name'] == null ||
            customerData!['name'] == false ||
            customerData!['name'] == '')
        ? 'N/A'
        : customerData!['name'].toString();
    streetController.text = (customerData!['street'] == null ||
            customerData!['street'] == false ||
            customerData!['street'] == '')
        ? 'N/A'
        : customerData!['street'].toString();
    cityController.text = (customerData!['city'] == null ||
            customerData!['city'] == false ||
            customerData!['city'] == '')
        ? 'N/A'
        : customerData!['city'].toString();
    zipController.text = (customerData!['zip'] == null ||
            customerData!['zip'] == false ||
            customerData!['zip'] == '')
        ? 'N/A'
        : customerData!['zip'].toString();
    phoneController.text = (customerData!['phone'] == null ||
            customerData!['phone'] == false ||
            customerData!['phone'] == '')
        ? 'N/A'
        : customerData!['phone'].toString();
    mobileController.text = (customerData!['mobile'] == null ||
            customerData!['mobile'] == false ||
            customerData!['mobile'] == '')
        ? 'N/A'
        : customerData!['mobile'].toString();
    emailController.text = (customerData!['email'] == null ||
            customerData!['email'] == false ||
            customerData!['email'] == '')
        ? 'N/A'
        : customerData!['email'].toString();
    websiteController.text = (customerData!['website'] == null ||
            customerData!['website'] == false ||
            customerData!['website'] == '')
        ? 'N/A'
        : customerData!['website'].toString();
    vatController.text = (customerData!['vat'] == null ||
            customerData!['vat'] == false ||
            customerData!['vat'] == '')
        ? 'N/A'
        : customerData!['vat'].toString();
    selectedCountryIndex = customerData!['country_id'] is List
        ? countries.indexWhere((c) => c['id'] == customerData!['country_id'][0])
        : null;
    selectedStateIndex = customerData!['state_id'] is List
        ? states.indexWhere((s) => s['id'] == customerData!['state_id'][0])
        : null;

    selectedSalespersonIndex = customerData!['user_id'] is List
        ? users.indexWhere((u) => u['id'] == customerData!['user_id'][0])
        : null;
    salespersonController.text = customerData!['user_id'] is List
        ? customerData!['user_id'][1].toString()
        : '';
    selectedSalesTeamIndex = customerData!['team_id'] is List
        ? teams.indexWhere((t) => t['id'] == customerData!['team_id'][0])
        : null;
    salesTeamController.text = customerData!['team_id'] is List
        ? customerData!['team_id'][1].toString()
        : '';
    selectedPaymentTermsSalesIndex =
        customerData!['property_payment_term_id'] is List
            ? paymentTerms.indexWhere(
                (p) => p['id'] == customerData!['property_payment_term_id'][0])
            : null;
    paymentTermsSalesController.text =
        customerData!['property_payment_term_id'] is List
            ? customerData!['property_payment_term_id'][1].toString()
            : '';
    selectedImplementedByIndex = customerData!['assigned_partner_id'] is List
        ? partners.indexWhere(
            (p) => p['id'] == customerData!['assigned_partner_id'][0])
        : null;
    implementedByController.text = customerData!['assigned_partner_id'] is List
        ? customerData!['assigned_partner_id'][1].toString()
        : '';
    selectedPricelistIndex = customerData!['property_product_pricelist'] is List
        ? pricelists.indexWhere(
            (p) => p['id'] == customerData!['property_product_pricelist'][0])
        : null;
    pricelistController.text =
        customerData!['property_product_pricelist'] is List
            ? customerData!['property_product_pricelist'][1].toString()
            : '';
    selectedDeliveryMethodIndex = customerData!['property_delivery_carrier_id']
            is List
        ? deliveryCarriers.indexWhere(
            (d) => d['id'] == customerData!['property_delivery_carrier_id'][0])
        : null;
    deliveryMethodController.text =
        customerData!['property_delivery_carrier_id'] is List
            ? customerData!['property_delivery_carrier_id'][1].toString()
            : '';
    selectedPaymentTermsPurchaseIndex =
        customerData!['property_supplier_payment_term_id'] is List
            ? paymentTerms.indexWhere((p) =>
                p['id'] ==
                customerData!['property_supplier_payment_term_id'][0])
            : null;
    paymentTermsPurchaseController.text =
        customerData!['property_supplier_payment_term_id'] is List
            ? customerData!['property_supplier_payment_term_id'][1].toString()
            : '';
    selectedPaymentMethodIndex = customerData!['property_payment_method_id']
            is List
        ? paymentMethods.indexWhere(
            (p) => p['id'] == customerData!['property_payment_method_id'][0])
        : null;
    paymentMethodController.text =
        customerData!['property_payment_method_id'] is List
            ? customerData!['property_payment_method_id'][1].toString()
            : '';
    selectedFiscalPositionIndex = customerData!['property_account_position_id']
            is List
        ? fiscalPositions.indexWhere(
            (f) => f['id'] == customerData!['property_account_position_id'][0])
        : null;
    fiscalPositionController.text =
        customerData!['property_account_position_id'] is List
            ? customerData!['property_account_position_id'][1].toString()
            : '';
    selectedCompanyIndex = customerData!['company_id'] is List
        ? companies.indexWhere((c) => c['id'] == customerData!['company_id'][0])
        : null;
    companyIdController.text = customerData!['company_id'] is List
        ? customerData!['company_id'][1].toString()
        : '';
    referenceController.text = customerData!['ref']?.toString() ?? '';
    companyController.text = customerData!['company_id'] is List
        ? customerData!['company_id'][1].toString()
        : '';
    selectedIndustryIndex = customerData!['industry_id'] is List
        ? industries
            .indexWhere((i) => i['id'] == customerData!['industry_id'][0])
        : null;
    industryController.text = customerData!['industry_id'] is List
        ? customerData!['industry_id'][1].toString()
        : '';
    selectedCustomerLocationIndex =
        customerData!['property_stock_customer'] is List
            ? locations.indexWhere(
                (l) => l['id'] == customerData!['property_stock_customer'][0])
            : null;
    customerLocationController.text =
        customerData!['property_stock_customer'] is List
            ? customerData!['property_stock_customer'][1].toString()
            : 'Partners/Customers';
    selectedVendorLocationIndex =
        customerData!['property_stock_supplier'] is List
            ? locations.indexWhere(
                (l) => l['id'] == customerData!['property_stock_supplier'][0])
            : null;
    vendorLocationController.text =
        customerData!['property_stock_supplier'] is List
            ? customerData!['property_stock_supplier'][1].toString()
            : 'Partners/Vendors';

    selectedPartnerLevelIndex = customerData!['grade_id'] is List
        ? grades.indexWhere((g) => g['id'] == customerData!['grade_id'][0])
        : null;
    partnerLevelController.text = customerData!['grade_id'] is List
        ? customerData!['grade_id'][1].toString()
        : '';
    selectedActivationIndex = customerData!['activation'] is List
        ? activations
            .indexWhere((a) => a['id'] == customerData!['activation'][0])
        : null;
    activationController.text = customerData!['activation'] is List
        ? customerData!['activation'][1].toString()
        : '';
    levelWeightController.text =
        customerData!['partner_weight']?.toString() ?? '0';
    // latestReviewController.text = customerData!['date_review']?.toString() ?? '';
    // nextReviewController.text = customerData!['date_review_next']?.toString() ?? '';
    // partnershipDateController.text = customerData!['date_partnership']?.toString() ?? '';
    latestReviewController.text = (customerData!['date_review'] != null &&
            customerData!['date_review'] != false)
        ? customerData!['date_review'].toString()
        : '';
    nextReviewController.text = (customerData!['date_review_next'] != null &&
            customerData!['date_review_next'] != false)
        ? customerData!['date_review_next'].toString()
        : '';
    partnershipDateController.text =
        (customerData!['date_partnership'] != null &&
                customerData!['date_partnership'] != false)
            ? customerData!['date_partnership'].toString()
            : '';

    selectedWebsiteIndex = customerData!['website'] != null
        ? websites.indexWhere((w) => w['name'] == customerData!['website'])
        : null;
  }

  Future<void> fetchState(int countryId) async {
    final stateResponse = await client!.callKw({
      'model': 'res.country.state',
      'method': 'search_read',
      'args': [
        [
          ['country_id', '=', countryId]
        ] // domain filter
      ],
      'kwargs': {
        'fields': ['id', 'name', 'country_id']
      },
    });
    developer.log("aaaaaaaaaaaaaaaaaaaaaaaaa${countryId}");
    developer.log("cccccccccccccccccccccccc${stateResponse}");

    setState(() {
      states = List<Map<String, dynamic>>.from(stateResponse);
    });
  }

  Future<void> fetchDropdownData() async {
    if (client == null) return;

    try {
      // Countries
      final countryResponse = await client!.callKw({
        'model': 'res.country',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {
          'fields': ['id', 'name']
        },
      });
      setState(
          () => countries = List<Map<String, dynamic>>.from(countryResponse));

      // Users (for salesperson and buyer)
      final userResponse = await client!.callKw({
        'model': 'res.users',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {
          'fields': ['id', 'name']
        },
      });
      setState(() => users = List<Map<String, dynamic>>.from(userResponse));

      // Teams
      final teamResponse = await client!.callKw({
        'model': 'crm.team',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {
          'fields': ['id', 'name']
        },
      });
      setState(() => teams = List<Map<String, dynamic>>.from(teamResponse));

      // Payment Terms
      final paymentResponse = await client!.callKw({
        'model': 'account.payment.term',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {
          'fields': ['id', 'name']
        },
      });
      setState(() =>
          paymentTerms = List<Map<String, dynamic>>.from(paymentResponse));

      // Partners
      final partnerResponse = await client!.callKw({
        'model': 'res.partner',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {
          'fields': ['id', 'name']
        },
      });
      setState(
          () => partners = List<Map<String, dynamic>>.from(partnerResponse));

      // Pricelists
      final pricelistResponse = await client!.callKw({
        'model': 'product.pricelist',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {
          'fields': ['id', 'name']
        },
      });
      setState(() =>
          pricelists = List<Map<String, dynamic>>.from(pricelistResponse));

      // Delivery Carriers
      final carrierResponse = await client!.callKw({
        'model': 'delivery.carrier',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {
          'fields': ['id', 'name']
        },
      });
      setState(() =>
          deliveryCarriers = List<Map<String, dynamic>>.from(carrierResponse));

      // Payment Methods
      final paymentMethodResponse = await client!.callKw({
        'model': 'account.payment.method',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {
          'fields': ['id', 'name']
        },
      });
      setState(() => paymentMethods =
          List<Map<String, dynamic>>.from(paymentMethodResponse));

      // Fiscal Positions
      final fiscalResponse = await client!.callKw({
        'model': 'account.fiscal.position',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {
          'fields': ['id', 'name']
        },
      });
      setState(() =>
          fiscalPositions = List<Map<String, dynamic>>.from(fiscalResponse));

      // Companies
      final companyResponse = await client!.callKw({
        'model': 'res.company',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {
          'fields': ['id', 'name']
        },
      });
      setState(
          () => companies = List<Map<String, dynamic>>.from(companyResponse));

      // Industries
      final industryResponse = await client!.callKw({
        'model': 'res.partner.industry',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {
          'fields': ['id', 'name']
        },
      });
      setState(
          () => industries = List<Map<String, dynamic>>.from(industryResponse));

      // Locations (using complete_name)
      final locationResponse = await client!.callKw({
        'model': 'stock.location',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {
          'fields': ['id', 'complete_name']
        },
      });
      setState(
          () => locations = List<Map<String, dynamic>>.from(locationResponse));

      // Grades
      final gradeResponse = await client!.callKw({
        'model': 'res.partner.grade',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {
          'fields': ['id', 'name']
        },
      });
      setState(() => grades = List<Map<String, dynamic>>.from(gradeResponse));

      // Activations
      final activationResponse = await client!.callKw({
        'model': 'res.partner.activation',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {
          'fields': ['id', 'name']
        },
      });
      setState(() =>
          activations = List<Map<String, dynamic>>.from(activationResponse));

      // Websites (fetching from website model for Sales & Purchase)
      final websiteResponse = await client!.callKw({
        'model': 'website',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {
          'fields': ['id', 'name']
        },
      });
      setState(
          () => websites = List<Map<String, dynamic>>.from(websiteResponse));

      // Update controllers after fetching dropdown data
      if (customerData != null) {
        updateControllers();
      }
    } catch (e) {
      developer.log("Failed to fetch dropdown data: $e");
    }
  }

  Future<void> fetchCategoryData() async {
    if (customerData == null || client == null) return;

    try {
      Set<int> categoryIds = {};
      if (customerData!['category_id'] != null &&
          customerData!['category_id'] is List) {
        final categoryList = customerData!['category_id'] as List;
        for (var category in categoryList) {
          if (category is int) {
            categoryIds.add(category);
          } else if (category is List &&
              category.isNotEmpty &&
              category[0] is int) {
            categoryIds.add(category[0]);
          }
        }
      }

      if (categoryIds.isNotEmpty) {
        final initialResponse = await client!.callKw({
          'model': 'res.partner.category',
          'method': 'search_read',
          'args': [
            [
              ['id', 'in', categoryIds.toList()]
            ]
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
              List<String> pathIds =
                  parentPath.split('/').where((id) => id.isNotEmpty).toList();
              pathIds
                  .forEach((id) => allCategoryIds.add(int.tryParse(id) ?? 0));
            }
          }

          final fullResponse = await client!.callKw({
            'model': 'res.partner.category',
            'method': 'search_read',
            'args': [
              [
                ['id', 'in', allCategoryIds.toList()]
              ]
            ],
            'kwargs': {
              'fields': ['id', 'name', 'parent_path'],
            },
          });

          if (fullResponse != null && mounted) {
            Map<int, String> tempCategoryMap = {
              for (var cat in fullResponse) cat['id']: cat['name']
            };
            setState(() {
              categoryMap = tempCategoryMap;
            });

            for (var category in fullResponse) {
              String parentPath = category['parent_path'] ?? '';
              if (parentPath.isNotEmpty) {
                List<String> pathIds =
                    parentPath.split('/').where((id) => id.isNotEmpty).toList();
                List<String> pathNames = pathIds.map((id) {
                  int catId = int.tryParse(id) ?? 0;
                  return tempCategoryMap[catId] ?? 'Unknown';
                }).toList();
                categoryPathMap[category['id']] = pathNames.join('/');
              } else {
                categoryPathMap[category['id']] = category['name'];
              }
            }
          }
        }
      }
    } catch (e) {
      developer.log("Error fetching categories: $e");
    }
  }

  Future<void> fetchContacts(List<int> contactIds) async {
    if (contactIds.isEmpty || client == null) return;

    try {
      final response = await client!.callKw({
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

      if (response != null && mounted) {
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

      final updateData = {
        'name': nameController.text.isEmpty ? '' : nameController.text,
        'street': streetController.text.isEmpty ? '' : streetController.text,
        'city': cityController.text.isEmpty ? '' : cityController.text,
        'zip': zipController.text.isEmpty ? '' : zipController.text,
        'country_id': selectedCountryIndex != null && selectedCountryIndex! >= 0
            ? countries[selectedCountryIndex!]['id']
            : null,
        'state_id': selectedStateIndex != null && selectedStateIndex! >= 0
            ? states[selectedStateIndex!]['id']
            : null,
        'phone': phoneController.text.isEmpty ? '' : phoneController.text,
        'mobile': mobileController.text.isEmpty ? '' : mobileController.text,
        'email': emailController.text.isEmpty ? '' : emailController.text,
        'website': websiteController.text.isEmpty ? '' : websiteController.text,
        'vat': vatController.text.isEmpty ? '' : vatController.text,
        'is_company': customerData!['is_company'] ?? '',
        'user_id':
            selectedSalespersonIndex != null && selectedSalespersonIndex! >= 0
                ? users[selectedSalespersonIndex!]['id']
                : null,
        'team_id':
            selectedSalesTeamIndex != null && selectedSalesTeamIndex! >= 0
                ? teams[selectedSalesTeamIndex!]['id']
                : null,
        'property_payment_term_id': selectedPaymentTermsSalesIndex != null &&
                selectedPaymentTermsSalesIndex! >= 0
            ? paymentTerms[selectedPaymentTermsSalesIndex!]['id']
            : null,
        'assigned_partner_id': selectedImplementedByIndex != null &&
                selectedImplementedByIndex! >= 0
            ? partners[selectedImplementedByIndex!]['id']
            : null,
        'property_product_pricelist':
            selectedPricelistIndex != null && selectedPricelistIndex! >= 0
                ? pricelists[selectedPricelistIndex!]['id']
                : null,
        'property_delivery_carrier_id': selectedDeliveryMethodIndex != null &&
                selectedDeliveryMethodIndex! >= 0
            ? deliveryCarriers[selectedDeliveryMethodIndex!]['id']
            : null,
        'property_supplier_payment_term_id':
            selectedPaymentTermsPurchaseIndex != null &&
                    selectedPaymentTermsPurchaseIndex! >= 0
                ? paymentTerms[selectedPaymentTermsPurchaseIndex!]['id']
                : null,
        'property_payment_method_id': selectedPaymentMethodIndex != null &&
                selectedPaymentMethodIndex! >= 0
            ? paymentMethods[selectedPaymentMethodIndex!]['id']
            : null,
        'property_account_position_id': selectedFiscalPositionIndex != null &&
                selectedFiscalPositionIndex! >= 0
            ? fiscalPositions[selectedFiscalPositionIndex!]['id']
            : null,
        'company_id': selectedCompanyIndex != null && selectedCompanyIndex! >= 0
            ? companies[selectedCompanyIndex!]['id']
            : null,
        'ref': referenceController.text.isEmpty ? '' : referenceController.text,
        'industry_id':
            selectedIndustryIndex != null && selectedIndustryIndex! >= 0
                ? industries[selectedIndustryIndex!]['id']
                : null,
        'property_stock_customer': selectedCustomerLocationIndex != null &&
                selectedCustomerLocationIndex! >= 0
            ? locations[selectedCustomerLocationIndex!]['id']
            : null,
        'property_stock_supplier': selectedVendorLocationIndex != null &&
                selectedVendorLocationIndex! >= 0
            ? locations[selectedVendorLocationIndex!]['id']
            : null,
        'grade_id':
            selectedPartnerLevelIndex != null && selectedPartnerLevelIndex! >= 0
                ? grades[selectedPartnerLevelIndex!]['id']
                : null,
        'activation':
            selectedActivationIndex != null && selectedActivationIndex! >= 0
                ? activations[selectedActivationIndex!]['id']
                : null,
        'partner_weight': int.tryParse(levelWeightController.text) ?? 0,
        'date_review': latestReviewController.text.isEmpty
            ? null
            : latestReviewController.text,
        'date_review_next': nextReviewController.text.isEmpty
            ? null
            : nextReviewController.text,
        'date_partnership': partnershipDateController.text.isEmpty
            ? null
            : partnershipDateController.text,
      };

      final payload = {
        'model': 'res.partner',
        'method': 'write',
        'args': [
          [widget.customerId],
          updateData,
        ],
        'kwargs': {},
      };

      developer.log("Saving data with payload: $payload");

      await client!.checkSession();
      final response = await client!.callKw(payload);
      developer.log("Write response: $response");

      await fetchCustomerData();
      setState(() => isEditing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(backgroundColor:Color(0xFF9EA700),content: Text('Changes saved successfully')),
      );
    } catch (e) {
      developer.log("Failed to save changes: $e",
          error: e, stackTrace: StackTrace.current);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save changes: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  // Date picker helper method
  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? initialDate;
    try {
      initialDate = DateTime.parse(controller.text);
    } catch (e) {
      initialDate = DateTime.now();
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && mounted) {
      setState(() {
        controller.text =
            picked.toString().split(' ')[0]; // Format as YYYY-MM-DD
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text('Customer Details',style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF9EA700),
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
          ? Center(
        child: LoadingAnimationWidget.fourRotatingDots(
          color: Color(0xFF9EA700),
          size: 100,
        ),
      )
          : customerData == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('No customer data available'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => fetchCustomerData(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCustomerHeader(),
                      _buildAddressSection(),
                      _buildContactInfoSection(),
                      _buildTabBar(),
                      if (selectedTab == 'Contacts & Addresses')
                        _buildContactCards(),
                      if (selectedTab == 'Sales & Purchase')
                        _buildSalesAndPurchaseSection(),
                      if (selectedTab == 'Partner Assignment')
                        _buildPartnerAssignmentSection(),
                    ],
                  ),
                ),
    );
  }

  Widget _buildCustomerHeader() {
    final bool isCompany = customerData!['is_company'] == true;
    String customerType = isCompany ? 'company' : 'individual';

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
                    onChanged: isEditing
                        ? (value) {
                            setState(() {
                              customerType = value!; // Update local display
                              customerData!['is_company'] =
                                  false; // Update data to save
                            });
                          }
                        : null, // Disable when not editing
                  ),
                  const Text('Individual'),
                  const SizedBox(width: 16),
                  Radio<String>(
                    value: 'company',
                    groupValue: customerType,
                    onChanged: isEditing
                        ? (value) {
                            setState(() {
                              customerType = value!; // Update local display
                              customerData!['is_company'] =
                                  true; // Update data to save
                            });
                          }
                        : null, // Disable when not editing
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
            child:
                customerImageBase64 != null && customerImageBase64!.isNotEmpty
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
                    ? TextField(
                        controller: streetController,
                        decoration: const InputDecoration(labelText: 'Street'),
                      )
                    : Text(customerData!['street']?.toString() ?? ''),
                isEditing
                    ? TextField(
                        controller: cityController,
                        decoration: const InputDecoration(labelText: 'City'),
                      )
                    : Text(customerData!['city']?.toString() ?? ''),
                isEditing && states.isNotEmpty
                    ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField<int>(
                          value: selectedStateIndex,
                          decoration: const InputDecoration(
                            labelText: 'State',
                            border: OutlineInputBorder(),
                          ),
                          items: states

                              .map((state) => DropdownMenuItem<int>(
                                    value: states.indexOf(state),
                                    child: Text(state['name']),
                                  ))
                              .toList(),
                          onChanged: (value) =>
                              setState(() => selectedStateIndex = value),
                          isExpanded: true,
                        ),
                      )
                    : Text(customerData!['state_id'] is List &&
                            customerData!['state_id'].length > 1
                        ? customerData!['state_id'][1].toString()
                        : ''),
                isEditing
                    ? TextField(
                        controller: zipController,
                        decoration: const InputDecoration(labelText: 'Zip'),
                      )
                    : Text(customerData!['zip']?.toString() ?? ''),
                isEditing && countries.isNotEmpty
                    ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField<int>(
                          value: selectedCountryIndex,
                          decoration: const InputDecoration(
                            labelText: 'Country',
                            border: OutlineInputBorder(),
                          ),
                          items: countries
                              .map((country) => DropdownMenuItem<int>(
                                    value: countries.indexOf(country),
                                    child: Text(country['name']),
                                  ))
                              .toList(),
                          onChanged: (value) => setState(() {
                            selectedCountryIndex = value;
                            int actualCountryId = countries[selectedCountryIndex!]['id'];
                            developer.log("Selected country ID: $actualCountryId");
                            fetchState(actualCountryId);
                          }),
                          isExpanded: true,
                        ),
                      )
                    : Text(customerData!['country_id'] is List &&
                            customerData!['country_id'].length > 1
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
                    Text('Tax ID',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 4),
                  ],
                ),
                const SizedBox(height: 4),
                isEditing
                    ? TextField(
                        controller: vatController,
                        decoration: const InputDecoration(labelText: 'Tax ID'),
                      )
                    : Text(customerData!['vat']?.toString() ?? 'N/A'),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Phone', phoneController,
                    customerData!['phone']?.toString() ?? '',
                    hasIcon: true, isLink: true),
                _buildInfoRow('Mobile', mobileController,
                    customerData!['mobile']?.toString() ?? '',
                    hasIcon: true),
                _buildInfoRow('Email', emailController,
                    customerData!['email']?.toString() ?? '',
                    hasIcon: true, isLink: true),
                _buildInfoRow('Website', websiteController,
                    customerData!['website']?.toString() ?? '',
                    hasIcon: true, isLink: true),
                _buildTagsRow(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
      String label, TextEditingController controller, String value,
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
                Text(label,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                if (hasIcon) const Padding(padding: EdgeInsets.only(left: 4)),
              ],
            ),
          ),
          Expanded(
            child: isEditing
                ? TextField(
                    controller: controller,
                    decoration: InputDecoration(labelText: label),
                  )
                : Text(
                    value,
                    style: TextStyle(
                        color: isLink ? const Color(0xFF9EA700) : Colors.black),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagsRow() {
    List<String> categoryPaths = [];
    if (customerData!['category_id'] != null &&
        customerData!['category_id'] is List) {
      final categoryList = customerData!['category_id'] as List;
      for (var category in categoryList) {
        int categoryId = category is int
            ? category
            : (category is List && category.isNotEmpty ? category[0] : null);
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
                  ? categoryPaths
                      .take(2)
                      .map((path) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
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
                          ))
                      .toList()
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
            _buildTabItem('Contacts & Addresses',
                isSelected: selectedTab == 'Contacts & Addresses'),
            _buildTabItem('Sales & Purchase',
                isSelected: selectedTab == 'Sales & Purchase'),
            // _buildTabItem('Invoicing'),
            // _buildTabItem('Internal Notes'),
            _buildTabItem('Partner Assignment',
                isSelected: selectedTab == 'Partner Assignment'),
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

  Widget _buildContactCard(String? contactImageBase64, String name,
      String position, String email, String phone) {
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
      if (field == false) {
        return 'N/A';
      }
      if (field is List && field.length > 1) {
        return field[1].toString();
      }
      return field?.toString() ?? defaultValue;
    }

    String salesperson = _getDisplayName(customerData!['user_id']);
    String salesTeam = _getDisplayName(customerData!['team_id']);
    String paymentTermsSales =
        _getDisplayName(customerData!['property_payment_term_id']);
    String implementedBy =
        _getDisplayName(customerData!['assigned_partner_id'], defaultValue: '');
    String pricelist =
        _getDisplayName(customerData!['property_product_pricelist']);
    String deliveryMethod =
        _getDisplayName(customerData!['property_delivery_carrier_id']);
    String paymentTermsPurchase =
        _getDisplayName(customerData!['property_supplier_payment_term_id']);
    String paymentMethod = _getDisplayName(
        customerData!['property_payment_method_id'],
        defaultValue: '');
    String receiptReminder =
        customerData!['receipt_reminder_email']?.toString() ?? '';
    String fiscalPosition =
        _getDisplayName(customerData!['property_account_position_id']);
    String companyId = _getDisplayName(customerData!['company_id']);
    String reference = _getDisplayName(customerData!['ref']);
    String company = _getDisplayName(customerData!['company_id']);
    String website = customerData!['website']?.toString() ?? '';
    String industry = _getDisplayName(customerData!['industry_id']);
    String customerLocation = _getDisplayName(
        customerData!['property_stock_customer'],
        defaultValue: 'Partners/Customers');
    String vendorLocation = _getDisplayName(
        customerData!['property_stock_supplier'],
        defaultValue: 'Partners/Vendors');

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
                border: Border.all(color: Colors.grey.shade300),
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
            isEditing && users.isNotEmpty
                ? _buildDropdownRow(
                    'Salesperson',
                    users,
                    selectedSalespersonIndex,
                    (value) => selectedSalespersonIndex = value)
                : _buildSalesPurchaseRow('Salesperson', salesperson),
            const SizedBox(height: 16),
            isEditing && teams.isNotEmpty
                ? _buildDropdownRow('Sales Team', teams, selectedSalesTeamIndex,
                    (value) => selectedSalesTeamIndex = value)
                : _buildSalesPurchaseRow('Sales Team', salesTeam),
            const SizedBox(height: 16),
            isEditing && paymentTerms.isNotEmpty
                ? _buildDropdownRow(
                    'PAYMENT TERMS',
                    paymentTerms,
                    selectedPaymentTermsSalesIndex,
                    (value) => selectedPaymentTermsSalesIndex = value)
                : _buildSalesPurchaseRow('PAYMENT TERMS', paymentTermsSales),
            const SizedBox(height: 16),
            isEditing && partners.isNotEmpty
                ? _buildDropdownRow(
                    'IMPLEMENTED BY',
                    partners,
                    selectedImplementedByIndex,
                    (value) => selectedImplementedByIndex = value,
                    isHighlighted: true)
                : _buildSalesPurchaseRow('IMPLEMENTED BY', implementedBy,
                    isHighlighted: true),
            const SizedBox(height: 16),
            isEditing && pricelists.isNotEmpty
                ? _buildDropdownRow(
                    'PRICELIST',
                    pricelists,
                    selectedPricelistIndex,
                    (value) => selectedPricelistIndex = value)
                : _buildSalesPurchaseRow('PRICELIST', pricelist),
            const SizedBox(height: 16),
            isEditing && deliveryCarriers.isNotEmpty
                ? _buildDropdownRow(
                    'DELIVERY METHOD',
                    deliveryCarriers,
                    selectedDeliveryMethodIndex,
                    (value) => selectedDeliveryMethodIndex = value,
                    isHighlighted: true)
                : _buildSalesPurchaseRow('DELIVERY METHOD', deliveryMethod,
                    isHighlighted: true),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
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
            isEditing && paymentTerms.isNotEmpty
                ? _buildDropdownRow(
                    'Payment Terms',
                    paymentTerms,
                    selectedPaymentTermsPurchaseIndex,
                    (value) => selectedPaymentTermsPurchaseIndex = value)
                : _buildSalesPurchaseRow('Payment Terms', paymentTermsPurchase),
            const SizedBox(height: 16),
            isEditing && paymentMethods.isNotEmpty
                ? _buildDropdownRow(
                    'PAYMENT METHOD',
                    paymentMethods,
                    selectedPaymentMethodIndex,
                    (value) => selectedPaymentMethodIndex = value)
                : _buildSalesPurchaseRow('PAYMENT METHOD', paymentMethod),
            const SizedBox(height: 16),
            _buildSalesPurchaseRowWithIcon(
                'Receipt Reminder', receiptReminder, true),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
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
            isEditing && fiscalPositions.isNotEmpty
                ? _buildDropdownRow(
                    'Fiscal Position',
                    fiscalPositions,
                    selectedFiscalPositionIndex,
                    (value) => selectedFiscalPositionIndex = value)
                : _buildSalesPurchaseRow('Fiscal Position', fiscalPosition),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
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
            isEditing
                ? _buildEditableRow('COMPANY ID', companyIdController)
                : _buildSalesPurchaseRow('COMPANY ID', companyId),
            const SizedBox(height: 16),
            isEditing
                ? _buildEditableRow('Reference', referenceController)
                : _buildSalesPurchaseRow('Reference', reference),
            const SizedBox(height: 16),
            isEditing && companies.isNotEmpty
                ? _buildDropdownRow('COMPANY', companies, selectedCompanyIndex,
                    (value) => selectedCompanyIndex = value)
                : _buildSalesPurchaseRow('COMPANY', company),
            const SizedBox(height: 16),
            isEditing && websites.isNotEmpty
                ? _buildDropdownRow('Website', websites, selectedWebsiteIndex,
                    (value) {
                    setState(() {
                      selectedWebsiteIndex = value;
                      websiteController.text = value != null && value >= 0
                          ? websites[value]['name']
                          : '';
                    });
                  })
                : _buildSalesPurchaseRow('Website', website),
            const SizedBox(height: 16),
            isEditing && industries.isNotEmpty
                ? _buildDropdownRow(
                    'Industry',
                    industries,
                    selectedIndustryIndex,
                    (value) => selectedIndustryIndex = value)
                : _buildSalesPurchaseRow('Industry', industry),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
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
            isEditing && locations.isNotEmpty
                ? _buildDropdownRow(
                    'CUSTOMER LOCATION',
                    locations,
                    selectedCustomerLocationIndex,
                    (value) => selectedCustomerLocationIndex = value)
                : _buildSalesPurchaseRow('CUSTOMER LOCATION', customerLocation),
            const SizedBox(height: 16),
            isEditing && locations.isNotEmpty
                ? _buildDropdownRow(
                    'VENDOR LOCATION',
                    locations,
                    selectedVendorLocationIndex,
                    (value) => selectedVendorLocationIndex = value)
                : _buildSalesPurchaseRow('VENDOR LOCATION', vendorLocation),
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
    String levelWeight =
        _getDisplayName(customerData!['partner_weight'], defaultValue: '0');
    String latestPartnerReview = _getDisplayName(customerData!['date_review']);
    String nextPartnerReview =
        _getDisplayName(customerData!['date_review_next']);
    String partnershipDate = _getDisplayName(customerData!['date_partnership']);
    String latitude = _getDisplayName(customerData!['date_localization'],
        defaultValue: '0.00000000');
    String longitude = _getDisplayName(customerData!['date_localization'],
        defaultValue: '0.00000000');

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
                border: Border.all(color: Colors.grey.shade300),
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
            isEditing && grades.isNotEmpty
                ? _buildDropdownRow(
                    'Partner Level',
                    grades,
                    selectedPartnerLevelIndex,
                    (value) => selectedPartnerLevelIndex = value)
                : _buildSalesPurchaseRow('Partner Level', partnerLevel),
            const SizedBox(height: 16),
            isEditing && activations.isNotEmpty
                ? _buildDropdownRow(
                    'Activation',
                    activations,
                    selectedActivationIndex,
                    (value) => selectedActivationIndex = value)
                : _buildSalesPurchaseRow('Activation', activation),
            const SizedBox(height: 16),
            isEditing
                ? _buildEditableRow('Level Weight', levelWeightController)
                : _buildSalesPurchaseRow('Level Weight', levelWeight),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
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
            isEditing
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            'Latest Partner Review',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: latestReviewController,
                            decoration: const InputDecoration(
                              labelText: 'Latest Partner Review',
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            readOnly: true,
                            onTap: () =>
                                _selectDate(context, latestReviewController),
                          ),
                        ),
                      ],
                    ),
                  )
                : _buildSalesPurchaseRow(
                    'Latest Partner Review', latestPartnerReview),
            const SizedBox(height: 16),
            isEditing
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            'Next Partner Review',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: nextReviewController,
                            decoration: const InputDecoration(
                              labelText: 'Next Partner Review',
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            readOnly: true,
                            onTap: () =>
                                _selectDate(context, nextReviewController),
                          ),
                        ),
                      ],
                    ),
                  )
                : _buildSalesPurchaseRow(
                    'Next Partner Review', nextPartnerReview),
            const SizedBox(height: 16),
            isEditing
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            'Partnership Date',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: partnershipDateController,
                            decoration: const InputDecoration(
                              labelText: 'Partnership Date',
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            readOnly: true,
                            onTap: () =>
                                _selectDate(context, partnershipDateController),
                          ),
                        ),
                      ],
                    ),
                  )
                : _buildSalesPurchaseRow('Partnership Date', partnershipDate),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
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
            _buildSalesPurchaseRow(
                'Geo Location', 'Lat: $latitude\nLong: $longitude'),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSalesPurchaseRow(String label, String value,
      {bool isHighlighted = false}) {
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

  Widget _buildEditableRow(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(labelText: label),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownRow(String label, List<Map<String, dynamic>> items,
      int? selectedValue, Function(int?) onChanged,
      {bool isHighlighted = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 300),
              child: DropdownButtonFormField<int>(
                value: selectedValue != null &&
                        selectedValue >= 0 &&
                        selectedValue < items.length
                    ? selectedValue
                    : null,
                decoration: InputDecoration(
                  labelText: label,
                  border: const OutlineInputBorder(),
                ),
                items: items
                    .map((item) => DropdownMenuItem<int>(
                          value: items.indexOf(item),
                          child: Text(
                            item['name'] ?? item['complete_name'] ?? 'Unknown',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                onChanged: onChanged,
                isExpanded: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalesPurchaseRowWithIcon(
      String label, String value, bool hasIcon) {
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

    salespersonController.dispose();
    salesTeamController.dispose();
    paymentTermsSalesController.dispose();
    implementedByController.dispose();
    pricelistController.dispose();
    deliveryMethodController.dispose();
    buyerController.dispose();
    paymentTermsPurchaseController.dispose();
    paymentMethodController.dispose();
    fiscalPositionController.dispose();
    companyIdController.dispose();
    referenceController.dispose();
    companyController.dispose();
    industryController.dispose();
    customerLocationController.dispose();
    vendorLocationController.dispose();

    partnerLevelController.dispose();
    activationController.dispose();
    levelWeightController.dispose();
    latestReviewController.dispose();
    nextReviewController.dispose();
    partnershipDateController.dispose();

    super.dispose();
  }
}
