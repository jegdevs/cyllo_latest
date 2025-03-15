import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

class QuotationPage extends StatefulWidget {
  final int quotationId;

  const QuotationPage({Key? key, required this.quotationId}) : super(key: key);

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
  String? selectedProductId;

  @override
  void initState() {
    super.initState();
    initializeOdooClient();
  }

  @override
  void dispose() {
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
        await fetchQuotationDetails();
        await fetchOrderLines();
        await addressFetch();
        await fetchProducts();
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
            'amount_total', 'state', 'user_id', 'team_id', 'company_id'
          ],
        },
      });
      if (response is List && response.isNotEmpty && mounted) {
        setState(() {
          quotationData = response[0];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          quotationData = {};
        });
      }
    } catch (e) {
      print("Error fetching quotation details: $e");
      if (mounted) {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching quotation details: $e')),
        );
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
        'model': 'product.template',
        'method': 'search_read',
        'args': [

        ],
        'kwargs': {
          'fields': ['name', 'id', 'default_code'],
          'limit': 50,
        },
      });
      print("Raw Products Response: $response");
      if (response is List) {
        setState(() {
          products = List<Map<String, dynamic>>.from(response);
          print("Filtered Products: $products");
        });
      } else {
        print("No products returned or invalid response format");
      }
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  Future<void> addProductToOrderLine(String productId) async {
    if (client == null) return;
    try {
      final orderLineId = await client!.callKw({
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
      print("Order Line Created with ID: $orderLineId");
      await fetchOrderLines(); // Refresh the order lines after adding
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product added successfully')),
        );
      }
    } catch (e) {
      print("Error adding product to order line: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding product: $e')),
        );
      }
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
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting order line: $e')),
        );
      }
    }
  }

  void switchTab(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  void toggleEditMode() async {
    if (isEditMode && selectedProductId != null) {
      await addProductToOrderLine(selectedProductId!);
      setState(() {
        selectedProductId = null; // Clear the selection after saving
      });
    }
    setState(() {
      isEditMode = !isEditMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF9EA700),
        elevation: 0,
        title: const Text('Quotations Details'),
        actions: [
          IconButton(
            icon: Icon(isEditMode ? Icons.save : Icons.edit),
            onPressed: toggleEditMode,
            color: Colors.white,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF9EA700)))
          : SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9EA700),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                      child: const Text('SEND BY EMAIL'),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black87,
                        side: const BorderSide(color: Colors.grey),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                      child: const Text('CONFIRM'),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black87,
                        side: const BorderSide(color: Colors.grey),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                      child: const Text('PREVIEW'),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black87,
                        side: const BorderSide(color: Colors.grey),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                      child: const Text('CANCEL'),
                    ),
                    const SizedBox(width: 16),
                    Text('Quotation', style: const TextStyle(color: Color(0xFF9EA700), fontSize: 14)),
                    const SizedBox(width: 8),
                    const Text('>', style: TextStyle(color: Colors.black54)),
                    const SizedBox(width: 8),
                    const Text('Quotation Sent', style: TextStyle(fontSize: 14)),
                    const SizedBox(width: 8),
                    const Text('>', style: TextStyle(color: Colors.black54)),
                    const SizedBox(width: 8),
                    const Text('Sales Order', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                quotationData['name'] ?? 'None',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow(
                          'Customer',
                          quotationData['partner_id'] is List && quotationData['partner_id'].length > 1
                              ? quotationData['partner_id'][1]
                              : 'N/A',
                        ),
                        const SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.only(left: 95.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                newAddress.isNotEmpty ? (newAddress[0]['street'] ?? 'N/A') : 'No Street',
                                style: const TextStyle(color: Colors.black54),
                              ),
                              Text(
                                newAddress.isNotEmpty ? (newAddress[0]['city'] ?? 'N/A') : 'No City',
                                style: const TextStyle(color: Colors.black54),
                              ),
                              Text(
                                newAddress.isNotEmpty
                                    ? (newAddress[0]['country_id'] is List && newAddress[0]['country_id'].length > 1
                                    ? newAddress[0]['country_id'][1]
                                    : 'N/A')
                                    : 'No Country',
                                style: const TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow(
                          'Invoice Address',
                          quotationData['partner_invoice_id'] is List && quotationData['partner_invoice_id'].length > 1
                              ? quotationData['partner_invoice_id'][1]
                              : 'N/A',
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow(
                          'Delivery Address',
                          quotationData['partner_shipping_id'] is List && quotationData['partner_shipping_id'].length > 1
                              ? quotationData['partner_shipping_id'][1]
                              : 'N/A',
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow('Quotation Template', ''),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow('Expiration', quotationData['validity_date'] ?? 'N/A'),
                        const SizedBox(height: 16),
                        _buildInfoRow('Quotation Date', quotationData['date_order'] ?? 'N/A'),
                        const SizedBox(height: 16),
                        _buildInfoRow(
                          'Pricelist',
                          quotationData['pricelist_id'] is List && quotationData['pricelist_id'].length > 1
                              ? quotationData['pricelist_id'][1]
                              : 'N/A',
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow(
                          'Payment Terms',
                          quotationData['payment_term_id'] is List && quotationData['payment_term_id'].length > 1
                              ? quotationData['payment_term_id'][1]
                              : 'N/A',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
            Expanded(
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Spacer(),
                  const Text('TOTAL:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Text(
                    '\$${quotationData['amount_total']?.toString() ?? '0.00'}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
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
                          child: Text(
                            line['product_id'] is List && line['product_id'].length > 1
                                ? line['product_id'][1]
                                : (line['product_id'] is int ? line['product_id'].toString() : 'N/A'),
                            style: const TextStyle(fontSize: 14, color: Color(0xFF9EA700)),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            line['name'] ?? 'N/A',
                            style: const TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            line['product_uom_qty']?.toString() ?? '0.00',
                            style: const TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            line['product_uom'] is List && line['product_uom'].length > 1
                                ? line['product_uom'][1]
                                : (line['product_uom'] is int ? line['product_uom'].toString() : 'N/A'),
                            style: const TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            line['product_packaging_qty']?.toString() ?? '0.00',
                            style: const TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            line['product_packaging_id'] is List && line['product_packaging_id'].length > 1
                                ? line['product_packaging_id'][1]
                                : (line['product_packaging_id'] is int ? line['product_packaging_id'].toString() : 'N/A'),
                            style: const TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            line['price_unit']?.toString() ?? '0.00',
                            style: const TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            line['tax_id'] is List
                                ? line['tax_id'].map((tax) => tax is List && tax.length > 1 ? tax[1] : tax.toString()).join(', ')
                                : 'N/A',
                            style: const TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '\$${line['price_subtotal']?.toString() ?? '0.00'}',
                            style: const TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: 48,
                          child: isEditMode
                              ? IconButton(
                            icon: const Icon(Icons.delete, size: 16),
                            onPressed: () {
                              final lineId = line['id'];
                              if (lineId != null) {
                                deleteOrderLine(lineId);
                              }
                            },
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
                          items: products.map((product) => '${product['default_code']!=false?[product['default_code']]:""} ${product['name']}').toList(),
                          onChanged: (value) {
                            final selected = products.firstWhere(
                                  (p) => '[${p['default_code'] ?? ''}] ${p['name']}' == value,
                              orElse: () => {},
                            );
                            if (selected.isNotEmpty) {
                              setState(() {
                                selectedProductId = selected['id'].toString();
                                print("Selected Product ID: $selectedProductId"); // Debug
                              });
                            } else {
                              print("No product found for value: $value"); // Debug
                            }
                          },
                          decoration: CustomDropdownDecoration(
                            closedFillColor: Colors.white,
                            expandedFillColor: Colors.white,
                            hintStyle: const TextStyle(color: Color(0xFF9EA700), fontWeight: FontWeight.w500),
                            listItemStyle: const TextStyle(color: Colors.black87),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: const Text(
                          'Add a section',
                          style: TextStyle(color: Color(0xFF9EA700), fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(child: Container()),
                      Expanded(child: Container()),
                      Expanded(child: Container()),
                      Expanded(child: Container()),
                      Expanded(child: Container()),
                      Expanded(child: Container()),
                      Expanded(
                        child: const Text(
                          'Add a note',
                          style: TextStyle(color: Color(0xFF9EA700), fontWeight: FontWeight.w500),
                        ),
                      ),
                      const Text(
                        'Catalog',
                        style: TextStyle(color: Color(0xFF9EA700), fontWeight: FontWeight.w500),
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

  Widget _buildOptionalProductsTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border(top: BorderSide(color: Colors.grey.shade300), bottom: BorderSide(color: Colors.grey.shade300)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 1000,
                child: Row(
                  children: [
                    _buildTableHeader('PRODUCT', flex: 2),
                    _buildTableHeader('DESCRIPTION', flex: 2),
                    _buildTableHeader('QUANTITY'),
                    _buildTableHeader('UNIT PRICE'),
                    _buildTableHeader('DISCOUNT'),
                    const Icon(Icons.more_vert, size: 16),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text('No optional products available.', style: TextStyle(color: Colors.black54)),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherInfoTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Additional Information', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildInfoRow('Salesperson',
              quotationData['user_id'] is List && quotationData['user_id'].length > 1 ? quotationData['user_id'][1] : 'N/A'),
          const SizedBox(height: 16),
          _buildInfoRow('Sales Team',
              quotationData['team_id'] is List && quotationData['team_id'].length > 1 ? quotationData['team_id'][1] : 'N/A'),
          const SizedBox(height: 16),
          _buildInfoRow('Company',
              quotationData['company_id'] is List && quotationData['company_id'].length > 1 ? quotationData['company_id'][1] : 'N/A'),
        ],
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