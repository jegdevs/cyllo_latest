import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Customers extends StatefulWidget {
  const Customers({super.key});

  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  OdooClient? client;
  bool isLoading = false;
  List<dynamic> customers = [];

  @override
  void initState() {
    super.initState();
    initializeOdooClient();
  }

  Future<void> initializeOdooClient() async {
    setState(() => isLoading = true);
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
        await client!.authenticate(dbName, userLogin, userPassword);
        await fetchCustomerData();
      } catch (e) {
        print("Odoo Authentication Failed: $e");
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to connect to Odoo: $e")),
          );
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Missing connection details")),
        );
      }
    }
    if (mounted) {
      setState(() => isLoading = false);
    }
  }

  Future<void> fetchCustomerData() async {
    try {
      final response = await client?.callKw({
        'model': 'res.partner',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {
          'fields': ['name', 'email', 'city', 'category_id', 'image_128'],
        },
      });
      if (mounted) {
        setState(() {
          customers = response ?? [];
        });
      }
    } catch (e) {
      print("Error fetching customers: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customers"),
        elevation: 0,
        backgroundColor: Color(0xFF9EA700)  ,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : customers.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              "No Customers Found",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      )
          : RefreshIndicator(
        onRefresh: fetchCustomerData,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85, // Adjusted ratio to fix overflow
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: customers.length,
            itemBuilder: (context, index) {
              final customer = customers[index];
              return buildCustomerCard(customer);
            },
          ),
        ),
      ),
    );
  }

  Widget buildCustomerCard(dynamic customer) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // Handle customer card tap
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (customer['image_128'] != null && customer['image_128'] is String)
                CircleAvatar(
                  radius: 30,
                  backgroundImage: MemoryImage(
                    Base64Decoder().convert(customer['image_128']),
                  ),
                )
              else
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[200],
                  child: Icon(Icons.person, size: 30, color: Colors.grey[800]),
                ),
              const SizedBox(height: 10),

              // Customer name
              Text(
                customer['name'] != null && customer['name'] is String
                    ? customer['name']
                    : 'Unknown',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),

              if (customer['email'] != null && customer['email'] is String)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    customer['email'],
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),

              // Customer location
              if (customer['city'] != null && customer['city'] is String)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_on, size: 12, color: Colors.blueGrey[400]),
                      const SizedBox(width: 2),
                      Flexible(
                        child: Text(
                          customer['city'],
                          style: TextStyle(fontSize: 12, color: Colors.blueGrey[400]),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              const Spacer(),
              if (customer['category_id'] != null && customer['category_id'] is List && (customer['category_id'] as List).isNotEmpty)
                buildCategoryTags(customer['category_id']),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategoryTags(List<dynamic> categories) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 4,
        runSpacing: 4,
        children: categories.take(2).map((nm) {
          String categoryName = "";
          if (nm is String) {
            categoryName = nm;
          } else if (nm is bool) {
            categoryName = nm.toString();
          } else if (nm is num) {
            categoryName = nm.toString(); // Convert number to string
          } else if (nm is List && nm.length == 2 && nm[1] is String) {
            // Handle Odoo's typical [id, name] format for many2one fields
            categoryName = nm[1];
          } else {
            categoryName = "Category"; // Fallback
          }

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                width: 0.5,
              ),
            ),
            child: Text(
              categoryName,
              style: TextStyle(
                fontSize: 10,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}