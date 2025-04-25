import 'dart:convert';
import 'dart:developer';
import 'package:cyllo_mobile/Login/demo.dart';
import 'package:cyllo_mobile/Profile/editProfile.dart';
import 'package:cyllo_mobile/isarModel/profileModel.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';
import 'package:shimmer/shimmer.dart';

import '../Login/login.dart';
import '../getUserImage.dart';
import '../main.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  OdooClient? client;
  bool isLoading = true;
  String? email;
  String? phone;
  String? loaction;
  String? name;
  Uint8List? profileImage;
  String? privateAddress, privateAddress2, privateAddress3, zipCode, country;
  String? department;
  String? gender;
  String? dob;
  int? usid;
  final Color primaryColor = Color(0xFF9EA700);
  final Color backgroundColor = Colors.white;
  final Color cardBgColor = Color(0x1B9EA700);

  Future<void> initializeOdooClient() async {
    final prefs = await SharedPreferences.getInstance();
    final baseUrl = prefs.getString("urldata") ?? "";
    final dbName = prefs.getString("selectedDatabase") ?? "";
    final userLogin = prefs.getString("userLogin") ?? "";
    final userPassword = prefs.getString("password") ?? "";
    final userId = prefs.getInt("userId") ?? 0;

    usid = userId;
    if (baseUrl.isNotEmpty &&
        dbName.isNotEmpty &&
        userLogin.isNotEmpty &&
        userPassword.isNotEmpty) {
      client = OdooClient(baseUrl);
      try {
        final auth =
            await client!.authenticate(dbName, userLogin, userPassword);
        print("Odoo Authenticated: $auth");
        await getProfileData(userId);
      } catch (e) {
        await loadFromIsar();
        print("Odoo Authentication Failed: $e");
      }
    }
  }

  Future<void> loadFromIsar() async {
    setState(() => isLoading = true);
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userId") ?? 0;

    try {
      final profile =
          await isar?.userProfiles.where().userIdEqualTo(userId).findFirst();
      if (profile != null) {
        setState(() {
          email = profile.email;
          phone = profile.phone;
          loaction = profile.location;
          name = profile.name;
          profileImage = profile.profileImage != null
              ? Uint8List.fromList(profile.profileImage!)
              : null;
          privateAddress = profile.privateAddress;
          privateAddress2 = profile.privateAddress2;
          privateAddress3 = profile.privateAddress3;
          zipCode = profile.zipCode;
          country = profile.country;
          department = profile.department;
          gender = profile.gender;
          dob = profile.dob;
        });
        print("Loaded profile for user $userId from Isar");
      } else {
        print("No profile found in Isar for user $userId");
      }
    } catch (e) {
      log("Isar Load Failed: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> getProfileData(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getInt("userId") ?? "";
    print('iddddd$userid');
    try {
      final response = await client?.callKw({
        'model': 'res.users',
        'method': 'search_read',
        'args': [
          [
            ["id", "=", userid],
          ]
        ],
        'kwargs': {
          'fields': [
            'work_email',
            'work_phone',
            'work_location_id',
            'name',
            'employee_parent_id',
            'image_1920',
            'private_street',
            'private_city',
            'private_state_id',
            'private_zip',
            'private_country_id',
            'department_id',
            'gender',
            'birthday'
          ]
        },
      });
      log('frst response$response');
      if (response == null || response.isEmpty || response is! List) {
        print('No data received or invalid format');
        setState(() => isLoading = false);
        return;
      }

      final List<Map<String, dynamic>> data =
          List<Map<String, dynamic>>.from(response);
      final profileData = data[0];

      // Update UI
      setState(() {
        email = profileData['work_email'];
        phone = profileData['work_phone'];
        var locationData = profileData['work_location_id'];
        loaction = locationData != null &&
                locationData is List &&
                locationData.isNotEmpty
            ? locationData[1]
            : locationData?.toString();
        name = profileData['name'];
        var imageData = profileData['image_1920'];
        profileImage = imageData != null && imageData is String
            ? base64Decode(imageData)
            : null;
        privateAddress = profileData['private_street'];
        privateAddress2 = profileData['private_city'];
        var privateAddressState = profileData['private_state_id'];
        privateAddress3 = privateAddressState != null &&
                privateAddressState is List &&
                privateAddressState.isNotEmpty
            ? privateAddressState[1]
            : privateAddressState?.toString();
        zipCode = profileData['private_zip'];
        var country1 = profileData['private_country_id'];
        country = country1 != null && country1 is List && country1.isNotEmpty
            ? country1[1]
            : country1?.toString();
        var departments = profileData['department_id'];
        department =
            departments != null && departments is List && departments.isNotEmpty
                ? departments[1]
                : departments?.toString();
        gender = profileData['gender'];
        dob = profileData['birthday'];
      });

      // Save to Isar
      await isar?.writeTxn(() async {
        await isar?.userProfiles.where().userIdEqualTo(userId).deleteAll();

        final profile = UserProfile()
          ..userId = userId
          ..email = profileData['work_email']
          ..phone = profileData['work_phone']
          ..location = profileData['work_location_id'] is List &&
                  profileData['work_location_id'].isNotEmpty
              ? profileData['work_location_id'][1]
              : profileData['work_location_id']?.toString()
          ..name = profileData['name']
          // ..profileImage = profileData['image_1920'] != null && profileData['image_1920'] is String
          //     ? base64Decode(profileData['image_1920'])
          //     : null
          ..profileImage = profileData['image_1920'] != null &&
                  profileData['image_1920'] is String
              ? base64Decode(profileData['image_1920'])
                  .toList() // Convert Uint8List to List<int>
              : null
          ..privateAddress = profileData['private_street']
          ..privateAddress2 = profileData['private_city']
          ..privateAddress3 = profileData['private_state_id'] is List &&
                  profileData['private_state_id'].isNotEmpty
              ? profileData['private_state_id'][1]
              : profileData['private_state_id']?.toString()
          ..zipCode = profileData['private_zip']
          ..country = profileData['private_country_id'] is List &&
                  profileData['private_country_id'].isNotEmpty
              ? profileData['private_country_id'][1]
              : profileData['private_country_id']?.toString()
          ..department = profileData['department_id'] is List &&
                  profileData['department_id'].isNotEmpty
              ? profileData['department_id'][1]
              : profileData['department_id']?.toString()
          ..gender = profileData['gender']
          ..dob = profileData['birthday'];

        await isar?.userProfiles.put(profile);
        print('Saved profile for user $userId to Isar');
      });
    } catch (e) {
      print("Error fetching profile data: $e");
      setState(() => isLoading = false);
    }
  }

  Future<void> logout() async {
    // Show confirmation dialog
    bool confirm = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text('Logout'),
            content: Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text('Logout'),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          );
        });

    if (confirm == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Login()),
        (route) => false,
      );
    }
  }

  Widget shimmerLoad() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: CircleAvatar(
                radius: 60.0,
                backgroundColor: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Container(
              height: 24.0,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Container(
              height: 16.0,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          SizedBox(height: 20),
          ...List.generate(5, (index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Container(
                height: 80.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }),
        ]),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadFromIsar();
    initializeOdooClient();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Demo()));
          },
          icon: Icon(Icons.navigate_before, color: Colors.white, size: 28),
        ),
        actions: [
          IconButton(
            onPressed: logout,
            icon: Icon(Icons.logout, color: Colors.white),
          ),
          SizedBox(width: 5),
        ],
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? shimmerLoad()
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Profile header with gradient background
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [primaryColor, primaryColor.withOpacity(0.1)],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0, -80),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 4.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            backgroundImage: profileImage != null
                                ? MemoryImage(profileImage!)
                                : AssetImage('assets/pf.jpeg') as ImageProvider,
                            radius: 60.0,
                          ),
                        ),
                        SizedBox(height: 10),
                        // Name and designation
                        Text(
                          name ?? 'User',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Chief Executive Officer',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 10),
                        // Edit profile button
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Editprofile()));
                          },
                          icon: Icon(Icons.edit),
                          label: Text('Edit Profile'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 3,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),

                        // Information cards
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              // Personal Information Card
                              buildInfoCard(
                                title: 'Personal Information',
                                icon: Icons.person,
                                children: [
                                  buildInfoTile(
                                    icon: Icons.male_rounded,
                                    title: 'Gender',
                                    subtitle: gender ?? 'Not available',
                                  ),
                                  buildInfoTile(
                                    icon: Icons.date_range_rounded,
                                    title: 'Date of Birth',
                                    subtitle: dob ?? 'Not available',
                                  ),
                                  buildInfoTile(
                                    icon: Icons.email,
                                    title: 'Work Email',
                                    subtitle: email ?? 'Not available',
                                  ),
                                  buildInfoTile(
                                    icon: Icons.phone,
                                    title: 'Work Phone',
                                    subtitle: phone ?? 'Not available',
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              // Location Information Card
                              buildInfoCard(
                                title: 'Location & Department',
                                icon: Icons.location_on,
                                children: [
                                  buildInfoTile(
                                    icon: Icons.location_city,
                                    title: 'Work Location',
                                    subtitle: loaction ?? 'Not available',
                                  ),
                                  buildInfoTile(
                                    icon: Icons.home,
                                    title: 'Private Address',
                                    subtitle: (privateAddress != null)
                                        ? '${privateAddress}, ${privateAddress2 ?? ''}, ${privateAddress3 ?? ''}, ${zipCode ?? ''}, ${country ?? ''}'
                                        : 'Not available',
                                  ),
                                  buildInfoTile(
                                    icon: Icons.business,
                                    title: 'Department',
                                    subtitle: department ?? 'Not available',
                                  ),
                                ],
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

  Widget buildInfoCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: primaryColor,
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey.withOpacity(0.2)),
          // Card content
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget buildInfoTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 20,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
