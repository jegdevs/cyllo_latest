import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import 'myPipeline.dart';
import 'myQuotations.dart';

class SalesTeam extends StatefulWidget {
  const SalesTeam({super.key});

  @override
  State<SalesTeam> createState() => _SalesTeamState();
}

class _SalesTeamState extends State<SalesTeam> {
  int? currentUserId;
  List<dynamic> salesTeams = [];
  bool isLoading = false;
  OdooClient? client;
  bool showArchived = false;
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    initializeOdooClient();
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (searchController.text.isNotEmpty) {
        _searchSalesTeams(searchController.text);
      } else {
        fetchAllSalesTeamsData();
      }
    });
  }

  Future<void> _searchSalesTeams(String query) async {
    if (client == null) return;

    setState(() => isLoading = true);
    try {
      List domain = [
        ['use_opportunities', '=', true],
        ['name', 'ilike', query],
        if (showArchived) ['active', '=', false],
      ];
      final teamsResponse = await client!.callKw({
        'model': 'crm.team',
        'method': 'search_read',
        'args': [domain],
        'kwargs': {
          'fields': ['id', 'name', 'invoiced_target'],
        },
      });

      if (teamsResponse != null) {
        List<dynamic> updatedTeams = [];
        for (var team in teamsResponse) {
          final teamData = await fetchSalesTeamData(team['id']);
          var updatedTeam = Map<String, dynamic>.from(team);
          updatedTeam.addAll(teamData);
          updatedTeams.add(updatedTeam);
        }

        setState(() {
          salesTeams = updatedTeams;
        });
      }
    } catch (e) {
      print('Error searching sales teams: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error searching sales teams: $e")),
      );
    }
    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  Future<void> initializeOdooClient() async {
    setState(() => isLoading = true);
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
        await client!.authenticate(dbName, userLogin, userPassword);
        await fetchAllSalesTeamsData();
      } catch (e) {
        print("Odoo Authentication Failed: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to connect to Odoo: $e")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Missing connection details")),
      );
    }
    setState(() => isLoading = false);
  }

  Map<String, Map<String, dynamic>> getFilters() {
    return {
      'archived': {
        'name': 'Show Archived',
        'domain': [
          ['active', '=', false]
        ]
      },
    };
  }

  Future<void> fetchAllSalesTeamsData() async {
    try {
      List domain = [];
      domain.add(['use_opportunities', '=', true]);
      if (showArchived) {
        domain.add(['active', '=', false]);
      }
      final teamsResponse = await client?.callKw({
        'model': 'crm.team',
        'method': 'search_read',
        'args': [domain],
        'kwargs': {
          'fields': ['id', 'name', 'invoiced_target'],
        },
      });
      print("ckkkkk$teamsResponse");

      if (teamsResponse != null) {
        List<dynamic> updatedTeams = [];
        for (var team in teamsResponse) {
          print('Team basic data: $team');

          final teamData = await fetchSalesTeamData(team['id']);
          print('Team data for ${team['name']}: $teamData');

          var updatedTeam = Map<String, dynamic>.from(team);
          updatedTeam.addAll(teamData);
          updatedTeams.add(updatedTeam);
        }

        setState(() {
          salesTeams = updatedTeams;
        });
      }
    } catch (e) {
      print('Error fetching sales teams: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching sales teams: $e")),
      );
    }
  }

  Future<Map<String, dynamic>> fetchSalesTeamData(int teamId) async {
    try {
      final now = DateTime.now();
      final currentYear = now.year;
      final currentMonth = now.month;

      List<Map<String, dynamic>> dateRanges = generateDateRanges(4);

      Map<String, int> weeklyOpportunityData = {};
      for (var range in dateRanges) {
        weeklyOpportunityData[range['label']] = 0;
      }

      final unassignedLeadsCount = await client?.callKw({
        'model': 'crm.lead',
        'method': 'search_count',
        'args': [
          [
            ['team_id', '=', teamId],
            ['user_id', '=', false],
            ['type', '=', 'lead'],
          ]
        ],
        'kwargs': {},
      });

      final openOpps = await client?.callKw({
        'model': 'crm.lead',
        'method': 'search_read',
        'args': [
          [
            ['team_id', '=', teamId],
            ['type', '=', 'opportunity'],
            ['stage_id.is_won', '=', false],
          ]
        ],
        'kwargs': {
          'fields': ['id', 'expected_revenue', 'create_date'],
        },
      });

      double openOppsAmount = 0.0;
      if (openOpps != null) {
        for (var opp in openOpps) {
          if (opp['expected_revenue'] != null) {
            openOppsAmount += (opp['expected_revenue'] is int)
                ? (opp['expected_revenue'] as int).toDouble()
                : (opp['expected_revenue'] as double? ?? 0.0);

            if (opp['create_date'] != null) {
              final createDate = DateTime.parse(opp['create_date'].toString());

              for (var range in dateRanges) {
                if (createDate.isAfter(range['start']) &&
                    createDate.isBefore(range['end'])) {
                  weeklyOpportunityData[range['label']] =
                      (weeklyOpportunityData[range['label']] ?? 0) + 1;
                  break;
                }
              }
            }
          }
        }
      }

      final today = DateTime.now().toIso8601String().split('T')[0];
      final overdueOpps = await client?.callKw({
        'model': 'crm.lead',
        'method': 'search_read',
        'args': [
          [
            ['team_id', '=', teamId],
            ['type', '=', 'opportunity'],
            ['date_deadline', '<', today],
            ['stage_id.is_won', '=', false],
          ]
        ],
        'kwargs': {
          'fields': ['id', 'expected_revenue'],
        },
      });

      double overdueOppsAmount = 0.0;
      if (overdueOpps != null) {
        for (var opp in overdueOpps) {
          if (opp['expected_revenue'] != null) {
            overdueOppsAmount += (opp['expected_revenue'] is int)
                ? (opp['expected_revenue'] as int).toDouble()
                : (opp['expected_revenue'] as double? ?? 0.0);
          }
        }
      }

      final quotations = await client?.callKw({
        'model': 'sale.order',
        'method': 'search_read',
        'args': [
          [
            ['team_id', '=', teamId],
            [
              'state',
              'in',
              ['sent', 'draft']
            ],
          ]
        ],
        'kwargs': {
          'fields': ['id', 'amount_total', 'date_order'],
        },
      });

      double quotationsAmount = 0.0;
      if (quotations != null) {
        for (var quote in quotations) {
          if (quote['amount_total'] != null) {
            quotationsAmount += (quote['amount_total'] is int)
                ? (quote['amount_total'] as int).toDouble()
                : (quote['amount_total'] as double? ?? 0.0);
          }
        }
      }

      final ordersToInvoiceCount = await client?.callKw({
        'model': 'sale.order',
        'method': 'search_count',
        'args': [
          [
            ['team_id', '=', teamId],
            [
              'state',
              'in',
              ['sale', 'done']
            ],
            ['invoice_status', '=', 'to invoice'],
          ]
        ],
        'kwargs': {},
      });

      bool useInvoiceTeamId = true;
      try {
        final fields = await client?.callKw({
          'model': 'ir.model.fields',
          'method': 'search_read',
          'args': [
            [
              ['model', '=', 'account.move'],
              ['name', '=', 'invoice_team_id'],
            ]
          ],
          'kwargs': {
            'fields': ['name'],
          },
        });
        useInvoiceTeamId = fields != null && fields.isNotEmpty;
      } catch (e) {
        print('Error checking field existence: $e');
        useInvoiceTeamId = false;
      }
      final teamField = useInvoiceTeamId ? 'invoice_team_id' : 'team_id';

      final invoicedAmount = await client?.callKw({
        'model': 'account.move',
        'method': 'search_read',
        'args': [
          [
            [teamField, '=', teamId],
            ['move_type', '=', 'out_invoice'],
            ['state', '=', 'posted'],
            [
              'invoice_date',
              '>=',
              DateTime(DateTime.now().year, 1, 1)
                  .toIso8601String()
                  .split('T')[0]
            ],
            [
              'invoice_date',
              '<=',
              DateTime(DateTime.now().year, 12, 31)
                  .toIso8601String()
                  .split('T')[0]
            ],
          ]
        ],
        'kwargs': {
          'fields': ['id', 'amount_total', 'invoice_date'],
        },
      });

      double invoicedTotal = 0.0;
      if (invoicedAmount != null) {
        for (var inv in invoicedAmount) {
          if (inv['amount_total'] != null) {
            invoicedTotal += (inv['amount_total'] is int)
                ? (inv['amount_total'] as int).toDouble()
                : (inv['amount_total'] as double? ?? 0.0);
          }
        }
      }

      weeklyOpportunityData.removeWhere((key, value) => value == 0);

      final barGroups =
          prepareWeeklyOpportunityData(weeklyOpportunityData, dateRanges);

      return {
        'unassignedLeads': unassignedLeadsCount ?? 0,
        'openOpportunities': openOpps?.length ?? 0,
        'openOpportunitiesAmount': openOppsAmount,
        'overdueOpportunities': overdueOpps?.length ?? 0,
        'overdueOpportunitiesAmount': overdueOppsAmount,
        'quotationsCount': quotations?.length ?? 0,
        'quotationsAmount': quotationsAmount,
        'ordersToInvoice': ordersToInvoiceCount ?? 0,
        'invoicingCurrent': invoicedTotal,
        'barGroups': barGroups,
        'dateRanges': dateRanges,
        'weeklyOpportunityData': weeklyOpportunityData,
        'hasBarData': barGroups.isNotEmpty,
      };
    } catch (e) {
      print('Error fetching sales team $teamId details: $e');
      return {};
    }
  }

  List<Map<String, dynamic>> generateDateRanges(int numberOfWeeks) {
    List<Map<String, dynamic>> result = [];
    final now = DateTime.now();

    DateTime latestWeekStart = now.subtract(Duration(days: now.weekday % 7));

    DateTime firstVisibleWeekStart =
        latestWeekStart.subtract(Duration(days: (numberOfWeeks - 1) * 7));

    for (int i = 0; i < numberOfWeeks; i++) {
      final startDate = firstVisibleWeekStart.add(Duration(days: i * 7));
      final endDate = startDate.add(Duration(days: 6));

      final startDay = startDate.day;
      final endDay = endDate.day;
      final monthStart = DateFormat('MMM').format(startDate);
      final monthEnd = DateFormat('MMM').format(endDate);

      final label = monthStart == monthEnd
          ? "$startDay-$endDay $monthEnd"
          : "$startDay $monthStart-$endDay $monthEnd";

      result.add({
        'label': label,
        'start': startDate,
        'end': endDate.add(Duration(days: 1)),
      });
      print('date ranegeee$label');
    }

    return result;
  }

  List<BarChartGroupData> prepareWeeklyOpportunityData(
      Map<String, int> weeklyData, List<Map<String, dynamic>> dateRanges) {
    final List<BarChartGroupData> result = [];

    for (int i = 0; i < dateRanges.length; i++) {
      final String label = dateRanges[i]['label'];
      int value = weeklyData[label] ?? 0;

      result.add(createBarGroup(i, value.toDouble(), label));
    }

    return result;
  }

  BarChartGroupData createBarGroup(int x, double y, String label) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: const Color(0xFFADDEEC),
          width: 20,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
      ],
    );
  }

  void showFilterDialog(BuildContext context) {
    bool tempShowArchived = showArchived;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.white,
          title: Text(
            "Select Filter",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[800],
            ),
          ),
          content: StatefulBuilder(
            builder: (context, setDialogState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CheckboxListTile(
                    title: Text(
                      "Archived",
                      style: TextStyle(color: Colors.blueGrey[800]),
                    ),
                    value: tempShowArchived,
                    activeColor: Colors.blue,
                    onChanged: (bool? value) {
                      setDialogState(() {
                        tempShowArchived = value ?? false;
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actionsPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(foregroundColor: Colors.grey[600]),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showArchived = tempShowArchived;
                });
                Navigator.pop(context);
                fetchAllSalesTeamsData(); // Refresh data with new filter
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF9EA700),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Text("Apply", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        // title: const Text('Sales Teams'),
        backgroundColor: Color(0xFF9EA700),
        elevation: 4,
        // Add some elevation for depth
        title: isSearching
            ? TextField(
                controller: searchController,
                autofocus: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              )
            : Text(
                'Sales Teams', // Creative title
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search,color: Colors.white,),
            color: Colors.black,
            onPressed: () {
              setState(() {
                if (isSearching) {
                  searchController.clear();
                  isSearching = false;
                } else {
                  isSearching = true;
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list,color: Colors.white,),
            color: Colors.black,
            onPressed: () => showFilterDialog(context),
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF9EA700), Color(0xFFB0BF00)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: Color(0xFF9EA700),
                size: 100,
              ),
            )
          : salesTeams.isEmpty
              ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset('assets/nodata.png')),
          Text(
            "No sales team found",
            style: TextStyle(color: Colors.blueGrey),
          ),
        ],
      )
              : SingleChildScrollView(
                  child: Column(
                    children: salesTeams
                        .map((team) => Padding(
                              padding: const EdgeInsets.all(16),
                              child: buildTeamSection(team),
                            ))
                        .toList(),
                  ),
                ),
    );
  }

  Widget buildTeamSection(dynamic team) {
    final teamData = team as Map<String, dynamic>;
    print('Building team section with data: $teamData');

    final barGroups = teamData['barGroups'] as List<BarChartGroupData>? ?? [];
    final hasGraphData = barGroups.isNotEmpty &&
        barGroups.any((group) => group.barRods.any((rod) => rod.toY > 0));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSalesCard(teamData),
        const SizedBox(height: 16),
        if (hasGraphData) buildGraphCard(teamData),
        const SizedBox(height: 16),
        buildInvoicingCard(
          teamData['name'] ?? 'Unknown Team',
          teamData['invoicingCurrent'] ?? 0.0,
          teamData['invoiced_target'] ?? 0.0,
        ),
      ],
    );
  }

  Widget buildSalesCard(Map<String, dynamic> team) {
    final currencyFormat = NumberFormat.currency(symbol: '', decimalDigits: 2);
    final today = DateTime.now().toIso8601String().split('T')[0];
    final teamId = team['id'] as int;

    List<Widget> pipelineItems = [];

    // Unassigned Leads
    if ((team['unassignedLeads'] ?? 0) > 0) {
      final unassignedLeadsFilter = [
        ["team_id", "=", teamId],
        ["user_id", "=", false],
        ["type", "=", "lead"]
      ];
      pipelineItems.add(buildPipelineRow(
        '${team['unassignedLeads']} Unassigned Lead${(team['unassignedLeads'] ?? 0) != 1 ? 's' : ''}',
        '',
        onTap: () {
          if (client == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Odoo client not initialized')),
            );
            return;
          }
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => UnassignedLeadsView(
          //       teamId: teamId,
          //       filter: unassignedLeadsFilter,
          //       client: client!,
          //     ),
          //   ),
          // );
        },
      ));
    }

    // Open Opportunities
    if ((team['openOpportunities'] ?? 0) > 0) {
      final openOpportunitiesDomain = [
        ['team_id', '=', teamId],
        ['probability', '<', 100],
        ['type', '=', 'opportunity'],
      ];
      pipelineItems.add(buildPipelineRow(
        '${team['openOpportunities']} Open Opportunit${(team['openOpportunities'] ?? 0) != 1 ? 'ies' : 'y'}',
        currencyFormat.format(team['openOpportunitiesAmount'] ?? 0),
        onTap: () {
          if (client == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Odoo client not initialized')),
            );
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Mypipeline(
                teamId: teamId,
                domain: openOpportunitiesDomain,
                title: 'Open Opportunities',
              ),
            ),
          );
        },
      ));
    }
    if ((team['overdueOpportunities'] ?? 0) > 0) {
      final overdueOpportunitiesFilter = [
        ["team_id", "=", teamId],
        ["type", "=", "opportunity"],
        ["date_deadline", "<", today],
        ["stage_id.is_won", "=", false]
      ];
      pipelineItems.add(buildPipelineRow(
        '${team['overdueOpportunities']} Overdue Opportunit${(team['overdueOpportunities'] ?? 0) != 1 ? 'ies' : 'y'}',
        currencyFormat.format(team['overdueOpportunitiesAmount'] ?? 0),
        onTap: () {
          if (client == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Odoo client not initialized')),
            );
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Mypipeline(
                teamId: teamId,
                domain: overdueOpportunitiesFilter,
              ),
            ),
          );
        },
      ));
    }

    if ((team['quotationsCount'] ?? 0) > 0) {
      final quotationsFilter = [
        ["team_id", "=", teamId],
        [
          "state",
          "in",
          ["draft", "sent"]
        ]
      ];
      pipelineItems.add(buildPipelineRow(
        '${team['quotationsCount']} Quotation${(team['quotationsCount'] ?? 0) != 1 ? 's' : ''}',
        currencyFormat.format(team['quotationsAmount'] ?? 0),
        onTap: () {
          if (client == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Odoo client not initialized')),
            );
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Myquotations(
                teamId: teamId,
                domain: quotationsFilter,
                applyUserFilter: false,
              ),
            ),
          );
        },
      ));
    }

    // Orders to Invoice
    if ((team['ordersToInvoice'] ?? 0) > 0) {
      final ordersToInvoiceFilter = [
        ["team_id", "=", teamId],
        [
          "state",
          "in",
          ["sale", "done"]
        ],
        ["invoice_status", "=", "to invoice"]
      ];
      pipelineItems.add(buildPipelineRow(
        '${team['ordersToInvoice']} Order${(team['ordersToInvoice'] ?? 0) != 1 ? 's' : ''} to Invoice',
        '',
        onTap: () {
          if (client == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Odoo client not initialized')),
            );
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Myquotations(
                teamId: teamId,
                domain: ordersToInvoiceFilter,
              ),
            ),
          );
        },
      ));
    }

    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  team['name'] ?? 'Unknown Team',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB0BF00),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Mypipeline(
                      teamId: team['id'] as int,
                    ),
                  ),
                );
              },
              child: const Text('Pipeline'),
            ),
          ),
          const SizedBox(height: 16),
          if (pipelineItems.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: pipelineItems,
              ),
            )
          else
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text('No pipeline data available'),
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget buildPipelineRow(String title, String amount, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(color:  Color(0xFF9EA700),),
            ),
            Text(
              amount,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGraphCard(Map<String, dynamic> team) {
    final barGroups = team['barGroups'] as List<BarChartGroupData>;
    final dateRanges = team['dateRanges'] as List<Map<String, dynamic>>? ?? [];
    final weeklyData =
        team['weeklyOpportunityData'] as Map<String, dynamic>? ?? {};

    final List<String> labels =
        dateRanges.map((range) => range['label'] as String).toList();

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'New Opportunities',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: buildWeeklyBarChart(barGroups, labels),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildWeeklyBarChart(
      List<BarChartGroupData> barGroups, List<String> labels) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: barGroups.isEmpty
          ? Center(child: Text('No data available for chart'))
          : BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceBetween,
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300]!),
                    left: BorderSide.none,
                    right: BorderSide.none,
                    top: BorderSide.none,
                  ),
                ),
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= labels.length) {
                          return const SizedBox();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            labels[index],
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 10,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                barGroups: barGroups,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '${rod.toY.toStringAsFixed(0)} opps',
                        TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                  handleBuiltInTouches: false,
                  touchCallback: (FlTouchEvent event, barTouchResponse) {
                    if (event is FlLongPressStart &&
                        barTouchResponse?.spot != null) {
                      // Show tooltip only on long press
                    }
                  },
                ),
              ),
            ),
    );
  }

  Widget buildInvoicingCard(String teamName, double current, double target) {
    final percentage = target > 0 ? (current / target * 100).clamp(0, 100) : 0;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Invoicing',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${(current / 1000).toStringAsFixed(0)} / ${(target / 1000).toStringAsFixed(0)}k',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Stack(
              children: [
                Container(
                  height: 8,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: percentage / 100,
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: const Color(0xFFB0BF00),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
