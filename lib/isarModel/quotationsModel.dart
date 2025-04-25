import 'package:isar/isar.dart';

part 'quotationsModel.g.dart';

@collection
class SaleOrder {
  Id id = Isar.autoIncrement;

  String? name;
  List<int>? partnerId;
  String? partnerName;
  String? createDate;
  List<int>? userId;
  String? userName;
  List<int>? companyId;
  String? companyName;
  double? amountTotal;
  String? state;
  List<int>? activityTypeId;
  String? activityTypeName;
  String? activitySummary;
  String? activityDateDeadline;
  String? dateOrder;
  double? amountToInvoice;
  double? currencyRate;
  double? prepaymentPercent;
  double? shippingWeight;
  double? amountTax;
  double? amountUntaxed;
}