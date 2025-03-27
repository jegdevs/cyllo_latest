import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

import '../../Sales/Views/pipeLineView.dart';

class Leadview extends StatefulWidget {
  final int leadId;

  const Leadview({super.key, required this.leadId});

  @override
  State<Leadview> createState() => _LeadviewState();
}

class _LeadviewState extends State<Leadview> {
  OdooClient? client;
  bool isLoading = true;
  bool isEditing = false;
  int? currentUserId;
  List<Map<String, dynamic>> leadsList = [];
  String conversionAction = 'Convert to opportunity'; // Default radio button value
  String customerAction = 'Link to an existing customer'; // Default customer action
  int? selectedCustomerId;
  List<Map<String, dynamic>> opportunitiesToMerge = [];

  // Dropdown data
  List<Map<String, dynamic>> salesPersons = [];
  List<Map<String, dynamic>> salesTeams = [];
  List<Map<String, dynamic>> countries = [];
  List<Map<String, dynamic>> states = [];
  List<Map<String, dynamic>> partners = [];
  List<Map<String, dynamic>> company = [];
  List<Map<String, dynamic>> campaign = [];
  List<Map<String, dynamic>> medium = [];
  List<Map<String, dynamic>> source = [];
  List<Map<String, dynamic>> Assigned = [];
  List<Map<String, dynamic>> tags = [];


  // Controllers for editable fields
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController emailCCController;
  late TextEditingController functionController;
  late TextEditingController phoneController;
  late TextEditingController mobileController;
  late TextEditingController streetController;
  late TextEditingController cityController;
  late TextEditingController zipController;
  late TextEditingController websiteController;
  late TextEditingController contactNameController;
  late TextEditingController companyNameController;
  late TextEditingController probabilityController;
  late TextEditingController referController;
  late TextEditingController geoLocController;


  // Selected IDs for dropdowns (using IDs instead of names)
  int? selectedSalespersonId;
  int? selectedSalesTeamId;
  int? selectedCountryId;
  int? selectedStateId;
  int? selectedPartnerId;
  int? selectedCompanyID;
  int? selectedCampaignID;
  int? selectedMediumID;
  int? selectedSourceId;
  int? selectedAssignedId;
  List<int> selectedTagIds = [];

  @override
  void initState() {
    super.initState();
    initializeControllers();
    initializeOdooClient();
  }

  void initializeControllers() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    functionController =TextEditingController();
    emailCCController =TextEditingController();
    phoneController = TextEditingController();
    mobileController = TextEditingController();
    streetController = TextEditingController();
    cityController = TextEditingController();
    zipController = TextEditingController();
    websiteController = TextEditingController();
    contactNameController = TextEditingController();
    companyNameController = TextEditingController();
    probabilityController = TextEditingController();
    referController = TextEditingController();
    geoLocController =TextEditingController();
  }

  @override
  void dispose() {
    client?.close();
    nameController.dispose();
    emailController.dispose();
    functionController.dispose();
    emailCCController.dispose();
    phoneController.dispose();
    mobileController.dispose();
    streetController.dispose();
    cityController.dispose();
    zipController.dispose();
    websiteController.dispose();
    contactNameController.dispose();
    companyNameController.dispose();
    probabilityController.dispose();
    referController.dispose();
    geoLocController.dispose();
    super.dispose();
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
        await fetchDropdownData();
        setControllers();
      } catch (e) {
        print("Odoo Authentication Failed: $e");
      }
    }
    setState(() => isLoading = false);
  }

  Future<void> fetchDropdownData() async {
    await fetchSalesPersons();
    await fetchSalesTeams();
    await fetchCountries();
    await fetchStates();
    await fetchPartners();
    await fetchCompany();
    await fetchSource();
    await fetchCampaign();
    await fetchMedium();
    await fetchAssignedPartner();
    await fetchTags();

  }

  Future<void> fetchTags() async {
    try {
      final response = await client!.callKw({
        'model': 'crm.tag',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {'fields': ['id', 'name']},
      });
      if (response is List) {
        setState(() {
          tags = List<Map<String, dynamic>>.from(response);
        });
      }
    } catch (e) {
      print("Error fetching tags: $e");
    }
  }

  Future<void> fetchAssignedPartner() async {
    try {
      final response = await client!.callKw({
        'model': 'res.partner',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {'fields': ['id', 'name']},
      });
      if (response is List) {
        setState(() {
          Assigned = List<Map<String, dynamic>>.from(response);
        });
      }
    } catch (e) {
      print("Error fetching partners: $e");
    }
  }


  Future<void> fetchCampaign() async {
    try {
      final response = await client!.callKw({
        'model': 'utm.campaign',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {'fields': ['id', 'name']},
      });
      if (response is List) {
        setState(() {
          campaign = List<Map<String, dynamic>>.from(response);
        });
      }
    } catch (e) {
      print("Error fetching partners: $e");
    }
  }

  Future<void> fetchMedium() async {
    try {
      final response = await client!.callKw({
        'model': 'utm.medium',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {'fields': ['id', 'name']},
      });
      if (response is List) {
        setState(() {
          medium = List<Map<String, dynamic>>.from(response);
        });
      }
    } catch (e) {
      print("Error fetching partners: $e");
    }
  }
  Future<void> fetchSource() async {
    try {
      final response = await client!.callKw({
        'model': 'utm.source',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {'fields': ['id', 'name']},
      });
      if (response is List) {
        setState(() {
          source = List<Map<String, dynamic>>.from(response);
        });
      }
    } catch (e) {
      print("Error fetching partners: $e");
    }
  }

  Future<void> fetchCompany() async {
    try {
      final response = await client!.callKw({
        'model': 'res.company',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {'fields': ['id', 'name']},
      });
      if (response is List) {
        setState(() {
          company = List<Map<String, dynamic>>.from(response);
        });
      }
    } catch (e) {
      print("Error fetching partners: $e");
    }
  }

  Future<void> fetchSalesPersons() async {
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

  Future<void> fetchSalesTeams() async {
    try {
      final response = await client!.callKw({
        'model': 'crm.team',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {'fields': ['id', 'name']},
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

  Future<void> fetchCountries() async {
    try {
      final response = await client!.callKw({
        'model': 'res.country',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {'fields': ['id', 'name']},
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

  Future<void> fetchPartners() async {
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

  Future<void> fetchStates() async {
    try {
      final response = await client!.callKw({
        'model': 'res.country.state',
        'method': 'search_read',
        'args': [[]],
        'kwargs': {'fields': ['id', 'name']},
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



  void _showConvertToOpportunityDialog(BuildContext context) {
    setState(() {
      conversionAction = 'Convert to opportunity';
      customerAction = 'Link to an existing customer';
      selectedCustomerId = selectedPartnerId;
    });

    List<int> selectedOpportunityIds = [];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Convert to Opportunity'),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Conversion Action',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Radio<String>(
                          value: 'Convert to opportunity',
                          groupValue: conversionAction,
                          onChanged: (value) {
                            setDialogState(() {
                              conversionAction = value!;
                            });
                          },
                        ),
                        const Text('Convert to opportunity'),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<String>(
                          value: 'Merge with existing opportunities',
                          groupValue: conversionAction,
                          onChanged: (value) {
                            setDialogState(() {
                              conversionAction = value!;
                            });
                          },
                        ),
                        const Text('Merge with existing opportunities'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Assign This Opportunity To',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    _buildLabeledField(
                      context,
                      'Salesperson',
                      CustomDropdown<String>(
                        hintText: 'Select Salesperson',
                        items: salesPersons.map((sp) => sp['name'].toString()).toList(),
                        initialItem: _getNameFromId(selectedSalespersonId, salesPersons),
                        onChanged: (value) {
                          setState(() {
                            selectedSalespersonId = salesPersons.firstWhere((sp) => sp['name'] == value)['id'];
                          });
                        },
                      ),
                    ),
                    _buildLabeledField(
                      context,
                      'Sales Team',
                      CustomDropdown<String>(
                        hintText: 'Select Sales Team',
                        items: salesTeams.map((st) => st['name'].toString()).toList(),
                        initialItem: _getNameFromId(selectedSalesTeamId, salesTeams),
                        onChanged: (value) {
                          setState(() {
                            selectedSalesTeamId = salesTeams.firstWhere((st) => st['name'] == value)['id'];
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'OPPORTUNITIES',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    if (conversionAction == 'Merge with existing opportunities') ...[
                      _buildOpportunitiesTable(context, setDialogState, (ids) {
                        setDialogState(() {
                          selectedOpportunityIds = ids;
                        });
                      }),
                    ] else ...[
                      const Text(
                        'Customer',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Create a new customer',
                            groupValue: customerAction,
                            onChanged: (value) {
                              setDialogState(() {
                                customerAction = value!;
                              });
                            },
                          ),
                          const Text('Create a new customer'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Link to an existing customer',
                            groupValue: customerAction,
                            onChanged: (value) {
                              setDialogState(() {
                                customerAction = value!;
                              });
                            },
                          ),
                          const Text('Link to an existing customer'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Do not link to a customer',
                            groupValue: customerAction,
                            onChanged: (value) {
                              setDialogState(() {
                                customerAction = value!;
                              });
                            },
                          ),
                          const Text('Do not link to a customer'),
                        ],
                      ),
                      if (customerAction == 'Link to an existing customer')
                        _buildLabeledField(
                          context,
                          'Customer',
                          CustomDropdown<String>(
                            hintText: 'Select Customer',
                            items: partners.map((p) => p['name'].toString()).toList(),
                            initialItem: _getNameFromId(selectedCustomerId, partners),
                            onChanged: (value) {
                              setDialogState(() {
                                selectedCustomerId = partners.firstWhere((p) => p['name'] == value)['id'];
                              });
                            },
                          ),
                        ),
                    ],
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9EA700),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    bool success;
                    if (conversionAction == 'Convert to opportunity') {
                      success = await _convertToOpportunity(context);
                    } else {
                      success = await _mergeWithExistingOpportunity(context, selectedOpportunityIds);
                    }
                    if (success) {
                      Navigator.of(context).pop();
                      setState(() {});
                    }
                  },
                  child: const Text('Create Opportunity'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Widget _buildOpportunitiesTable(BuildContext context, StateSetter setDialogState, Function(List<int>) onSelectionChanged) {
  //   List<int> selectedOpportunityIds = [];
  //
  //   return FutureBuilder<List<Map<String, dynamic>>>(
  //     future: fetchOpportunitiesForMerge(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return const Center(child: CircularProgressIndicator());
  //       }
  //       if (snapshot.hasError) {
  //         return const Center(child: Text('Error loading duplicate opportunities'));
  //       }
  //
  //       List<Map<String, dynamic>> opportunitiesToMerge = snapshot.data ?? [];
  //
  //       if (opportunitiesToMerge.isEmpty) {
  //         return const Center(child: Text('No duplicate opportunities found'));
  //       }
  //
  //       return SingleChildScrollView(
  //         scrollDirection: Axis.horizontal,
  //         child: Container(
  //           decoration: BoxDecoration(
  //             border: Border.all(color: Colors.grey[300]!),
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //           child: DataTable(
  //             columnSpacing: 16,
  //             dataRowHeight: 56,
  //             headingRowHeight: 56,
  //             headingRowColor: MaterialStateProperty.resolveWith((states) => Colors.grey[100]),
  //             columns: [
  //               DataColumn(
  //                 label: Checkbox(
  //                   value: selectedOpportunityIds.length == opportunitiesToMerge.length,
  //                   onChanged: (bool? value) {
  //                     setDialogState(() {
  //                       if (value == true) {
  //                         selectedOpportunityIds = opportunitiesToMerge.map((opp) => opp['id'] as int).toList();
  //                       } else {
  //                         selectedOpportunityIds = [];
  //                       }
  //                       onSelectionChanged(selectedOpportunityIds);
  //                     });
  //                   },
  //                 ),
  //               ),
  //               DataColumn(label: Text('Created on', style: TextStyle(fontWeight: FontWeight.bold))),
  //               DataColumn(label: Text('Opportunity', style: TextStyle(fontWeight: FontWeight.bold))),
  //               DataColumn(label: Text('Type', style: TextStyle(fontWeight: FontWeight.bold))),
  //               DataColumn(label: Text('Contact Name', style: TextStyle(fontWeight: FontWeight.bold))),
  //               DataColumn(label: Text('Email', style: TextStyle(fontWeight: FontWeight.bold))),
  //               DataColumn(label: Text('Stage', style: TextStyle(fontWeight: FontWeight.bold))),
  //               DataColumn(label: Text('Salesperson', style: TextStyle(fontWeight: FontWeight.bold))),
  //               DataColumn(label: Text('Sales Team', style: TextStyle(fontWeight: FontWeight.bold))),
  //               DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
  //             ],
  //             rows: opportunitiesToMerge.map((opp) {
  //               return DataRow(
  //                 cells: [
  //                   DataCell(
  //                     Checkbox(
  //                       value: selectedOpportunityIds.contains(opp['id']),
  //                       onChanged: (bool? value) {
  //                         setDialogState(() {
  //                           if (value == true) {
  //                             selectedOpportunityIds.add(opp['id']);
  //                           } else {
  //                             selectedOpportunityIds.remove(opp['id']);
  //                           }
  //                           onSelectionChanged(selectedOpportunityIds);
  //                         });
  //                       },
  //                     ),
  //                   ),
  //                   DataCell(Text(_handleFalseValue(opp['date_open']))),
  //                   DataCell(Text(_handleFalseValue(opp['name']))),
  //                   DataCell(Text(_handleFalseValue(opp['type']))),
  //                   DataCell(Text(_handleFalseValue(opp['contact_name']))),
  //                   DataCell(Text(_handleFalseValue(opp['email_from']))),
  //                   DataCell(Text(_handleFalseValue(opp['stage_id'] is List ? opp['stage_id'][1] : 'None'))),
  //                   DataCell(Text(_handleRelationalField(opp['user_id']))),
  //                   DataCell(Text(_handleRelationalField(opp['team_id']))),
  //                   DataCell(
  //                     IconButton(
  //                       icon: Icon(Icons.close, color: Colors.grey[600]),
  //                       onPressed: () {
  //                         setDialogState(() {
  //                           opportunitiesToMerge.removeWhere((item) => item['id'] == opp['id']);
  //                           selectedOpportunityIds.remove(opp['id']);
  //                           onSelectionChanged(selectedOpportunityIds);
  //                         });
  //                       },
  //                     ),
  //                   ),
  //                 ],
  //               );
  //             }).toList(),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  Widget _buildOpportunitiesTable(BuildContext context, StateSetter setDialogState, Function(List<int>) onSelectionChanged) {
    List<int> selectedOpportunityIds = [];

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchOpportunitiesForMerge(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading duplicate opportunities'));
        }

        if (opportunitiesToMerge.isEmpty && snapshot.data != null) {
          opportunitiesToMerge = List.from(snapshot.data!);
        }

        if (opportunitiesToMerge.isEmpty) {
          return const Center(child: Text('No duplicate opportunities found'));
        }

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DataTable(
                columnSpacing: 16,
                dataRowHeight: 56,
                headingRowHeight: 56.0,
                headingRowColor: MaterialStateProperty.resolveWith((states) => Colors.grey[100]),
                columns: [
                  DataColumn(
                    label: Checkbox(
                      value: selectedOpportunityIds.length == opportunitiesToMerge.length,
                      onChanged: (bool? value) {
                        setDialogState(() {
                          if (value == true) {
                            selectedOpportunityIds = opportunitiesToMerge.map((opp) => opp['id'] as int).toList();
                          } else {
                            selectedOpportunityIds = [];
                          }
                          onSelectionChanged(selectedOpportunityIds);
                        });
                      },
                    ),
                  ),
                  DataColumn(label: Text('Opportunity', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Contact Name', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Email', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Salesperson', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Expected Revenue', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Expected Closing', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Stage', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                rows: [
                  ...opportunitiesToMerge.map((opp) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Checkbox(
                            value: selectedOpportunityIds.contains(opp['id']),
                            onChanged: (bool? value) {
                              setDialogState(() {
                                if (value == true) {
                                  selectedOpportunityIds.add(opp['id']);
                                } else {
                                  selectedOpportunityIds.remove(opp['id']);
                                }
                                onSelectionChanged(selectedOpportunityIds);
                              });
                            },
                          ),
                        ),
                        DataCell(Text(_handleFalseValue(opp['name']))),
                        DataCell(Text(_handleFalseValue(opp['contact_name']))),
                        DataCell(Text(_handleFalseValue(opp['email_from']))),
                        DataCell(Text(_handleRelationalField(opp['user_id']))),
                        DataCell(Text(_handleFalseValue(opp['planned_revenue']))),
                        DataCell(Text(_handleFalseValue(opp['date_deadline']))),
                        DataCell(Text(_handleFalseValue(opp['stage_id'] is List ? opp['stage_id'][1] : 'None'))),
                        DataCell(
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.grey[600]),
                            onPressed: () {
                              setDialogState(() {
                                opportunitiesToMerge.removeWhere((item) => item['id'] == opp['id']);
                                selectedOpportunityIds.remove(opp['id']);
                                onSelectionChanged(selectedOpportunityIds);
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                  DataRow(
                    cells: [
                      DataCell(Container()), // 1
                      DataCell(
                        TextButton(
                          onPressed: () {
                            _showAddOpportunityDialog(context, setDialogState, opportunitiesToMerge, (newOpportunities) {
                              setDialogState(() {
                                opportunitiesToMerge.addAll(newOpportunities);
                                onSelectionChanged(selectedOpportunityIds);
                              });
                            });
                          },
                          child: const Text(
                            'Add Line',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ), // 2
                      DataCell(Container()),
                      DataCell(Container()),
                      DataCell(Container()),
                      DataCell(Container()),
                      DataCell(Container()),
                      DataCell(Container()),
                      DataCell(Container()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  void _showAddOpportunityDialog(
      BuildContext context,
      StateSetter parentSetState,
      List<Map<String, dynamic>> opportunitiesToMerge,
      Function(List<Map<String, dynamic>>) onAddOpportunities) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        List<Map<String, dynamic>> allOpportunities = [];
        List<int> selectedNewOpportunityIds = [];

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text('Add Opportunities'),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.6,
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: fetchAllOpportunities(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(child: Text('Error loading opportunities'));
                    }

                    allOpportunities = snapshot.data ?? [];
                    allOpportunities = allOpportunities
                        .where((opp) => !opportunitiesToMerge.any((existing) => existing['id'] == opp['id']))
                        .toList();

                    if (allOpportunities.isEmpty) {
                      return const Center(child: Text('No additional opportunities available'));
                    }

                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DataTable(
                            columnSpacing: 16,
                            dataRowHeight: 56,
                            headingRowHeight: 56,
                            headingRowColor: MaterialStateProperty.resolveWith((states) => Colors.grey[100]),
                            columns: const [
                              DataColumn(label: Text('')),
                              DataColumn(label: Text('Opportunity', style: TextStyle(fontWeight: FontWeight.bold))),
                              DataColumn(label: Text('Contact Name', style: TextStyle(fontWeight: FontWeight.bold))),
                              DataColumn(label: Text('Email', style: TextStyle(fontWeight: FontWeight.bold))),
                              DataColumn(label: Text('Salesperson', style: TextStyle(fontWeight: FontWeight.bold))),
                              DataColumn(label: Text('Expected Revenue', style: TextStyle(fontWeight: FontWeight.bold))),
                              DataColumn(label: Text('Expected Closing', style: TextStyle(fontWeight: FontWeight.bold))),
                              DataColumn(label: Text('Stage', style: TextStyle(fontWeight: FontWeight.bold))),
                              DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
                            ],
                            rows: allOpportunities.map((opp) {
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Checkbox(
                                      value: selectedNewOpportunityIds.contains(opp['id']),
                                      onChanged: (bool? value) {
                                        setDialogState(() {
                                          if (value == true) {
                                            selectedNewOpportunityIds.add(opp['id']);
                                          } else {
                                            selectedNewOpportunityIds.remove(opp['id']);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  DataCell(Text(_handleFalseValue(opp['name']))),
                                  DataCell(Text(_handleFalseValue(opp['contact_name']))),
                                  DataCell(Text(_handleFalseValue(opp['email_from']))),
                                  DataCell(Text(_handleRelationalField(opp['user_id']))),
                                  DataCell(Text(_handleFalseValue(opp['planned_revenue']))),
                                  DataCell(Text(_handleFalseValue(opp['date_deadline']))),
                                  DataCell(Text(_handleFalseValue(opp['stage_id'] is List ? opp['stage_id'][1] : 'None'))),
                                  DataCell(
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.email, color: Colors.grey),
                                          onPressed: () {},
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.sms, color: Colors.grey),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9EA700),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    List<Map<String, dynamic>> newOpportunities = allOpportunities
                        .where((opp) => selectedNewOpportunityIds.contains(opp['id']))
                        .toList();
                    onAddOpportunities(newOpportunities); // Pass new opportunities back
                    Navigator.of(dialogContext).pop(); // Close the dialog
                  },
                  child: const Text('Add Selected'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }
  Future<List<Map<String, dynamic>>> fetchAllOpportunities() async {
    try {
      if (client == null) {
        log("Odoo client is not initialized");
        return [];
      }

      final response = await client!.callKw({
        'model': 'crm.lead',
        'method': 'search_read',
        'args': [
          []
        ],
        'kwargs': {
          'fields': [

          ],
        },
      });

      if (response is List) {
        return List<Map<String, dynamic>>.from(response);
      }
      return [];
    } catch (e) {
      log("Error fetching all opportunities: $e");
      return [];
    }
  }
  Future<bool> _convertToOpportunity(BuildContext context) async {
    try {
      if (client == null) {
        throw Exception("Odoo client is not initialized");
      }

      // Prepare the conversion parameters
      final conversionData = {
        'lead_id': widget.leadId,
        'name': conversionAction == 'Convert to opportunity' ? 'convert' : 'merge',
        'action': customerAction == 'Create a new customer'
            ? 'create'
            : (customerAction == 'Link to an existing customer' ? 'exist' : 'nothing'),
        'user_id': selectedSalespersonId ?? false,
        'team_id': selectedSalesTeamId ?? false,
        'partner_id': customerAction == 'Link to an existing customer'
            ? (selectedCustomerId ?? false)
            : false,
        'duplicated_lead_ids': conversionAction == 'Merge with existing opportunities'
            ? leadsList.map((lead) => lead['id']).toList()
            : [],
      };

      log("Starting conversion process for lead ID: ${widget.leadId}");
      log("Conversion data: $conversionData");

      final responseWrite = await client!.callKw({
        'model': 'crm.lead2opportunity.partner',
        'method': 'create',
        'args': [conversionData],
        'kwargs': {},
      });

      log("Response from create: $responseWrite");

      if (responseWrite == null) {
        throw Exception("Failed to create conversion record");
      }

      final response = await client!.callKw({
        'model': 'crm.lead2opportunity.partner',
        'method': 'action_apply',
        'args': [responseWrite],
        'kwargs': {
          'context': {
            'active_ids': [widget.leadId],
          },
        },
      });

      log("Response from action_apply: $response");

      if (response != null) {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lead converted to opportunity successfully')),
        );

        await leadData();
        log("Refreshed lead data: $leadsList");

        int opportunityId = widget.leadId; // Default to lead ID
        if (response is Map && response.containsKey('opportunity_id')) {
          opportunityId = response['opportunity_id'];
          log("Opportunity ID from response: $opportunityId");
        } else if (leadsList.isNotEmpty && leadsList[0]['type'] == 'opportunity') {
          opportunityId = leadsList[0]['id'];
          log("Opportunity ID from leadsList: $opportunityId");
        } else {
          log("Warning: Could not determine opportunity ID, using lead ID: $opportunityId");
        }

        Navigator.of(context).pop();
        log("Dialog closed, attempting navigation to LeadDetailPage");

        WidgetsBinding.instance.addPostFrameCallback((_) {
          log("Navigating to LeadDetailPage with ID: $opportunityId");
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LeadDetailPage(leadId: opportunityId),
            ),
          );
        });

        return true;
      } else {
        throw Exception("Failed to apply conversion - response is null");
      }
    } catch (e) {
      log("Error converting lead to opportunity: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error converting lead: $e')),
      );
      return false;
    }
  }

  Future<bool> _mergeWithExistingOpportunity(BuildContext context, List<int> selectedOpportunityIds) async {
    try {
      if (client == null) {
        throw Exception("Odoo client is not initialized");
      }

      if (selectedOpportunityIds.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select at least one opportunity to merge')),
        );
        return false;
      }

      // Prepare merge data using crm.lead2opportunity.partner
      final mergeData = {
        'lead_id': widget.leadId,
        'name': 'merge',
        'user_id': selectedSalespersonId ?? false,
        'team_id': selectedSalesTeamId ?? false,
        'duplicated_lead_ids': selectedOpportunityIds, // Pass selected IDs
      };

      // Step 1: Create the merge record
      final responseWrite = await client!.callKw({
        'model': 'crm.lead2opportunity.partner',
        'method': 'create',
        'args': [mergeData],
        'kwargs': {},
      });

      if (responseWrite == null) {
        throw Exception("Failed to create merge record");
      }


      final response = await client!.callKw({
        'model': 'crm.lead2opportunity.partner',
        'method': 'action_apply',
        'args': [responseWrite],
        'kwargs': {
          'context': {
            'active_ids': [widget.leadId, ...selectedOpportunityIds],
          },
        },
      });

      if (response != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Opportunities merged successfully')),
        );
        await leadData();
        return true;
      } else {
        throw Exception("Failed to merge opportunities");
      }
    } catch (e) {
      log("Error merging with existing opportunity: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error merging opportunity: $e')),
      );
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> fetchOpportunitiesForMerge() async {
    try {
      if (client == null) {
        log("Odoo client is not initialized");
        return [];
      }

      final responseWrite = await client!.callKw({
        'model': 'crm.lead2opportunity.partner',
        'method': 'create',
        'args': [
          {
            'lead_id': widget.leadId,
            'name': 'merge',
          }
        ],
        'kwargs': {},
      });

      if (responseWrite == null) {
        log("Failed to create crm.lead2opportunity.partner record");
        return [];
      }
      final duplicateResponse = await client!.callKw({
        'model': 'crm.lead2opportunity.partner',
        'method': 'read',
        'args': [responseWrite],
        'kwargs': {
          'fields': ['duplicated_lead_ids'],
        },
      });

      if (duplicateResponse == null || duplicateResponse.isEmpty || duplicateResponse[0]['duplicated_lead_ids'] == false) {
        log("No duplicate lead IDs found");
        return [];
      }

      final duplicatedLeadIds = List<int>.from(duplicateResponse[0]['duplicated_lead_ids'] as List);

      if (duplicatedLeadIds.isEmpty) {
        log("Duplicated lead IDs list is empty");
        return [];
      }

      final response = await client!.callKw({
        'model': 'crm.lead',
        'method': 'search_read',
        'args': [
          [
            ['id', 'in', duplicatedLeadIds],
          ]
        ],
        'kwargs': {
          'fields': [
            'id',
            'name',
            'date_open',
            'type',
            'contact_name',
            'email_from',
            'stage_id',
            'user_id',
            'team_id',
          ],
        }
      });

      if (response is List) {
        return List<Map<String, dynamic>>.from(response);
      }
      return [];
    } catch (e) {
      log("Error fetching duplicate opportunities: $e");
      return [];
    }
  }


  void setControllers() {
    if (leadsList.isNotEmpty) {
      final lead = leadsList[0];
      nameController.text = _handleFalseValue(lead['name']);
      emailController.text = _handleFalseValue(lead['email_from']);
      functionController.text = _handleFalseValue(lead['function']);
      emailCCController.text = _handleFalseValue(lead['email_cc']);
      phoneController.text = _handleFalseValue(lead['phone']);
      mobileController.text = _handleFalseValue(lead['mobile']);
      streetController.text = _handleFalseValue(lead['street']);
      cityController.text = _handleFalseValue(lead['city']);
      zipController.text = _handleFalseValue(lead['zip']);
      websiteController.text = _handleFalseValue(lead['website']);
      contactNameController.text = _handleFalseValue(lead['contact_name']);
      companyNameController.text = _handleFalseValue(lead['partner_name']);
      probabilityController.text = _handleFalseValue(lead['probability']);
      referController.text = _handleFalseValue(lead['referred']);
      geoLocController.text = _handleFalseValue(lead['partner_latitude']);
      selectedSalespersonId = _getRelationalId(lead['user_id']);
      selectedSalesTeamId = _getRelationalId(lead['team_id']);
      selectedCountryId = _getRelationalId(lead['country_id']);
      selectedStateId = _getRelationalId(lead['state_id']);
      selectedPartnerId = _getRelationalId(lead['partner_id']);
      selectedCompanyID  = _getRelationalId(lead['company_id']);
      selectedCampaignID = _getRelationalId(lead['campaign_id']);
      selectedMediumID = _getRelationalId(lead['medium_id']);
      selectedSourceId = _getRelationalId(lead['source_id']);
      selectedAssignedId = _getRelationalId(lead['partner_assigned_id']);
      selectedTagIds = lead['tag_ids'] != false && lead['tag_ids'].isNotEmpty
          ? List<int>.from(lead['tag_ids'])
          : [];
    }
  }

  Future<void> leadData() async {
    try {
      final response = await client?.callKw({
        'model': 'crm.lead',
        'method': 'search_read',
        'args': [
          [
            ['id', '=', widget.leadId]
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
            'probability',
            'partner_name',
            'contact_name',
            'phone',
            'mobile',
            'priority',
            'function',
            'email_cc',
            'street',
            'zip',
            'state_id',
            'website',
            'company_id',
            'campaign_id',
            'medium_id',
            'source_id',
            'referred',
            'date_open',
            'date_closed',
            'partner_latitude',
            'partner_id',
            'tag_ids',
            'active',
          ],
        }
      });
      print('leadRes$response');
      if (response != null && response.isNotEmpty) {
        setState(() {
          leadsList = List<Map<String, dynamic>>.from(response);
        });
      }
    } catch (e) {
      log("error loading data$e");
    }
  }

  Future<void> saveLeadChanges() async {
    if (client == null) return;

    setState(() => isLoading = true);
    try {
      final updatedData = {
        'name': nameController.text,
        'email_from': emailController.text,
        'function' : functionController.text,
        'email_cc' : emailCCController.text,
        'phone': phoneController.text,
        'mobile': mobileController.text,
        'street': streetController.text,
        'city': cityController.text,
        'zip': zipController.text,
        'website': websiteController.text,
        'contact_name': contactNameController.text,
        'partner_name': companyNameController.text,
        'probability': double.tryParse(probabilityController.text) ?? 0.0,
        'referred' : referController.text,
        'partner_latitude' :geoLocController.text,
        'user_id': selectedSalespersonId ?? false,
        'team_id': selectedSalesTeamId ?? false,
        'country_id': selectedCountryId ?? false,
        'state_id': selectedStateId ?? false,
        'partner_id': selectedPartnerId ?? false,
        'company_id': selectedCompanyID ?? false,
        'campaign_id' : selectedCampaignID ?? false,
        'medium_id' : selectedMediumID ?? false,
        'source_id' : selectedSourceId ?? false,
        'partner_assigned_id': selectedAssignedId ?? false,
        'tag_ids': selectedTagIds.isNotEmpty ? [[6, 0, selectedTagIds]]: false,
      };

      final response = await client!.callKw({
        'model': 'crm.lead',
        'method': 'write',
        'args': [[widget.leadId], updatedData],
        'kwargs': {},
      });

      if (response == true) {
        await leadData();
        setControllers();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lead updated successfully')),
        );
        setState(() => isEditing = false);
      } else {
        throw Exception("Failed to update lead");
      }
    } catch (e) {
      log('Error updating lead: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating lead: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  String _handleFalseValue(dynamic value) {
    if (value == false) return 'None';
    return value?.toString() ?? 'None';
  }

  int? _getRelationalId(dynamic value) {
    if (value == false) return null;
    if (value is List && value.isNotEmpty) return value[0] as int?;
    return null;
  }

  String _handleRelationalField(dynamic value) {
    if (value == false) return 'None';
    if (value is List && value.length > 1) return value[1].toString();
    return 'None';
  }

  String? _getNameFromId(int? id, List<Map<String, dynamic>> items) {
    if (id == null) return null;
    final item = items.firstWhere((e) => e['id'] == id, orElse: () => {});
    return item.isNotEmpty ? item['name'].toString() : null;
  }

  List<String> _getNamesFromIds(List<int> ids, List<Map<String, dynamic>> items) {
    return ids.map((id) {
      final item = items.firstWhere((e) => e['id'] == id, orElse: () => {'name': 'None'});
      return item['name'].toString();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Lead Details'),
        backgroundColor: const Color(0xFF9EA700),
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
              icon: const Icon(Icons.cancel),
              onPressed: () {
                setState(() {
                  isEditing = false;
                  setControllers();
                });
              },
            ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9EA700),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  onPressed: () {
                    _showConvertToOpportunityDialog(context);
                  },
                  child: const Text('Convert to Opportunity'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  onPressed: () {},
                  child: const Text('Lost'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            isEditing
                ? TextField(
              controller: nameController,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Lead Name',
              ),
            )
                : Text(
              leadsList.isNotEmpty
                  ? _handleFalseValue(leadsList[0]['name'])
                  : '',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Text(
                  'Probability',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 16),
                isEditing
                    ? SizedBox(
                  width: 100,
                  child: TextField(
                    controller: probabilityController,
                    keyboardType:
                    const TextInputType.numberWithOptions(
                        decimal: true),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      suffixText: '%',
                    ),
                  ),
                )
                    : Text(
                  leadsList.isNotEmpty
                      ? '${_handleFalseValue(leadsList[0]['probability'])} %'
                      : '0.00 %',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildLabeledField(
                context,
                'Customer',
              isEditing
                  ? CustomDropdown<String>(
                hintText: 'Select Customer',
                items: partners.map((p) => p['name'].toString()).toList(),
                initialItem: _getNameFromId(selectedPartnerId, partners),
                onChanged: (value) {
                  setState(() {
                    selectedPartnerId =
                    partners.firstWhere((p) => p['name'] == value)['id'];
                  });
                },
              )
                  : leadsList.isNotEmpty
                  ? _handleRelationalField(leadsList[0]['partner_id'])
                  : '',
            ),
            _buildLabeledField(
              context,
              'Company Name',
              isEditing
                  ? TextField(
                controller: companyNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              )
                  : leadsList.isNotEmpty
                  ? _handleFalseValue(leadsList[0]['partner_name'])
                  : '',
            ),
            _buildLabeledField(
              context,
              'Contact Name',
              isEditing
                  ? TextField(
                controller: contactNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              )
                  : leadsList.isNotEmpty
                  ? _handleFalseValue(leadsList[0]['contact_name'])
                  : '',
            ),
            _buildLabeledField(
              context,
              'Address',
              isEditing
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: streetController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Street',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: cityController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'City',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: zipController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Zip',
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomDropdown<String>(
                    hintText: 'Select Country',
                    items: countries
                        .map((c) => c['name'].toString())
                        .toList(),
                    initialItem: _getNameFromId(
                        selectedCountryId, countries),
                    onChanged: (value) {
                      setState(() {
                        selectedCountryId = countries
                            .firstWhere(
                                (c) => c['name'] == value)['id'];
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  CustomDropdown<String>(
                    hintText: 'Select State',
                    items: states
                        .map((s) => s['name'].toString())
                        .toList(),
                    initialItem:
                    _getNameFromId(selectedStateId, states),
                    onChanged: (value) {
                      setState(() {
                        selectedStateId = states.firstWhere(
                                (s) => s['name'] == value)['id'];
                      });
                    },
                  ),
                ],
              )
                  : leadsList.isNotEmpty
                  ? _handleFalseValue(leadsList[0]['street'])
                  : '',
            ),
            if (!isEditing)
              Padding(
                padding: const EdgeInsets.only(left: 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      leadsList.isNotEmpty
                          ? _handleRelationalField(
                          leadsList[0]['country_id'])
                          : '',
                    ),
                    Text(
                      leadsList.isNotEmpty
                          ? _handleFalseValue(leadsList[0]['city'])
                          : '',
                    ),
                    Text(
                      leadsList.isNotEmpty
                          ? _handleFalseValue(leadsList[0]['zip'])
                          : '',
                    ),
                    Text(
                      leadsList.isNotEmpty
                          ? _handleRelationalField(leadsList[0]['state_id'])
                          : '',
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 4),
            _buildLabeledField(
              context,
              'Website',
              isEditing
                  ? TextField(
                controller: websiteController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              )
                  : leadsList.isNotEmpty
                  ? _handleFalseValue(leadsList[0]['website'])
                  : '',
            ),
            _buildLabeledField(
              context,
              'Salesperson',
              isEditing
                  ? CustomDropdown<String>(
                hintText: 'Select Salesperson',
                items: salesPersons
                    .map((sp) => sp['name'].toString())
                    .toList(),
                initialItem: _getNameFromId(
                    selectedSalespersonId, salesPersons),
                onChanged: (value) {
                  setState(() {
                    selectedSalespersonId = salesPersons.firstWhere(
                            (sp) => sp['name'] == value)['id'];
                  });
                },
              )
                  : leadsList.isNotEmpty
                  ? _handleRelationalField(leadsList[0]['user_id'])
                  : '',
            ),
            _buildLabeledField(
              context,
              'Sales Team',
              isEditing
                  ? CustomDropdown<String>(
                hintText: 'Select Sales Team',
                items: salesTeams
                    .map((st) => st['name'].toString())
                    .toList(),
                initialItem:
                _getNameFromId(selectedSalesTeamId, salesTeams),
                onChanged: (value) {
                  setState(() {
                    selectedSalesTeamId = salesTeams.firstWhere(
                            (st) => st['name'] == value)['id'];
                  });
                },
              )
                  : leadsList.isNotEmpty
                  ? _handleRelationalField(leadsList[0]['team_id'])
                  : '',
            ),
            _buildLabeledField(
              context,
              'Email',
              isEditing
                  ? TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              )
                  : leadsList.isNotEmpty
                  ? _handleFalseValue(leadsList[0]['email_from'])
                  : '',
            ),
            _buildLabeledField(
                context,
                'Email cc',
              isEditing
                  ? TextField(
                controller: emailCCController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              )
                  : leadsList.isNotEmpty
                  ? _handleFalseValue(leadsList[0]['email_cc'])
                  : '',
            ),
            _buildLabeledField(
                context,
                'Job Position',
              isEditing
                  ? TextField(
                controller: functionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              )
                  : leadsList.isNotEmpty
                  ? _handleFalseValue(leadsList[0]['function'])
                  : '',
            ),
            _buildLabeledField(
              context,
              'Phone',
              isEditing
                  ? TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              )
                  : leadsList.isNotEmpty
                  ? _handleFalseValue(leadsList[0]['phone'])
                  : '',
            ),
            _buildLabeledField(
              context,
              'Mobile',
              isEditing
                  ? TextField(
                controller: mobileController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              )
                  : leadsList.isNotEmpty
                  ? _handleFalseValue(leadsList[0]['mobile'])
                  : '',
            ),
            Row(
              children: [
                const Text(
                  'Priority',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 16),
                Row(
                  children: _buildPriorityStars(leadsList.isNotEmpty
                      ? _handleFalseValue(leadsList[0]['priority'])
                      : '0'),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Tags',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 16),
                isEditing
                    ? Expanded(
                  child: CustomDropdown<String>.multiSelect(
                    hintText: 'Select Tags',
                    items: tags.map((t) => t['name'].toString()).toList(),
                    initialItems: _getNamesFromIds(selectedTagIds, tags),
                    onListChanged: (List<String> values) {
                      // Use a safe state update method
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          selectedTagIds = values.map((value) {
                            return tags.firstWhere((t) => t['name'] == value)['id'] as int;
                          }).toList();
                        });
                      });
                    },
                    decoration: const CustomDropdownDecoration(
                      closedBorder: Border.fromBorderSide(BorderSide()),
                    ),
                  ),
                )
                    : Wrap(
                  spacing: 8.0,
                  children: leadsList.isNotEmpty && leadsList[0]['tag_ids'] != false && leadsList[0]['tag_ids'].isNotEmpty
                      ? List<int>.from(leadsList[0]['tag_ids']).map((tagId) {
                    final tagName = tags.firstWhere(
                          (t) => t['id'] == tagId,
                      orElse: () => {'name': 'None'},
                    )['name'];
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(tagName),
                    );
                  }).toList()
                      : [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text('None'),
                    )
                  ],
                ),
              ],
            ),
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
                    labelColor: Color(0xFF9EA700),
                    unselectedLabelColor: Colors.black,
                    indicatorColor: Color(0xFF9EA700),
                  ),
                  SizedBox(
                    height: 350,
                    child: TabBarView(
                      children: [
                        const Center(child: Text('Internal Notes Content')),
                        SingleChildScrollView(
                          padding:
                          const EdgeInsets.symmetric(vertical: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'EMAIL',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const Divider(thickness: 1),
                              const SizedBox(height: 16),
                              _buildLabeledField(
                                context,
                                'Bounce',
                                leadsList.isNotEmpty
                                    ? _handleFalseValue(
                                    leadsList[0]['email_bounce'] ??
                                        '0')
                                    : '0',
                              ),
                              const SizedBox(height: 14),
                              const Text(
                                'MARKETING',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const Divider(thickness: 1),
                              const SizedBox(height: 14),
                              _buildLabeledField(
                                context,
                                'Company',
                                isEditing
                                    ? CustomDropdown<String>(
                                  hintText: 'Select Company',
                                  items: company.map((p) => p['name'].toString()).toList(),
                                  initialItem: _getNameFromId(selectedCompanyID, company),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCompanyID =
                                      company.firstWhere((p) => p['name'] == value)['id'];
                                    });
                                  },
                                )
                                    : leadsList.isNotEmpty
                                    ? _handleRelationalField(leadsList[0]['company_id'])
                                    : '',
                              ),
                              _buildLabeledField(
                                context,
                                'Campaign',
                                isEditing
                                    ? CustomDropdown<String>(
                                  hintText: 'Select Company',
                                  items: campaign.map((p) => p['name'].toString()).toList(),
                                  initialItem: _getNameFromId(selectedCampaignID, campaign),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCampaignID =
                                      campaign.firstWhere((p) => p['name'] == value)['id'];
                                    });
                                  },
                                )
                                    : leadsList.isNotEmpty
                                    ? _handleRelationalField(leadsList[0]['campaign_id'])
                                    : '',
                              ),
                              _buildLabeledField(
                                context,
                                'Medium',
                                isEditing
                                    ? CustomDropdown<String>(
                                  hintText: 'Select Company',
                                  items: medium.map((p) => p['name'].toString()).toList(),
                                  initialItem: _getNameFromId(selectedMediumID, medium),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedMediumID =
                                      medium.firstWhere((p) => p['name'] == value)['id'];
                                    });
                                  },
                                )
                                    : leadsList.isNotEmpty
                                    ? _handleRelationalField(leadsList[0]['medium_id'])
                                    : '',
                              ),
                              _buildLabeledField(
                                context,
                                'Source',
                                isEditing
                                    ? CustomDropdown<String>(
                                  hintText: 'Select Company',
                                  items: source.map((p) => p['name'].toString()).toList(),
                                  initialItem: _getNameFromId(selectedSourceId, source),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedSourceId =
                                      source.firstWhere((p) => p['name'] == value)['id'];
                                    });
                                  },
                                )
                                    : leadsList.isNotEmpty
                                    ? _handleRelationalField(leadsList[0]['source_id'])
                                    : '',
                              ),
                              _buildLabeledField(
                                context,
                                'Referred By',
                                isEditing
                                    ? TextField(
                                  controller: referController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                )
                                    : leadsList.isNotEmpty
                                    ? _handleFalseValue(leadsList[0]['referred'])
                                    : '',
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'ANALYSIS',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const Divider(thickness: 1),
                              const SizedBox(height: 14),
                              _buildLabeledField(
                                context,
                                'Assignment Date',
                                leadsList.isNotEmpty
                                    ? _handleFalseValue(
                                    leadsList[0]['date_assign'] ??
                                        'None')
                                    : 'None',
                              ),
                              _buildLabeledField(
                                context,
                                'Closed Date',
                                leadsList.isNotEmpty
                                    ? _handleFalseValue(
                                    leadsList[0]['date_closed'])
                                    : 'None',
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          padding:
                          const EdgeInsets.symmetric(vertical: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabeledField(
                                context,
                                'Geoloaction',
                                isEditing
                                    ? TextField(
                                  controller: geoLocController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                )
                                    : leadsList.isNotEmpty
                                    ? _handleFalseValue(leadsList[0]['partner_latitude'])
                                    : '',
                              ),
                              const SizedBox(height: 16),
                              _buildLabeledField(
                                context,
                                'Assigned Partner',
                                isEditing
                                    ? CustomDropdown<String>(
                                  hintText: 'Select Partner',
                                  items: Assigned.map((p) => p['name'].toString()).toList(),
                                  initialItem: _getNameFromId(selectedAssignedId,Assigned),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedAssignedId =
                                      Assigned.firstWhere((p) => p['name'] == value)['id'];
                                    });
                                  },
                                )
                                    : leadsList.isNotEmpty
                                    ? _handleRelationalField(leadsList[0]['partner_assigned_id'])
                                    : '',
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
          ],
        ),
      ),
    );
  }

  Widget _buildLabeledField(BuildContext context, String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: value is Widget
                ? value
                : Text(
              value.toString(),
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPriorityStars(String priority) {
    int stars = int.tryParse(priority) ?? 0;
    List<Widget> starWidgets = [];
    for (int i = 0; i < 3; i++) {
      starWidgets.add(
        Icon(
          i < stars ? Icons.star : Icons.star_border,
          color: Colors.amber,
        ),
      );
    }
    return starWidgets;
  }
}