import 'dart:convert';
import 'dart:developer';
import 'package:cyllo_mobile/Login/demo.dart';
import 'package:cyllo_mobile/Profile/editProfile.dart';
import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';

import 'package:shimmer/shimmer.dart';

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

  Future<void> initializeOdooClient() async {
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
        final auth =
            await client!.authenticate(dbName, userLogin, userPassword);
        print("Odoo Authenticated: $auth");
        await getProfileData();
      } catch (e) {
        print("Odoo Authentication Failed: $e");
      }
    }
    setState(() => isLoading = false);
  }

  Future<void> getProfileData() async {
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
      try {
        final List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(response);
        setState(() {
          email = data[0]['work_email'];
          phone = data[0]['work_phone'];
          var locationData = data[0]['work_location_id'];
          if (locationData != null &&
              locationData is List &&
              locationData.isNotEmpty) {
            loaction = locationData[1];
          } else {
            loaction = locationData?.toString();
          }
          name = data[0]['name'];
          var imageData = data[0]['image_1920'];
          if (imageData != null && imageData is String) {
            profileImage = base64Decode(imageData);
            print('imageeeeee$profileImage');
          }
          privateAddress = data[0]['private_street'];
          privateAddress2 = data[0]['private_city'];
          var privateAddressState = data[0]['private_state_id'];
          if (privateAddressState != null &&
              privateAddressState is List &&
              privateAddressState.isNotEmpty) {
            privateAddress3 = privateAddressState[1];
          } else {
            privateAddress3 = privateAddressState.toString();
          }
          zipCode = data[0]['private_zip'];
          var country1 = data[0]['private_country_id'];
          if (country1 != null && country1 is List && country1.isNotEmpty) {
            country = country1[1];
          } else {
            country = country1.toString();
          }
          var departments = data[0]['department_id'];
          if (departments != null &&
              departments is List &&
              departments.isNotEmpty) {
            department = departments[1];
          } else {
            department = departments.toString();
          }
          gender = data[0]['gender'];
          dob = data[0]['birthday'];
          print('Email: $email');
          print('Phone: $phone');
          print('Location: $loaction');
          print('Address:$privateAddress');
        });
        print('dataaaaaaaaaaaaa$data');
        print('response$response');
      } catch (e) {
        print("Odoo fetch Failed: $e");
      }
    } catch (e) {
      print("Error processing forecast data ");
      setState(() => isLoading = false);
    }
  }

  Widget SimmerLoad() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: CircleAvatar(
                radius: 100.0,
                backgroundColor: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Container(
              height: 15.0,
              width: 150,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Container(
              height: 12.0,
              width: 130,
              color: Colors.white,
            ),
          ),
          ...List.generate(5, (index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Container(
                height: 79.0,
                width: 500,
                color: Colors.white,
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
    initializeOdooClient();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          // IconButton(
          //     onPressed: () {
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (context) => Editprofile()));
          //     },
          //     icon: Icon(Icons.edit)),
          SizedBox(
            width: 5,
          ),
        ],
        backgroundColor: Color(0xFF9EA700),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Demo()));
            },
            icon: Icon(Icons.navigate_before)),
        title: Text('Profile'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: isLoading
          ? SimmerLoad()
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [new BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 14.0,
                            ),],
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 130,
                          width: 500,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 8,
                              ),
                              CircleAvatar(
                                backgroundImage: profileImage != null
                                    ? MemoryImage(profileImage!)
                                    : AssetImage('assets/pf.jpeg')
                                        as ImageProvider,
                                radius: 50.0,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20,),
                                  Text(
                                    name!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                  SizedBox(height: 5,),
                                  Text('Chief Executive Officer'),
                                  SizedBox(height: 3,),
                                  ElevatedButton(onPressed: (){
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => Editprofile()));
                                  },
                                    child: Text('Edit profile'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:  Color(0xFF9EA700),
                                      foregroundColor: Colors.white,
                                      shape:RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                          side: BorderSide(color: Color(0xFF9EA700)),
                                      ),
                                    ) ,),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 300,
                          width: 500,
                          decoration: BoxDecoration(
                            color: Color(0x1B9EA700),
                            borderRadius: BorderRadius.circular(10),
                              boxShadow: [new BoxShadow(
                                color:Color(0x1B9EA700),
                                blurRadius: 20.0,
                              ),]
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(
                                  Icons.male_rounded,
                                  color: Color(0xFF9EA700),
                                ),
                                title: Text('Gender'),
                                subtitle: Text(gender ?? 'Not available'),
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.date_range_rounded,
                                  color: Color(0xFF9EA700),
                                ),
                                title: Text('Date of Birth'),
                                subtitle: Text(dob ?? 'Not available'),
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.email,
                                  color: Color(0xFF9EA700),
                                ),
                                title: Text('Work Email'),
                                subtitle: Text(email!),
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.phone,
                                  color: Color(0xFF9EA700),
                                ),
                                title: Text('Work Phone'),
                                subtitle: Text(phone!),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 300,
                          width: 500,
                          decoration: BoxDecoration(
                            color: Color(0x1B9EA700),
                            borderRadius: BorderRadius.circular(10),
                              boxShadow: [new BoxShadow(
                                color:Color(0x1B9EA700),
                                blurRadius: 20.0,
                              ),],
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.location_city,
                                  color: Color(0xFF9EA700),
                                ),
                                title: Text('Work Location'),
                                subtitle: Text(loaction!),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.location_city,
                                  color: Color(0xFF9EA700),
                                ),
                                title: Text('Private Address'),
                                subtitle: Text(
                                    '${privateAddress!} , ${privateAddress2} , ${privateAddress3} , ${zipCode} , ${country}'),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.topic,
                                  color: Color(0xFF9EA700),
                                ),
                                title: Text('Departmnet'),
                                subtitle: Text(department!),
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
}

//       SafeArea(
//         child: Center(
//           child: CircleAvatar(
//             backgroundImage: profileImage != null
//                 ? MemoryImage(profileImage!)
//                 : AssetImage('assets/pf.jpeg') as ImageProvider,
//             radius: 100.0,
//           ),
//       ),
//       ),
//       Text(
//         name!,
//         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//       ),
//       Text('Chief Executive Officer'),
//       SizedBox(
//         height: 20,
//       ),
//       Padding(
//         padding: const EdgeInsets.only(left: 10.0 ,right: 10),
//         child: ListTile(
//           leading: Icon(
//             Icons.person,
//             color: Color(0xFF9EA700),
//           ),
//           title: Text('Name'),
//           subtitle: Text(name!),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           tileColor: Color(0x1B9EA700),
//           focusColor: Colors.red,
//           contentPadding: EdgeInsets.symmetric(horizontal: 65, vertical: 8),
//         ),
//       ),
//       SizedBox(
//         height: 10,
//       ),
//       Padding(
//         padding: const EdgeInsets.only(left: 10.0 ,right: 10),
//         child: ListTile(
//           leading: Icon(
//             Icons.male_rounded,
//             color: Color(0xFF9EA700),
//           ),
//           title: Text('Gender'),
//           subtitle: Text(gender??'Not available'),
//           shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           tileColor: Color(0x1B9EA700),
//           focusColor: Colors.red,
//           contentPadding: EdgeInsets.symmetric(horizontal: 65, vertical: 8),
//         ),
//       ),
//       SizedBox(
//         height: 10,
//       ),
//       Padding(
//         padding: const EdgeInsets.only(left: 10.0 ,right: 10),
//         child: ListTile(
//           leading: Icon(
//             Icons.date_range_rounded,
//             color: Color(0xFF9EA700),
//           ),
//           title: Text('Date of Birth'),
//           subtitle: Text(dob??'Not available'),
//           shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           tileColor: Color(0x1B9EA700),
//           focusColor: Colors.red,
//           contentPadding: EdgeInsets.symmetric(horizontal: 65, vertical: 8),
//         ),
//       ),
//       SizedBox(
//         height: 10,
//       ),
//       Padding(
//         padding: const EdgeInsets.only(left: 10.0 ,right: 10),
//         child: ListTile(
//           leading: Icon(
//             Icons.email,
//             color: Color(0xFF9EA700),
//           ),
//           title: Text('Work Email'),
//           subtitle: Text(email!),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           tileColor: Color(0x1B9EA700),
//           focusColor: Colors.red,
//           contentPadding: EdgeInsets.symmetric(horizontal: 65, vertical: 8),
//         ),
//       ),
//       SizedBox(
//         height: 10,
//       ),
//       Padding(
//         padding: const EdgeInsets.only(left: 10.0 ,right: 10),
//         child: ListTile(
//           leading: Icon(
//             Icons.phone,
//             color: Color(0xFF9EA700),
//           ),
//           title: Text('Work Phone'),
//           subtitle: Text(phone!),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           tileColor: Color(0x1B9EA700),
//           focusColor: Colors.red,
//           contentPadding: EdgeInsets.symmetric(horizontal: 65, vertical: 8),
//         ),
//       ),
//       SizedBox(
//         height: 10,
//       ),
//       Padding(
//         padding: const EdgeInsets.only(left: 10.0 ,right: 10),
//         child: ListTile(
//           leading: Icon(
//             Icons.location_city,
//             color: Color(0xFF9EA700),
//           ),
//           title: Text('Work Location'),
//           subtitle: Text(loaction!),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           tileColor: Color(0x1B9EA700),
//           focusColor: Colors.red,
//           contentPadding: EdgeInsets.symmetric(horizontal: 65, vertical: 8),
//         ),
//       ),
//       SizedBox(
//         height: 10,
//       ),
//       Padding(
//         padding: const EdgeInsets.only(left: 10.0 ,right: 10),
//         child: ListTile(
//           leading: Icon(
//             Icons.location_city,
//             color: Color(0xFF9EA700),
//           ),
//           title: Text('Private Address'),
//           subtitle: Text('${privateAddress!} , ${privateAddress2} , ${privateAddress3} , ${zipCode} , ${country}'),
//           shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           tileColor: Color(0x1B9EA700),
//           focusColor: Colors.red,
//           contentPadding: EdgeInsets.symmetric(horizontal: 65, vertical: 8),
//         ),
//       ),
//       SizedBox(
//         height: 10,
//       ),
//       Padding(
//         padding: const EdgeInsets.only(left: 10.0 ,right: 10),
//         child: ListTile(
//           leading: Icon(
//             Icons.topic,
//             color: Color(0xFF9EA700),
//           ),
//           title: Text('Departmnet'),
//           subtitle: Text(department!),
//           shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           tileColor: Color(0x1B9EA700),
//           focusColor: Colors.red,
//           contentPadding: EdgeInsets.symmetric(horizontal: 65, vertical: 8),
//         ),
//       ),
//     ],
//   ),
// ),
