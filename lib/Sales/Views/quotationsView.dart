import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

class QuotationPage extends StatefulWidget {
  final int quotationId;
  final String customerName;
  final int? partnerId;

  const QuotationPage({Key? key, required this.quotationId,this.customerName="",this.partnerId}) : super(key: key);

  @override
  _QuotationPageState createState() => _QuotationPageState();
}

class _QuotationPageState extends State<QuotationPage> {
  bool isLoading = true;
  Map<String, dynamic> quotationData = {};
  OdooClient? client;
  List<Map<String, dynamic>> newAddress = [];
  int selectedTabIndex = 0;
  bool isEditMode = false;
  List<Map<String, dynamic>> products = [];
  List<Map<String, dynamic>> orderLines = [];
  List<Map<String, dynamic>> optionalOrderLines = [];
  List<String> tagNames = [];
  String? selectedOptionalProductId;
  String? selectedProductId;
  int? selectedSalesPersonId;
  String currentStatus = 'draft';

  late TextEditingController customerController;
  late TextEditingController streetController;
  late TextEditingController cityController;
  late TextEditingController invoiceAddressController;
  late TextEditingController deliveryAddressController;
  late TextEditingController expirationController;
  late TextEditingController quotationDateController;
  late TextEditingController salespersonController;

  List<Map<String, dynamic>> partners = [];
  List<Map<String, dynamic>> countries = [];
  List<Map<String, dynamic>> pricelists = [];
  List<Map<String, dynamic>> paymentTerms = [];
  List<Map<String, dynamic>> salesTeams = [];
  List<Map<String, dynamic>> companies = [];
  List<Map<String, dynamic>> fiscalPos = [];
  List<Map<String, dynamic>> accJournal = [];
  List<Map<String, dynamic>> incoT = [];
  List<Map<String, dynamic>> oppor = [];
  List<Map<String, dynamic>> campaigns = [];
  List<Map<String, dynamic>> mediums = [];
  List<Map<String, dynamic>> sources = [];
  List<Map<String, dynamic>> salesP = [];

  @override
  void initState() {
    super.initState();
    customerController = TextEditingController();
    streetController = TextEditingController();
    cityController = TextEditingController();
    invoiceAddressController = TextEditingController();
    deliveryAddressController = TextEditingController();
    expirationController = TextEditingController();
    quotationDateController = TextEditingController();
    salespersonController = TextEditingController();
    if(widget.customerName!=''){
      customerController.text=widget.customerName;
    }
    initializeOdooClient();
  }

  @override
  void dispose() {
    client?.close();
    customerController.dispose();
    streetController.dispose();
    cityController.dispose();
    invoiceAddressController.dispose();
    deliveryAddressController.dispose();
    expirationController.dispose();
    quotationDateController.dispose();
    salespersonController.dispose();
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
        await fetchQuotationDetails();
        await fetchOrderLines();
        await addressFetch();
        await fetchProducts();
        await fetchOptionalProducts();
        await fetchDropdownData();
        _updateControllers();
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

  Future<void> fetchDropdownData() async {
    try {
      final partnerResponse = await client!.callKw({
        'model': 'res.partner',
        'method': 'search_read',
        'args': [],
        'kwargs': {'fields': ['id', 'name'], 'limit': 100},
      });
      setState(() {
        partners = List<Map<String, dynamic>>.from(partnerResponse);
      });

      final salesper = await client!.callKw({
        'model': 'res.users',
        'method': 'search_read',
        'args': [],
        'kwargs': {'fields': ['id', 'name']},
      });
      setState(() {
        salesP = List<Map<String, dynamic>>.from(salesper);
      });

      final countryResponse = await client!.callKw({
        'model': 'res.country',
        'method': 'search_read',
        'args': [],
        'kwargs': {'fields': ['id', 'name']},
      });
      setState(() {
        countries = List<Map<String, dynamic>>.from(countryResponse);
      });

      final pricelistResponse = await client!.callKw({
        'model': 'product.pricelist',
        'method': 'search_read',
        'args': [],
        'kwargs': {'fields': ['id', 'name']},
      });
      setState(() {
        pricelists = List<Map<String, dynamic>>.from(pricelistResponse);
      });

      final paymentTermResponse = await client!.callKw({
        'model': 'account.payment.term',
        'method': 'search_read',
        'args': [],
        'kwargs': {'fields': ['id', 'name']},
      });
      setState(() {
        paymentTerms = List<Map<String, dynamic>>.from(paymentTermResponse);
      });

      final accountJournal = await client!.callKw({
        'model': 'account.journal',
        'method': 'search_read',
        'args': [],
        'kwargs': {'fields': ['id', 'name']},
      });
      setState(() {
        accJournal = List<Map<String, dynamic>>.from(accountJournal);
      });

      final salesTeamResponse = await client!.callKw({
        'model': 'crm.team',
        'method': 'search_read',
        'args': [],
        'kwargs': {'fields': ['id', 'name']},
      });
      setState(() {
        salesTeams = List<Map<String, dynamic>>.from(salesTeamResponse);
      });

      final fiscalPosition = await client!.callKw({
        'model': 'account.fiscal.position',
        'method': 'search_read',
        'args': [],
        'kwargs': {'fields': ['id', 'name']},
      });
      setState(() {
        fiscalPos = List<Map<String, dynamic>>.from(fiscalPosition);
      });

      final incoTerm = await client!.callKw({
        'model': 'account.incoterms',
        'method': 'search_read',
        'args': [],
        'kwargs': {'fields': ['id', 'name']},
      });
      setState(() {
        incoT = List<Map<String, dynamic>>.from(incoTerm);
      });

      final opportunity = await client!.callKw({
        'model': 'crm.lead',
        'method': 'search_read',
        'args': [],
        'kwargs': {'fields': ['id', 'name']},
      });
      setState(() {
        oppor = List<Map<String, dynamic>>.from(opportunity);
      });

      final campaign = await client!.callKw({
        'model': 'utm.campaign',
        'method': 'search_read',
        'args': [],
        'kwargs': {'fields': ['id', 'name']},
      });
      setState(() {
        campaigns = List<Map<String, dynamic>>.from(campaign);
      });

      final medium = await client!.callKw({
        'model': 'utm.medium',
        'method': 'search_read',
        'args': [],
        'kwargs': {'fields': ['id', 'name']},
      });
      setState(() {
        mediums = List<Map<String, dynamic>>.from(medium);
      });

      final source = await client!.callKw({
        'model': 'utm.source',
        'method': 'search_read',
        'args': [],
        'kwargs': {'fields': ['id', 'name']},
      });
      setState(() {
        sources = List<Map<String, dynamic>>.from(source);
      });

      final companyResponse = await client!.callKw({
        'model': 'res.company',
        'method': 'search_read',
        'args': [],
        'kwargs': {'fields': ['id', 'name']},
      });
      setState(() {
        companies = List<Map<String, dynamic>>.from(companyResponse);
      });
    } catch (e) {
      print("Error fetching dropdown data: $e");
    }
  }

  void _updateControllers() {
 if(widget.customerName==''){
   customerController.text = quotationData['partner_id'] is List && quotationData['partner_id'].length > 1
       ? quotationData['partner_id'][1] as String
       : '';
 }
    streetController.text = newAddress.isNotEmpty ? _toString(newAddress[0]['street']) : '';
    cityController.text = newAddress.isNotEmpty ? _toString(newAddress[0]['city']) : '';
    invoiceAddressController.text = quotationData['partner_invoice_id'] is List && quotationData['partner_invoice_id'].length > 1
        ? quotationData['partner_invoice_id'][1] as String
        : '';
    deliveryAddressController.text = quotationData['partner_shipping_id'] is List && quotationData['partner_shipping_id'].length > 1
        ? quotationData['partner_shipping_id'][1] as String
        : '';
    expirationController.text = _toString(quotationData['validity_date']);
    quotationDateController.text = _toString(quotationData['date_order']);
    salespersonController.text = quotationData['user_id'] is List && quotationData['user_id'].length > 1
        ? quotationData['user_id'][1] as String
        : '';
    setState(() {});
  }

  Future<void> saveChanges() async {
    if (client == null) return;
    setState(() => isLoading = true);
    try {
      int? getIdFromList(List<Map<String, dynamic>> list, String? name, dynamic existingValue) {
        if (name == null || name.isEmpty) {
          return existingValue is List && existingValue.isNotEmpty ? existingValue[0] as int? : null;
        }
        final item = list.firstWhere(
              (p) => p['name'] == name,
          orElse: () => {'id': existingValue is List ? existingValue[0] : null},
        );
        return item['id'] as int?;
      }

      final updatedData = {
        'partner_id': getIdFromList(partners, customerController.text, quotationData['partner_id']),
        'partner_invoice_id': getIdFromList(partners, invoiceAddressController.text, quotationData['partner_invoice_id']),
        'partner_shipping_id': getIdFromList(partners, deliveryAddressController.text, quotationData['partner_shipping_id']),
        'validity_date': expirationController.text.isNotEmpty ? expirationController.text : false,
        'date_order': quotationDateController.text.isNotEmpty ? quotationDateController.text : false,
        'pricelist_id': getIdFromList(pricelists,
            quotationData['pricelist_id'] is List ? quotationData['pricelist_id'][1] as String? : null,
            quotationData['pricelist_id']),
        'payment_term_id': getIdFromList(paymentTerms,
            quotationData['payment_term_id'] is List ? quotationData['payment_term_id'][1] as String? : null,
            quotationData['payment_term_id']),
        'user_id': selectedSalesPersonId,
        'team_id': getIdFromList(salesTeams,
            quotationData['team_id'] is List ? quotationData['team_id'][1] as String? : null,
            quotationData['team_id']),
        'company_id': getIdFromList(companies,
            quotationData['company_id'] is List ? quotationData['company_id'][1] as String? : null,
            quotationData['company_id']),
        'fiscal_position_id': getIdFromList(fiscalPos,
            quotationData['fiscal_position_id'] is List ? quotationData['fiscal_position_id'][1] as String? : null,
            quotationData['fiscal_position_id']),
        'journal_id': getIdFromList(accJournal,
            quotationData['journal_id'] is List ? quotationData['journal_id'][1] as String? : null,
            quotationData['journal_id']),
        'incoterm': getIdFromList(incoT,
            quotationData['incoterm'] is List ? quotationData['incoterm'][1] as String? : null,
            quotationData['incoterm']),
        'picking_policy': quotationData['picking_policy'] ?? 'direct',
        'opportunity_id': getIdFromList(oppor,
            quotationData['opportunity_id'] is List ? quotationData['opportunity_id'][1] as String? : null,
            quotationData['opportunity_id']),
        'campaign_id': getIdFromList(campaigns,
            quotationData['campaign_id'] is List ? quotationData['campaign_id'][1] as String? : null,
            quotationData['campaign_id']),
        'medium_id': getIdFromList(mediums,
            quotationData['medium_id'] is List ? quotationData['medium_id'][1] as String? : null,
            quotationData['medium_id']),
        'source_id': getIdFromList(sources,
            quotationData['source_id'] is List ? quotationData['source_id'][1] as String? : null,
            quotationData['source_id']),
      };

      final cleanedData = updatedData.map((key, value) => MapEntry(key, value ?? false));

      print("Saving data to Odoo: $cleanedData");

      await client!.callKw({
        'model': 'sale.order',
        'method': 'write',
        'args': [
          [widget.quotationId],
          cleanedData,
        ],
        'kwargs': {},
      });

      await fetchQuotationDetails();
      await addressFetch();
      _updateControllers();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Changes saved successfully')),
        );
      }
    } catch (e) {
      log("Error saving changes: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving changes: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> fetchTagNames() async {
    if (client == null || quotationData['tag_ids'] == null || quotationData['tag_ids'].isEmpty) return;
    try {
      final response = await client!.callKw({
        'model': 'crm.tag',
        'method': 'search_read',
        'args': [
          [
            ['id', 'in', quotationData['tag_ids']]
          ]
        ],
        'kwargs': {
          'fields': ['name'],
        },
      });
      if (response is List && mounted) {
        setState(() {
          tagNames = List<Map<String, dynamic>>.from(response).map((tag) => tag['name'] as String).toList();
        });
      }
    } catch (e) {
      print("Error fetching tag names: $e");
    }
  }

  Future<void> addressFetch() async {
    try {
      final partnerId = quotationData['partner_id'] is List ? quotationData['partner_id'][0] : false;
      final response = await client!.callKw({
        'model': 'res.partner',
        'method': 'search_read',
        'args': [
          [
            ['id', '=', partnerId]
          ]
        ],
        'kwargs': {
          'fields': ['street', 'street2', 'city', 'state_id', 'zip', 'country_id', 'id']
        },
      });
      if (response is List) {
        setState(() {
          newAddress = List<Map<String, dynamic>>.from(response);
          _updateControllers();
        });
      }
    } catch (e) {
      print("Error fetching address: $e");
    }
  }

  Future<void> fetchQuotationDetails() async {
    if (client == null) return;
    try {
      final response = await client!.callKw({
        'model': 'sale.order',
        'method': 'read',
        'args': [
          [widget.quotationId]
        ],
        'kwargs': {
          'fields': [
            'name', 'partner_id', 'date_order', 'validity_date', 'pricelist_id',
            'payment_term_id', 'partner_invoice_id', 'partner_shipping_id', 'order_line',
            'amount_total', 'state', 'user_id', 'team_id', 'company_id', 'shipping_weight',
            'source_id', 'require_signature', 'require_payment', 'fiscal_position_id', 'journal_id',
            'invoice_status', 'tag_ids', 'incoterm', 'picking_policy', 'commitment_date', 'delivery_status',
            'origin', 'opportunity_id', 'campaign_id', 'medium_id', 'source_id',
          ],
        },
      });
      if (response is List && response.isNotEmpty && mounted) {
        setState(() {
          quotationData = response[0];
          selectedSalesPersonId = quotationData['user_id'] is List && quotationData['user_id'].isNotEmpty
              ? quotationData['user_id'][0] as int?
              : null;
          isLoading = false;
        });
        await fetchTagNames();
        await addressFetch();
        _updateControllers();
      }
    } catch (e) {
      print("Error fetching quotation details: $e");
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> fetchOrderLines() async {
    if (client == null || quotationData['order_line'] == null) return;
    try {
      final response = await client!.callKw({
        'model': 'sale.order.line',
        'method': 'read',
        'args': [quotationData['order_line']],
        'kwargs': {
          'fields': [
            'product_id', 'name', 'product_uom_qty', 'product_uom', 'product_packaging_qty',
            'product_packaging_id', 'price_unit', 'tax_id', 'price_subtotal'
          ],
        },
      });
      if (response is List && mounted) {
        setState(() {
          orderLines = List<Map<String, dynamic>>.from(response);
        });
      }
    } catch (e) {
      print("Error fetching order lines: $e");
    }
  }

  Future<void> fetchProducts() async {
    try {
      final response = await client!.callKw({
        'model': 'product.product',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'fields': ['name', 'id', 'default_code'],
          'limit': 50,
        },
      });
      if (response is List) {
        setState(() {
          products = List<Map<String, dynamic>>.from(response);
        });
      }
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  Future<void> fetchOptionalProducts() async {
    try {
      final response = await client!.callKw({
        'model': 'sale.order.option',
        'method': 'search_read',
        'args': [
          [
            ['order_id', '=', widget.quotationId]
          ]
        ],
        'kwargs': {
          'fields': [
            'product_id', 'name', 'quantity', 'uom_id', 'price_unit', 'discount'
          ],
        },
      });
      if (response is List && mounted) {
        setState(() {
          optionalOrderLines = List<Map<String, dynamic>>.from(response);
        });
      }
    } catch (e) {
      print("Error fetching optional products: $e");
    }
  }

  Future<void> addOptionalProduct(String productId) async {
    if (client == null) return;
    try {
      final product = products.firstWhere((p) => p['id'].toString() == productId, orElse: () => {});
      if (product.isEmpty) return;

      await client!.callKw({
        'model': 'sale.order.option',
        'method': 'create',
        'args': [
          {
            'order_id': widget.quotationId,
            'product_id': int.parse(productId),
            'name': product['name'],
            'quantity': 1.0,
            'price_unit': 0.0,
            'discount': 0.0,
          }
        ],
        'kwargs': {},
      });

      await fetchOptionalProducts();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Optional product added successfully')),
      );
    } catch (e) {
      print("Error adding optional product: $e");
    }
  }

  Future<void> addProductToOrderLine(String productId) async {
    if (client == null) return;
    try {
      await client!.callKw({
        'model': 'sale.order.line',
        'method': 'create',
        'args': [
          {
            'order_id': widget.quotationId,
            'product_id': int.parse(productId),
            'product_uom_qty': 1.0,
            'price_unit': 0.0,
          }
        ],
        'kwargs': {},
      });
      await fetchOrderLines();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added successfully')),
      );
    } catch (e) {
      print("Error adding product to order line: $e");
    }
  }

  Future<void> deleteOrderLine(int lineId) async {
    if (client == null) return;
    try {
      await client!.callKw({
        'model': 'sale.order.line',
        'method': 'unlink',
        'args': [
          [lineId]
        ],
        'kwargs': {},
      });
      await fetchOrderLines();
    } catch (e) {
      print("Error deleting order line: $e");
    }
  }

  void switchTab(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  void toggleEditMode() async {
    if (isEditMode) {
      await saveChanges();
      if (selectedProductId != null) {
        await addProductToOrderLine(selectedProductId!);
        setState(() => selectedProductId = null);
      }
      if (selectedOptionalProductId != null) {
        await addOptionalProduct(selectedOptionalProductId!);
        setState(() => selectedOptionalProductId = null);
      }
      await fetchQuotationDetails();
      await fetchOrderLines();
      await addressFetch();
      _updateControllers();
    }
    setState(() {
      isEditMode = !isEditMode;
    });
  }

  String _toString(dynamic value, {String defaultValue = 'N/A'}) {
    if (value == null || value == false) return defaultValue;
    if (value is String) return value;
    if (value is bool) return value ? 'Yes' : 'No';
    if (value is num) return value.toString();
    if (value is List && value.isNotEmpty) return value[1].toString();
    return defaultValue;
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  // Future<void> sendQuotationEmail(int saleId, BuildContext context) async {
  //   try {
  //     setState(() => isLoading = true);
  //
  //     final quotationResponse = await client?.callKw({
  //       'model': 'sale.order',
  //       'method': 'action_quotation_send',
  //       'args': [
  //         [saleId]
  //       ],
  //       'kwargs': {
  //         'context': {
  //           'validate_analytic': true,
  //         },
  //       },
  //     });
  //
  //     final contextData = quotationResponse['context'];
  //     int? templateId = contextData?['default_template_id'];
  //
  //     if (templateId == null) {
  //       print("No default template ID found for Sale Order ID: $saleId");
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('No email template found for this quotation')),
  //       );
  //       return;
  //     }
  //
  //     final saleOrder = await client?.callKw({
  //       'model': 'sale.order',
  //       'method': 'read',
  //       'args': [
  //         [saleId]
  //       ],
  //       'kwargs': {
  //         'fields': [
  //           'partner_id',
  //           'state',
  //         ],
  //       },
  //     });
  //
  //     if (saleOrder.isEmpty || saleOrder[0]['partner_id'] == null) {
  //       print("❌ No customer found for Sale Order ID: $saleId");
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('No customer found for this quotation')),
  //       );
  //       return;
  //     }
  //
  //     int partnerId = saleOrder[0]['partner_id'][0] as int;
  //     String currentStatus = saleOrder[0]['state'] as String;
  //
  //     final mailComposeResponse = await client?.callKw({
  //       'model': 'mail.compose.message',
  //       'method': 'create',
  //       'args': [
  //         {
  //           'model': 'sale.order',
  //           'res_ids': [saleId],
  //           'template_id': templateId,
  //           'composition_mode': 'comment',
  //           'force_send': true,
  //           'email_layout_xmlid': 'mail.mail_notification_layout_with_responsible_signature',
  //           'partner_ids': [partnerId],
  //         }
  //       ],
  //       'kwargs': {},
  //     });
  //
  //     int mailComposeId = mailComposeResponse;
  //
  //     final sendMailResponse = await client?.callKw({
  //       'model': 'mail.compose.message',
  //       'method': 'action_send_mail',
  //       'args': [
  //         [mailComposeId]
  //       ],
  //       'kwargs': {},
  //     });
  //
  //     print("Email Sent Successfully: $sendMailResponse");
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Email Sent Successfully'),
  //           backgroundColor:Color(0xFF9EA700),
  //         ),
  //       );
  //     }
  //
  //     if (currentStatus == 'draft') {
  //       await client?.callKw({
  //         'model': 'sale.order',
  //         'method': 'action_quotation_sent',
  //         'args': [
  //           [saleId]
  //         ],
  //         'kwargs': {},
  //       });
  //     }
  //
  //     await fetchQuotationDetails();
  //   } catch (e) {
  //     log("Error sending email: $e");
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Error sending email: $e')),
  //       );
  //     }
  //   } finally {
  //     if (mounted) {
  //       setState(() => isLoading = false);
  //     }
  //   }
  // }

  Future<void> sendQuotationEmail(int saleId, BuildContext context) async {
    try {
      setState(() => isLoading = true);

      // Ensure the quotation exists and is in draft state
      final quotationCheck = await client?.callKw({
        'model': 'sale.order',
        'method': 'read',
        'args': [
          [saleId]
        ],
        'kwargs': {
          'fields': ['state', 'partner_id'],
        },
      });

      if (quotationCheck == null || quotationCheck.isEmpty) {
        throw Exception('Quotation not found');
      }

      String currentState = quotationCheck[0]['state'] as String;
      int partnerId = quotationCheck[0]['partner_id'] is List && quotationCheck[0]['partner_id'].isNotEmpty
          ? quotationCheck[0]['partner_id'][0] as int
          : throw Exception('No customer associated with this quotation');

      if (currentState != 'draft' && currentState != 'sent') {
        throw Exception('Quotation must be in draft or sent state to send an email');
      }

      // Trigger the email sending action
      final quotationResponse = await client?.callKw({
        'model': 'sale.order',
        'method': 'action_quotation_send',
        'args': [
          [saleId]
        ],
        'kwargs': {
          'context': {
            'validate_analytic': true,
          },
        },
      });

      final contextData = quotationResponse['context'];
      int? templateId = contextData?['default_template_id'];

      if (templateId == null) {
        throw Exception('No email template found for this quotation');
      }

      // Create and send the email
      final mailComposeResponse = await client?.callKw({
        'model': 'mail.compose.message',
        'method': 'create',
        'args': [
          {
            'model': 'sale.order',
            'res_ids': [saleId],
            'template_id': templateId,
            'composition_mode': 'comment',
            'force_send': true,
            'email_layout_xmlid': 'mail.mail_notification_layout_with_responsible_signature',
            'partner_ids': [[6, 0, [partnerId]]], // Use partner_id from sale.order
          }
        ],
        'kwargs': {},
      });

      int mailComposeId = mailComposeResponse;

      await client?.callKw({
        'model': 'mail.compose.message',
        'method': 'action_send_mail',
        'args': [
          [mailComposeId]
        ],
        'kwargs': {},
      });

      print("Email Sent Successfully");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email Sent Successfully'),
            backgroundColor: Color(0xFF9EA700),
          ),
        );
      }

      // If the quotation was in draft state, mark it as sent
      if (currentState == 'draft') {
        await client?.callKw({
          'model': 'sale.order',
          'method': 'action_quotation_sent',
          'args': [
            [saleId]
          ],
          'kwargs': {},
        });
      }

      await fetchQuotationDetails();
    } catch (e) {
      log("Error sending email: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sending email: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  List<Widget> _buildActionButtons() {
    final state = _toString(quotationData['state'], defaultValue: 'draft');
    List<Widget> buttons = [];

    if (state == 'draft') {
      buttons.addAll([
        ElevatedButton(
          onPressed: () async {
            if (client != null) {
              await sendQuotationEmail(widget.quotationId, context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Odoo client not initialized')),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF9EA700),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: const Text('SEND BY EMAIL'),
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: () async {
            if (client != null) {
              bool success = await confirmSaleOrder(client!, context);
              if (success) {
                await fetchQuotationDetails(); // Refresh the UI after confirmation
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Odoo client not initialized')),
              );
            }
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),

          ),
          child: const Text('CONFIRM'),
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: () {
            // Add logic for preview
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Preview clicked')),
            );
          },
          style: OutlinedButton.styleFrom(
              foregroundColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('PREVIEW'),
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: () async {
            if (client != null) {
              bool success = await cancelSaleOrder(client!, context);
              if (success) {
                await fetchQuotationDetails(); // Refresh the UI after cancellation
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Odoo client not initialized')),
              );
            }
          },
          style: OutlinedButton.styleFrom(
              foregroundColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('CANCEL'),
        ),
      ]);
    } else if (state == 'sale') {
      buttons.addAll([
        ElevatedButton(
          onPressed: () async {
            // Show dialog for creating invoice
            _showCreateInvoiceDialog(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF9EA700),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: const Text('CREATE INVOICE'),
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: () async {
            if (client != null) {
              await sendQuotationEmail(widget.quotationId, context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Odoo client not initialized')),
              );
            }
          },
          style: OutlinedButton.styleFrom(
              foregroundColor: Colors.grey
          ),
          child: const Text('SEND BY EMAIL'),
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: () {
            // Add logic for preview
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Preview clicked')),
            );
          },
          style: OutlinedButton.styleFrom(
              foregroundColor: Colors.grey
          ),
          child: const Text('PREVIEW'),
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: () async {
            if (client != null) {
              bool success = await cancelSaleOrder(client!, context);
              if (success) {
                await fetchQuotationDetails(); // Refresh the UI after cancellation
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Odoo client not initialized')),
              );
            }
          },
          style: OutlinedButton.styleFrom(
              foregroundColor: Colors.grey
          ),
          child: const Text('CANCEL'),
        ),
      ]);
    } else if (state == 'sent') {
      buttons.addAll([
        ElevatedButton(
          onPressed: () async {
            if (client != null) {
              bool success = await confirmSaleOrder(client!, context);
              if (success) {
                await fetchQuotationDetails(); // Refresh the UI after confirmation
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Odoo client not initialized')),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF9EA700),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: const Text('CONFIRM'),
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: () async {
            if (client != null) {
              await sendQuotationEmail(widget.quotationId, context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Odoo client not initialized')),
              );
            }
          },
          style: OutlinedButton.styleFrom(
              foregroundColor: Colors.grey
          ),
          child: const Text('SEND BY EMAIL'),
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: () {
            // Add logic for preview
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Preview clicked')),
            );
          },
          style: OutlinedButton.styleFrom(
              foregroundColor: Colors.grey
          ),
          child: const Text('PREVIEW'),
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: () async {
            if (client != null) {
              bool success = await cancelSaleOrder(client!, context);
              if (success) {
                await fetchQuotationDetails(); // Refresh the UI after cancellation
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Odoo client not initialized')),
              );
            }
          },
          style: OutlinedButton.styleFrom(
              foregroundColor: Colors.grey
          ),
          child: const Text('CANCEL'),
        ),
      ]);
    } else if (state == 'cancel') {
      buttons.addAll([
        OutlinedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Preview clicked')),
            );
          },
          child: const Text('PREVIEW'),
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: () async {
            if (client != null) {
              bool success = await setToDraft(client!, context);
              if (success) {
                await fetchQuotationDetails();
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Odoo client not initialized')),
              );
            }
          },
          child: const Text('SET TO QUOTATION'),
        ),
      ]);
    }

    buttons.addAll([
      const SizedBox(width: 16),
      Text('Quotation',
          style: TextStyle(
              color: state == 'draft' ? const Color(0xFF9EA700) : Colors.black87,
              fontWeight: state == 'draft' ? FontWeight.bold : FontWeight.normal)),
      const SizedBox(width: 8),
      const Text('>', style: TextStyle(color: Colors.black54)),
      const SizedBox(width: 8),
      Text('Quotation Sent',
          style: TextStyle(
              color: state == 'sent' ? const Color(0xFF9EA700) : Colors.black87,
              fontWeight: state == 'sent' ? FontWeight.bold : FontWeight.normal)),
      const SizedBox(width: 8),
      const Text('>', style: TextStyle(color: Colors.black54)),
      const SizedBox(width: 8),
      Text('Sales Order',
          style: TextStyle(
              color: state == 'sale' ? const Color(0xFF9EA700) : Colors.black87,
              fontWeight: state == 'sale' ? FontWeight.bold : FontWeight.normal)),
    ]);

    return buttons;
  }

  Future<bool> cancelSaleOrder(OdooClient client, BuildContext context) async {
    try {
      final cancelRecordResponse = await client.callKw({
        'model': 'sale.order.cancel',
        'method': 'create',
        'args': [
          {
            'order_id': widget.quotationId,
          }
        ],
        'kwargs': {},
      });

      log(" Sale Order Cancellation Record Created: $cancelRecordResponse");

      await client.callKw({
        'model': 'sale.order.cancel',
        'method': 'action_send_mail_and_cancel',
        'args': [
          [cancelRecordResponse]
        ],
        'kwargs': {},
      });

      final quotaData = await client.callKw({
        'model': 'sale.order',
        'method': 'search_read',
        'args': [
          [
            ['id', '=', widget.quotationId]
          ]
        ],
        'kwargs': {
          'fields': [
            'state',
          ],
        },
      });

      log(quotaData.toString());

      setState(() {
        currentStatus = quotaData[0]['state'];
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Order Cancelled Successfully"),
            backgroundColor: Color(0xFF9EA700),
          ),
        );
      }
      return true;
    } catch (e) {
      log(" Error in Cancel Order: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error cancelling sale order: $e')),
        );
      }
      return false;
    }
  }

  Future<bool> confirmSaleOrder(OdooClient client, BuildContext context) async {
    try {
      final response = await client.callKw({
        'model': 'sale.order',
        'method': 'action_confirm',
        'args': [
          [widget.quotationId]
        ],
        'kwargs': {},
      });

      if (response != null) {
        final quotaData = await client.callKw({
          'model': 'sale.order',
          'method': 'search_read',
          'args': [
            [
              ['id', '=', widget.quotationId]
            ]
          ],
          'kwargs': {
            'fields': [
              'state',
            ],
          },
        });

        log(quotaData.toString());

        setState(() {
          currentStatus = quotaData[0]['state'];
        });
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Sale Order ${widget.quotationId} Confirmed Successfully"),
              backgroundColor: Color(0xFF9EA700),
            ),
          );
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error confirming sale order: $e')),
        );
      }
      return false;
    }
  }
  Future<bool> setToDraft(OdooClient client, BuildContext context) async {
    try {

      final response = await client.callKw({
        'model': 'sale.order',
        'method': 'action_draft',
        'args': [
          [widget.quotationId]
        ],
        'kwargs': {},
      });

      if (response != null) {
        final quotaData = await client.callKw({
          'model': 'sale.order',
          'method': 'search_read',
          'args': [
            [
              ['id', '=', widget.quotationId]
            ]
          ],
          'kwargs': {
            'fields': [
              'state',
            ],
          },
        });

        log(quotaData.toString());

        setState(() {
          currentStatus = quotaData[0]['state'];
        });

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Order ${widget.quotationId} set to Draft Successfully"),
              backgroundColor: Color(0xFF9EA700),
            ),
          );
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(" Error setting order to draft: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error setting order to draft: $e')),
        );
      }
      return false;
    }
  }

  void _showCreateInvoiceDialog(BuildContext context) {
    String? invoiceAction = 'delivered';
    TextEditingController amountController = TextEditingController();
    TextEditingController fixedAmountController = TextEditingController();
    bool showAmountField = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Create Invoice'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '',
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: const Text('Regular Invoice'),
                    leading: Radio<String>(
                      value: 'delivered',
                      groupValue: invoiceAction,
                      onChanged: (value) {
                        setState(() {
                          invoiceAction = value;
                          showAmountField = false;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Down Payment (Percentage)'),
                    leading: Radio<String>(
                      value: 'percentage',
                      groupValue: invoiceAction,
                      onChanged: (value) {
                        setState(() {
                          invoiceAction = value;
                          showAmountField = true;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Down Payment (Fixed Amount)'),
                    leading: Radio<String>(
                      value: 'fixed',
                      groupValue: invoiceAction,
                      onChanged: (value) {
                        setState(() {
                          invoiceAction = value;
                          showAmountField = true;
                        });
                      },
                    ),
                  ),
                  if (showAmountField)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: TextField(
                        controller: invoiceAction == 'percentage' ? amountController : fixedAmountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: invoiceAction == 'percentage' ? 'Enter Percentage' : 'Enter Fixed Amount',
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (client != null) {
                      try {
                        log("Creating invoice wizard...");
                        final wizardId = await client!.callKw({
                          'model': 'sale.advance.payment.inv',
                          'method': 'create',
                          'args': [
                            {
                              'amount': amountController.text.isNotEmpty ? double.parse(amountController.text) : null,
                              'fixed_amount': fixedAmountController.text.isNotEmpty ? double.parse(fixedAmountController.text) : null,
                              'advance_payment_method': invoiceAction,
                              'sale_order_ids': [
                                [6, 0, [widget.quotationId]]
                              ],
                            }
                          ],
                          'kwargs': {}
                        });

                        log("Invoice Wizard Created: ID $wizardId");

                        final invoice = await client!.callKw({
                          'model': 'sale.advance.payment.inv',
                          'method': 'create_invoices',
                          'args': [
                            [wizardId]
                          ],
                          'kwargs': {}
                        });

                        log("Invoice Created Successfully: $invoice");
                        if (context.mounted) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Invoice created successfully'), backgroundColor: Color(0xFF9EA700)),
                          );
                        }
                        await fetchQuotationDetails();
                      } catch (e) {
                        log("Error creating invoice: $e");
                        if (context.mounted) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error creating invoice: $e')),
                          );
                        }
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Odoo client not initialized')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF9EA700), foregroundColor: Colors.white),
                  child: const Text('Create'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF9EA700),
        elevation: 0,
        title: const Text('Quotation Details'),
        actions: [
          IconButton(
            icon: Icon(isEditMode ? Icons.save : Icons.edit),
            onPressed: toggleEditMode,
            color: Colors.black,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF9EA700)))
          : SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _buildActionButtons(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  _toString(quotationData['name'], defaultValue: 'None'),
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildEditableInfoRow(
                      'Customer',
                      customerController,
                      isDropdown: true,
                      items: partners.map((p) => p['name'] as String).toList(),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            streetController.text.isNotEmpty ? streetController.text : 'No Street',
                            style: const TextStyle(color: Colors.black54),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            cityController.text.isNotEmpty ? cityController.text : 'No City',
                            style: const TextStyle(color: Colors.black54),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            newAddress.isNotEmpty && newAddress[0]['country_id'] != null
                                ? _toString(newAddress[0]['country_id'])
                                : 'No Country',
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildEditableInfoRow(
                      'Invoice Address',
                      invoiceAddressController,
                      isDropdown: true,
                      items: partners.map((p) => p['name'] as String).toList(),
                    ),
                    const SizedBox(height: 16),
                    _buildEditableInfoRow(
                      'Delivery Address',
                      deliveryAddressController,
                      isDropdown: true,
                      items: partners.map((p) => p['name'] as String).toList(),
                    ),
                    const SizedBox(height: 16),
                    _buildEditableInfoRow(
                      'Expiration',
                      expirationController,
                      isDate: true,
                      onTap: () => _selectDate(context, expirationController),
                    ),
                    const SizedBox(height: 16),
                    _buildEditableInfoRow(
                      'Quotation Date',
                      quotationDateController,
                      isDate: true,
                      onTap: () => _selectDate(context, quotationDateController),
                    ),
                    const SizedBox(height: 16),
                    _buildEditableInfoRow(
                      'Pricelist',
                      TextEditingController(
                          text: quotationData['pricelist_id'] is List ? quotationData['pricelist_id'][1] as String : ''),
                      isDropdown: true,
                      items: pricelists.map((p) => p['name'] as String).toList(),
                      onDropdownChanged: (value) {
                        if (value != null) {
                          final pricelist = pricelists.firstWhere((p) => p['name'] == value);
                          setState(() {
                            quotationData['pricelist_id'] = [pricelist['id'], pricelist['name']];
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildEditableInfoRow(
                      'Payment Terms',
                      TextEditingController(
                          text: quotationData['payment_term_id'] is List ? quotationData['payment_term_id'][1] as String : ''),
                      isDropdown: true,
                      items: paymentTerms.map((p) => p['name'] as String).toList(),
                      onDropdownChanged: (value) {
                        if (value != null) {
                          final term = paymentTerms.firstWhere((p) => p['name'] == value);
                          setState(() {
                            quotationData['payment_term_id'] = [term['id'], term['name']];
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () => switchTab(0),
                        child: _buildTab('ORDER LINES', isSelected: selectedTabIndex == 0),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () => switchTab(1),
                        child: _buildTab('OPTIONAL PRODUCTS', isSelected: selectedTabIndex == 1),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () => switchTab(2),
                        child: _buildTab('OTHER INFO', isSelected: selectedTabIndex == 2),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () => switchTab(3),
                        child: _buildTab('CUSTOMER SIGNATURE', isSelected: selectedTabIndex == 3),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 400,
                child: IndexedStack(
                  index: selectedTabIndex,
                  children: [
                    _buildOrderLinesTab(),
                    _buildOptionalProductsTab(),
                    _buildOtherInfoTab(),
                    _buildCustomerSignatureTab(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('TOTAL:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    Text(
                      '\$${_toString(quotationData['amount_total'], defaultValue: '0.00')}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderLinesTab() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border(top: BorderSide(color: Colors.grey.shade300), bottom: BorderSide(color: Colors.grey.shade300)),
                ),
                child: Row(
                  children: [
                    _buildTableHeader('PRODUCT', flex: 2),
                    _buildTableHeader('DESCRIPTION', flex: 2),
                    _buildTableHeader('QUANTITY'),
                    _buildTableHeader('UOM'),
                    _buildTableHeader('PACKAGING QUANTITY'),
                    _buildTableHeader('PACKAGING'),
                    _buildTableHeader('UNIT PRICE'),
                    _buildTableHeader('TAXES'),
                    _buildTableHeader('TAX EXCL.'),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              if (orderLines.isNotEmpty)
                ...orderLines.map((line) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(_toString(line['product_id']),
                                style: const TextStyle(fontSize: 14, color: Color(0xFF9EA700)))),
                        Expanded(flex: 2, child: Text(_toString(line['name']), style: const TextStyle(fontSize: 14))),
                        Expanded(
                            child: Text(_toString(line['product_uom_qty'], defaultValue: '0.00'),
                                style: const TextStyle(fontSize: 14))),
                        Expanded(child: Text(_toString(line['product_uom']), style: const TextStyle(fontSize: 14))),
                        Expanded(
                            child: Text(_toString(line['product_packaging_qty'], defaultValue: '0.00'),
                                style: const TextStyle(fontSize: 14))),
                        Expanded(
                            child: Text(_toString(line['product_packaging_id']), style: const TextStyle(fontSize: 14))),
                        Expanded(
                            child: Text(_toString(line['price_unit'], defaultValue: '0.00'),
                                style: const TextStyle(fontSize: 14))),
                        Expanded(
                            child: Text(
                                line['tax_id'] is List
                                    ? line['tax_id'].map((tax) => _toString(tax)).join(', ')
                                    : 'N/A',
                                style: const TextStyle(fontSize: 14))),
                        Expanded(
                            child: Text('\$${_toString(line['price_subtotal'], defaultValue: '0.00')}',
                                style: const TextStyle(fontSize: 14))),
                        SizedBox(
                          width: 48,
                          child: isEditMode
                              ? IconButton(
                            icon: const Icon(Icons.delete, size: 16),
                            onPressed: () => line['id'] != null ? deleteOrderLine(line['id']) : null,
                          )
                              : null,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              if (isEditMode)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: CustomDropdown.search(
                          hintText: 'Add a product',
                          items: products
                              .map((product) => '[${product['default_code'] ?? ''}] ${product['name'] as String}')
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              final selected = products.firstWhere(
                                      (p) => '[${p['default_code'] ?? ''}] ${p['name']}' == value,
                                  orElse: () => {});
                              if (selected.isNotEmpty) {
                                setState(() {
                                  selectedProductId = selected['id'].toString();
                                });
                              }
                            }
                          },
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: const Text('Add a section',
                              style: TextStyle(color: Color(0xFF9EA700), fontWeight: FontWeight.w500))),
                      Expanded(child: Container()),
                      Expanded(child: Container()),
                      Expanded(child: Container()),
                      Expanded(child: Container()),
                      Expanded(child: Container()),
                      Expanded(child: Container()),
                      Expanded(
                          child: const Text('Add a note',
                              style: TextStyle(color: Color(0xFF9EA700), fontWeight: FontWeight.w500))),
                      const Text('Catalog',
                          style: TextStyle(color: Color(0xFF9EA700), fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionalProductsTab() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border(top: BorderSide(color: Colors.grey.shade300), bottom: BorderSide(color: Colors.grey.shade300)),
                ),
                child: Row(
                  children: [
                    _buildTableHeader('PRODUCT', flex: 2),
                    _buildTableHeader('DESCRIPTION', flex: 2),
                    _buildTableHeader('QUANTITY'),
                    _buildTableHeader('UOM'),
                    _buildTableHeader('UNIT PRICE'),
                    _buildTableHeader('DISCOUNT'),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              if (optionalOrderLines.isNotEmpty)
                ...optionalOrderLines.map((line) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(_toString(line['product_id']),
                                style: const TextStyle(fontSize: 14, color: Color(0xFF9EA700)))),
                        Expanded(flex: 2, child: Text(_toString(line['name']), style: const TextStyle(fontSize: 14))),
                        Expanded(
                            child: Text(_toString(line['quantity'], defaultValue: '0.00'),
                                style: const TextStyle(fontSize: 14))),
                        Expanded(child: Text(_toString(line['uom_id']), style: const TextStyle(fontSize: 14))),
                        Expanded(
                            child: Text(_toString(line['price_unit'], defaultValue: '0.00'),
                                style: const TextStyle(fontSize: 14))),
                        Expanded(
                            child: Text('${_toString(line['discount'], defaultValue: '0.00')}%',
                                style: const TextStyle(fontSize: 14))),
                        SizedBox(width: 48, child: isEditMode ? IconButton(icon: const Icon(Icons.delete, size: 16), onPressed: () {}) : null),
                      ],
                    ),
                  );
                }).toList(),
              if (isEditMode)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: CustomDropdown.search(
                          hintText: 'Add an optional product',
                          items: products
                              .map((product) => '[${product['default_code'] ?? ''}] ${product['name'] as String}')
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              final selected = products.firstWhere(
                                      (p) => '[${p['default_code'] ?? ''}] ${p['name']}' == value,
                                  orElse: () => {});
                              if (selected.isNotEmpty) {
                                setState(() {
                                  selectedOptionalProductId = selected['id'].toString();
                                  addOptionalProduct(selectedOptionalProductId!);
                                });
                              }
                            }
                          },
                        ),
                      ),
                      Expanded(flex: 5, child: Container()),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtherInfoTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
              child: const Text('SALES', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
            ),
            const SizedBox(height: 16),
            _buildEditableInfoRow(
              'Salesperson',
              salespersonController,
              isDropdown: isEditMode,
              items: salesP.map((p) => p['name'] as String).toList(),
              onDropdownChanged: (value) {
                if (value != null) {
                  final user = salesP.firstWhere((p) => p['name'] == value);
                  setState(() {
                    quotationData['user_id'] = [user['id'], user['name']];
                    salespersonController.text = user['name'];
                    selectedSalesPersonId = user['id'];
                    log('kalalallalalalalal$selectedSalesPersonId');
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            _buildEditableInfoRow(
              'Sales Team',
              TextEditingController(text: quotationData['team_id'] is List ? quotationData['team_id'][1] as String : ''),
              isDropdown: isEditMode,
              items: salesTeams.map((t) => t['name'] as String).toList(),
              onDropdownChanged: (value) {
                if (value != null) {
                  final team = salesTeams.firstWhere((t) => t['name'] == value);
                  setState(() {
                    quotationData['team_id'] = [team['id'], team['name']];
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            _buildEditableInfoRow(
              'Company',
              TextEditingController(text: quotationData['company_id'] is List ? quotationData['company_id'][1] as String : ''),
              isDropdown: isEditMode,
              items: companies.map((c) => c['name'] as String).toList(),
              onDropdownChanged: (value) {
                if (value != null) {
                  final company = companies.firstWhere((c) => c['name'] == value);
                  setState(() {
                    quotationData['company_id'] = [company['id'], company['name']];
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            _buildInfoRowWithIcon('Online signature', _toString(quotationData['require_signature'])),
            const SizedBox(height: 16),
            _buildInfoRowWithPercentage('Online payment', _toString(quotationData['require_payment'])),
            const SizedBox(height: 16),
            _buildEditableInfoRow(
              'Customer Reference',
              TextEditingController(text: _toString(quotationData['client_order_ref'])),
            ),
            const SizedBox(height: 16),
            _buildInfoRowWithTags('Tags', quotationData['tag_ids'] ?? []),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
              child: const Text('INVOICING', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
            ),
            const SizedBox(height: 16),
            _buildEditableInfoRow(
              'Fiscal Position',
              TextEditingController(
                  text: quotationData['fiscal_position_id'] is List ? quotationData['fiscal_position_id'][1] as String : ''),
              isDropdown: isEditMode,
              items: fiscalPos.map((f) => f['name'] as String).toList(),
              onDropdownChanged: (value) {
                if (value != null) {
                  final fiscal = fiscalPos.firstWhere((f) => f['name'] == value);
                  setState(() {
                    quotationData['fiscal_position_id'] = [fiscal['id'], fiscal['name']];
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            _buildEditableInfoRow(
              'Invoicing Journal',
              TextEditingController(text: quotationData['journal_id'] is List ? quotationData['journal_id'][1] as String : ''),
              isDropdown: isEditMode,
              items: accJournal.map((j) => j['name'] as String).toList(),
              onDropdownChanged: (value) {
                if (value != null) {
                  final journal = accJournal.firstWhere((j) => j['name'] == value);
                  setState(() {
                    quotationData['journal_id'] = [journal['id'], journal['name']];
                  });
                }
              },
            ),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
              child: const Text('DELIVERY', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
            ),
            const SizedBox(height: 16),
            _buildEditableInfoRow(
              'Incoterm',
              TextEditingController(text: quotationData['incoterm'] is List ? quotationData['incoterm'][1] as String : ''),
              isDropdown: isEditMode,
              items: incoT.map((i) => i['name'] as String).toList(),
              onDropdownChanged: (value) {
                if (value != null) {
                  final incoterm = incoT.firstWhere((i) => i['name'] == value);
                  setState(() {
                    quotationData['incoterm'] = [incoterm['id'], incoterm['name']];
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            _buildEditableInfoRow(
              'Incoterm Location',
              TextEditingController(text: _toString(quotationData['incoterm_location'])),
            ),
            const SizedBox(height: 16),
            _buildEditableInfoRow(
              'Shipping Policy',
              TextEditingController(text: _toString(quotationData['picking_policy'])),
              isDropdown: isEditMode,
              items: ['direct', 'one'],
              onDropdownChanged: (value) {
                if (value != null) {
                  setState(() {
                    quotationData['picking_policy'] = value;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            _buildEditableInfoRow(
              'Shipping Weight',
              TextEditingController(text: _toString(quotationData['shipping_weight'], defaultValue: '0.00')),
            ),
            const SizedBox(height: 16),
            _buildEditableInfoRow(
              'Delivery Date',
              TextEditingController(text: _toString(quotationData['commitment_date'])),
              isDate: isEditMode,
              onTap: () => _selectDate(context, TextEditingController(text: _toString(quotationData['commitment_date']))),
            ),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
              child: const Text('TRACKING', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
            ),
            const SizedBox(height: 16),
            _buildEditableInfoRow(
              'Source Document',
              TextEditingController(text: _toString(quotationData['origin'])),
            ),
            const SizedBox(height: 16),
            _buildEditableInfoRow(
              'Opportunity',
              TextEditingController(
                  text: quotationData['opportunity_id'] is List ? quotationData['opportunity_id'][1] as String : ''),
              isDropdown: isEditMode,
              items: oppor.map((o) => o['name'] as String).toList(),
              onDropdownChanged: (value) {
                if (value != null) {
                  final opportunity = oppor.firstWhere((o) => o['name'] == value);
                  setState(() {
                    quotationData['opportunity_id'] = [opportunity['id'], opportunity['name']];
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            _buildEditableInfoRow(
              'Campaign',
              TextEditingController(text: quotationData['campaign_id'] is List ? quotationData['campaign_id'][1] as String : ''),
              isDropdown: isEditMode,
              items: campaigns.map((c) => c['name'] as String).toList(),
              onDropdownChanged: (value) {
                if (value != null) {
                  final campaign = campaigns.firstWhere((c) => c['name'] == value);
                  setState(() {
                    quotationData['campaign_id'] = [campaign['id'], campaign['name']];
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            _buildEditableInfoRow(
              'Medium',
              TextEditingController(text: quotationData['medium_id'] is List ? quotationData['medium_id'][1] as String : ''),
              isDropdown: isEditMode,
              items: mediums.map((m) => m['name'] as String).toList(),
              onDropdownChanged: (value) {
                if (value != null) {
                  final medium = mediums.firstWhere((m) => m['name'] == value);
                  setState(() {
                    quotationData['medium_id'] = [medium['id'], medium['name']];
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            _buildEditableInfoRow(
              'Source',
              TextEditingController(text: quotationData['source_id'] is List ? quotationData['source_id'][1] as String : ''),
              isDropdown: isEditMode,
              items: sources.map((s) => s['name'] as String).toList(),
              onDropdownChanged: (value) {
                if (value != null) {
                  final source = sources.firstWhere((s) => s['name'] == value);
                  setState(() {
                    quotationData['source_id'] = [source['id'], source['name']];
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerSignatureTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Customer Signature', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
            child: const Center(child: Text('Signature area (Not implemented)', style: TextStyle(color: Colors.black54))),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF9EA700), foregroundColor: Colors.white),
            child: const Text('Add Signature'),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableInfoRow(
      String label,
      TextEditingController controller, {
        bool isDropdown = false,
        bool isDate = false,
        List<String> items = const [],
        void Function(String?)? onDropdownChanged,
        VoidCallback? onTap,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
        const SizedBox(height: 8),
        isEditMode
            ? isDate
            ? GestureDetector(
          onTap: onTap,
          child: AbsorbPointer(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
            ),
          ),
        )
            : isDropdown
            ? CustomDropdown.search(
          hintText: label,
          items: items,
          initialItem: items.contains(controller.text) ? controller.text : null,
          onChanged: (value) {
            if (value != null) {
              controller.text = value;
              if (onDropdownChanged != null) onDropdownChanged(value);
            }
          },
        )
            : TextField(
          controller: controller,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          onChanged: (value) {
            if (label == 'Customer Reference') {
              setState(() {
                quotationData['client_order_ref'] = value;
              });
            }
          },
        )
            : Text(
          controller.text.isNotEmpty ? controller.text : 'N/A',
          style: const TextStyle(color: Color(0xFF9EA700)),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 95),
              child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87), overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(width: 4),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(value, style: const TextStyle(color: Color(0xFF9EA700))),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRowWithIcon(String label, [String value = '']) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 95),
              child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87), overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(width: 4),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(value, style: const TextStyle(color: Color(0xFF9EA700))),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRowWithPercentage(String label, String percentage) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 95),
              child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87), overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(width: 4),
          ],
        ),
        const SizedBox(width: 8),
        const Text('of', style: TextStyle(color: Colors.black87)),
        const SizedBox(width: 8),
        Text(percentage, style: const TextStyle(color: Color(0xFF9EA700))),
      ],
    );
  }

  Widget _buildInfoRowWithTags(String label, List tagIds) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 95),
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87), overflow: TextOverflow.ellipsis),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tagNames.isNotEmpty
                ? tagNames
                .map((tagName) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: Colors.red.shade200, borderRadius: BorderRadius.circular(12)),
              child: Text(tagName, style: const TextStyle(color: Colors.white, fontSize: 12)),
            ))
                .toList()
                : [
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: Colors.red.shade200, borderRadius: BorderRadius.circular(12)),
                  child: const Text('Product', style: TextStyle(color: Colors.white, fontSize: 12)))
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTab(String text, {bool isSelected = false}) {
    return Text(
      text,
      style: TextStyle(
        color: isSelected ? const Color(0xFF9EA700) : Colors.black87,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        fontSize: 14,
      ),
    );
  }

  Widget _buildTableHeader(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87),
      ),
    );
  }
}