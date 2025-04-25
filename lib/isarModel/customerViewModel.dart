import 'package:isar/isar.dart';

part 'customerViewModel.g.dart';

@collection
class Customer {
  Id id = Isar.autoIncrement; // Auto-incrementing ID for Isar

  @Index(unique: true) // Assuming Odoo ID is unique
  int? odooId; // Odoo record ID

  String? name;
  String? email;
  String? phone;
  String? city;
  List<int>? categoryIds;
  String? image128;
  String? companyType;
  int? companyId;
  String? companyName;
  int? commercialPartnerId;
  String? commercialPartnerName;
  String? function;
  bool? isCompany;
  int? customerRank;
  int? supplierRank;
  bool? active;
  int? countryId;
  String? countryName;
  int? stateId;
  String? stateName;

// Add other fields as needed
}

@collection
class Activity {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late int odooId;

  late int customerId; // Links to Customer.odooId
  int? activityTypeId;
  String? activityTypeName;
  String? dateDeadline;
  String? summary;
  int? userId;
  String? userName;
  String? userImage;
}

@collection
class Category {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late int odooId;

  String? name;
  String? parentPath;
}