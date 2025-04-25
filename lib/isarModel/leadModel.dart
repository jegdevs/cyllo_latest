import 'package:isar/isar.dart';

part 'leadModel.g.dart';

@collection
class Leadisar {
  Id id = Isar.autoIncrement;

  @Index()
  int? leadId;

  String? name;
  String? emailFrom;
  String? tagNames;
  String? city;
  List<int>? countryId;
  List<int>? userId;
  List<int>? partnerAssignedId;
  List<int>? teamId;
  String? contactName;
  String? priority;
  List<int>? tagIds;
  String? activityDateDeadline;
  double? expectedRevenue;
  List<int>? partnerId;
  List<int>? stageId;
  String? createDate;
  double? dayOpen;
  double? dayClose;
  double? recurringRevenueMonthly;
  double? probability;
  double? recurringRevenueMonthlyProrated;
  double? recurringRevenueProrated;
  double? proratedRevenue;
  double? recurringRevenue;
  List<int>? activityUserId;
  String? dateClosed;
  List<int>? activityIds;
}