


import 'package:isar/isar.dart';

part 'profileModel.g.dart';


@Collection()
class UserProfile {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  int? userId;
  String? email;
  String? phone;
  String? location;
  String? name;
  List<int>? profileImage;
  String? privateAddress;
  String? privateAddress2;
  String? privateAddress3;
  String? zipCode;
  String? country;
  String? department;
  String? gender;
  String? dob;
}