import 'dart:convert';
import 'dart:developer';
import 'package:cyllo_mobile/Login/demo.dart';
import 'package:cyllo_mobile/Profile/editProfile.dart';
import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';


class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  OdooClient? client;
  bool isLoading = true;
  String ?email;
  String ? phone;
  String? loaction;
  String? name;
  Uint8List? profileImage;
  String? privateAddress,privateAddress2,privateAddress3,zipCode,country;
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
          if (locationData != null && locationData is List && locationData.isNotEmpty) {
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
          privateAddress2 =data[0]['private_city'];
          var privateAddressState = data[0]['private_state_id'];
          if(privateAddressState != null && privateAddressState is List && privateAddressState.isNotEmpty){
            privateAddress3 = privateAddressState[1];
          }else{
            privateAddress3 = privateAddressState.toString();
          }
          zipCode = data[0]['private_zip'];
          var country1 = data[0]['private_country_id'];
          if(country1 != null && country1 is List && country1.isNotEmpty ){
            country =country1[1];
          }else{
            country =country1.toString();
          }
          var departments = data[0]['department_id'];
            if(departments!=null && departments is List && departments.isNotEmpty){
              department = departments[1];
          }else{
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
    }
    catch (e) {
      print("Error processing forecast data ");
      setState(() => isLoading = false);
    }
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
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Editprofile()));
          }, icon: Icon(Icons.edit)),
          SizedBox(
            width: 5,
          ),
        ],
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
      body:isLoading?Center(child: CircularProgressIndicator()):
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            SafeArea(
              child: Center(
                child: CircleAvatar(
                  backgroundImage: profileImage != null
                      ? MemoryImage(profileImage!)
                      : AssetImage('assets/pf.jpeg') as ImageProvider,
                  radius: 100.0,
                ),
            ),
            ),
            Text(
              name!,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text('Chief Executive Officer'),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Color(0xFF9EA700),
              ),
              title: Text('Name'),
              subtitle: Text(name!),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              tileColor: Color(0x1B9EA700),
              focusColor: Colors.red,
              contentPadding: EdgeInsets.symmetric(horizontal: 65, vertical: 8),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(
                Icons.male_rounded,
                color: Color(0xFF9EA700),
              ),
              title: Text('Gender'),
              subtitle: Text(gender??'Not available'),
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              tileColor: Color(0x1B9EA700),
              focusColor: Colors.red,
              contentPadding: EdgeInsets.symmetric(horizontal: 65, vertical: 8),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(
                Icons.date_range_rounded,
                color: Color(0xFF9EA700),
              ),
              title: Text('Date of Birth'),
              subtitle: Text(dob??'Not available'),
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              tileColor: Color(0x1B9EA700),
              focusColor: Colors.red,
              contentPadding: EdgeInsets.symmetric(horizontal: 65, vertical: 8),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(
                Icons.email,
                color: Color(0xFF9EA700),
              ),
              title: Text('Work Email'),
              subtitle: Text(email!),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              tileColor: Color(0x1B9EA700),
              focusColor: Colors.red,
              contentPadding: EdgeInsets.symmetric(horizontal: 65, vertical: 8),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(
                Icons.phone,
                color: Color(0xFF9EA700),
              ),
              title: Text('Work Phone'),
              subtitle: Text(phone!),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              tileColor: Color(0x1B9EA700),
              focusColor: Colors.red,
              contentPadding: EdgeInsets.symmetric(horizontal: 65, vertical: 8),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(
                Icons.location_city,
                color: Color(0xFF9EA700),
              ),
              title: Text('Work Location'),
              subtitle: Text(loaction!),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              tileColor: Color(0x1B9EA700),
              focusColor: Colors.red,
              contentPadding: EdgeInsets.symmetric(horizontal: 65, vertical: 8),
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
              subtitle: Text('${privateAddress!} , ${privateAddress2} , ${privateAddress3} , ${zipCode} , ${country}'),
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              tileColor: Color(0x1B9EA700),
              focusColor: Colors.red,
              contentPadding: EdgeInsets.symmetric(horizontal: 65, vertical: 8),
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
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              tileColor: Color(0x1B9EA700),
              focusColor: Colors.red,
              contentPadding: EdgeInsets.symmetric(horizontal: 65, vertical: 8),
            ),
          ],
        ),
      ),
    );
  }
}
