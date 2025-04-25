import 'package:isar/isar.dart';

part 'teamsModel.g.dart';

@collection
class SalesTeamIsar {
  Id id = Isar.autoIncrement;

  @Index()
  int? teamId;

  String? name;
  double? invoicedTarget;
  int? unassignedLeads;
  int? openOpportunities;
  double? openOpportunitiesAmount;
  int? overdueOpportunities;
  double? overdueOpportunitiesAmount;
  int? quotationsCount;
  double? quotationsAmount;
  int? ordersToInvoice;
  double? invoicingCurrent;
  String? weeklyOpportunityDataJson; // Store as JSON string
  String? dateRangesJson; // Store as JSON string
  String? barGroupsJson; // Store as JSON string
  bool? hasBarData;
}