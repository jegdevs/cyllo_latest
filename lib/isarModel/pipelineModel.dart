import 'package:isar/isar.dart';

part 'pipelineModel.g.dart';

@collection
class Newpipe {
  Id id = Isar.autoIncrement;

  int? leadId;
  String? name;
  String? type;
  double? expectedRevenue;
  List<int>? stageId;
  String? stageName; // New field
  List<int>? partnerId;
  String? partnerName; // New field
  List<int>? tagIds;
  String? priority;
  String? activityState;
  List<int>? activityTypeId;
  String? activityTypeName; // New field
  String? emailFrom;
  double? recurringRevenueMonthly;
  String? contactName;
  List<int>? activityIds;
  String? activityDateDeadline;
  String? createDate;
  double? dayOpen;
  double? dayClose;
  double? probability;
  double? recurringRevenueMonthlyProrated;
  double? recurringRevenueProrated;
  double? proratedRevenue;
  double? recurringRevenue;
  List<int>? activityUserId;
  String? dateClosed;
  int? userId;
  List<int>? teamId;
  String? phone;
  String? imageData;
}

@collection
class UserImage {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  int? userId;

  List<byte>? imageData;
}

@collection
class Tag {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  int? tagId;

  String? name;
}