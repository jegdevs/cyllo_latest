import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
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

  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController loactionController = TextEditingController();
  TextEditingController privateAddressController = TextEditingController();
  TextEditingController privateAddress2Controller = TextEditingController();
  TextEditingController privateAddress3Controller = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController departmentController = TextEditingController();

  List<Map<String, dynamic>> locations = [];
  List<Map<String, dynamic>> departments= [];
  List<Map<String, dynamic>> countryList = [];
  List<Map<String, dynamic>> stateList = [];
  String? selectedLocation;
  String? selectedDepartments;
  String? selectedCountryList;
  String? selectedState;

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
        await workLocation();
        await departmnet();
        await Country();
        await State();
      } catch (e) {
        print("Odoo Authentication Failed: $e");
      }
    }
    setState(() => isLoading = false);
  }

  Future<void> workLocation() async {
    try {
      final response = await client?.callKw({
        'model': 'hr.work.location',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'fields': [
            'display_name',
            'id',
          ],
        }
      });
      print('pppppp$response');
      if (response != null && response is List) {
        setState(() {
          locations = List<Map<String, dynamic>>.from(response);
          Map<String, dynamic>? foundLocation;
          for (var loc in locations) {
            if (loc['display_name'] == loactionController.text) {
              foundLocation = loc;
              break;
            }
          }
          selectedLocation = foundLocation != null
              ? foundLocation['display_name']
              : (locations.isNotEmpty ? locations[0]['display_name'] : null);
        });
      }
      print('Locations: $locations');
    } catch (e) {
      print("Odoo fetch Failed: $e");
    }
  }

  Future<void> departmnet()async {
    try {
      final response = await client?.callKw({
        'model': 'hr.department',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'fields': [
            'name',
            'id',
          ],
        }
      });
      if (response != null && response is List) {
        setState(() {
          departments = List<Map<String, dynamic>>.from(response);
          Map<String, dynamic>? foundLocation;
          for (var loc in departments) {
            if (loc['name'] == departmentController.text) {
              foundLocation = loc;
              break;
            }
          }
          selectedDepartments = foundLocation != null
              ? foundLocation['name']
              : (departments.isNotEmpty ? departments[0]['name'] : null);
        });
      }
      print('dp: $departments');
    } catch (e) {
      print("O Failed: $e");
    }

}

  Future<void> Country()async {
    try {
      final response = await client?.callKw({
        'model': 'res.country',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'fields': [
            'name',
            'id',
          ],
        }
      });
      if (response != null && response is List) {
        setState(() {
          countryList = List<Map<String, dynamic>>.from(response);
          Map<String, dynamic>? foundLocation;
          for (var loc in countryList) {
            if (loc['name'] == countryController.text) {
              foundLocation = loc;
              break;
            }
          }
          selectedCountryList = foundLocation != null
              ? foundLocation['name']
              : (countryList.isNotEmpty ? countryList[0]['name'] : null);
        });
      }
      print('cn: $response');
    } catch (e) {
      print("Failed: $e");
    }
  }
  Future<void> State()async {
    try {
      final response = await client?.callKw({
        'model': 'res.country.state',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'fields': [
            'name',
            'id',
          ],
        }
      });
      if (response != null && response is List) {
        setState(() {
          stateList = List<Map<String, dynamic>>.from(response);
          Map<String, dynamic>? foundLocation;
          for (var loc in stateList) {
            if (loc['name'] == privateAddress3Controller.text) {
              foundLocation = loc;
              break;
            }
          }
          selectedState = foundLocation != null
              ? foundLocation['name']
              : (stateList.isNotEmpty ? stateList[0]['name'] : null);
        });
      }
      print('st: $response');
    } catch (e) {
      print("Failed: $e");
    }
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
            'birthday',
          ]
        },
      });
      log('lasttttcheck$response');
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
          nameController.text = name ?? '';
          genderController.text = gender ?? '';
          dobController.text = dob ?? '';
          emailController.text = email ?? '';
          phoneController.text = phone ?? '';
          loactionController.text = loaction ?? '';
          privateAddressController.text = privateAddress ?? '';
          privateAddress2Controller.text = privateAddress2 ?? '';
          privateAddress3Controller.text = privateAddress3 ?? '';
          zipCodeController.text = zipCode ?? '';
          countryController.text = country ?? '';
          departmentController.text = department ?? '';
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

  Future<void> saveChanges() async {
    final updatedData = {
      'work_email': emailController.text,
      'work_phone': phoneController.text,
      'work_location_id': locations
              .where((data) => data['display_name'] == selectedLocation)
              .isNotEmpty
          ? locations.firstWhere(
              (data) => data['display_name'] == selectedLocation)['id']
          : null,
      'name': nameController.text,
      'private_street': privateAddressController.text,
      'private_city': privateAddress2Controller.text,
      'private_state_id':  stateList
          .where((data) => data['name'] == selectedState)
          .isNotEmpty
          ? stateList.firstWhere(
              (data) => data['name'] == selectedState)['id']
          : null,
      'private_zip': zipCodeController.text,
      'private_country_id': countryList
          .where((data) => data['name'] == selectedCountryList)
          .isNotEmpty
          ? countryList.firstWhere(
              (data) => data['name'] == selectedCountryList)['id']
          : null,
      'department_id': departments
          .where((data) => data['name'] == selectedDepartments)
          .isNotEmpty
          ? departments.firstWhere(
              (data) => data['name'] == selectedDepartments)['id']
          : null,
      'gender': genderController.text,
      'birthday': dobController.text,
    };
    try {
      final prefs = await SharedPreferences.getInstance();
      final userid = prefs.getInt("userId") ?? "";
      await client?.callKw({
        'model': 'res.users',
        'method': 'write',
        'args': [
          [userid],
          updatedData,
        ],
        'kwargs': {},
      });
      print(updatedData);
      print("Profile updated successfully");
    } catch (e) {
      print("Error updating profile$e");
    }
  }

  void uploadProfile(){

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
        backgroundColor: Colors.white,
        title: Text('Edit Profile'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SafeArea(
                      child: Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                            backgroundImage: profileImage != null
                                ? MemoryImage(profileImage!)
                                : AssetImage('assets/pf.jpeg') as ImageProvider,
                            radius: 100.0,
                          ),
                            Positioned(
                              child: Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0x549EA700),
                                ),
                                child: Center(child: IconButton(padding: EdgeInsets.all(0),
                                    color: Colors.white,
                                    onPressed: (){}, icon: Center(child: Icon(Icons.image_search,size: 35,)))),
                              ),
                            ),
                          ]
                        ),
                      ),
                    ),
                    Text(
                      name!,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text('Chief Executive Officer'),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xFF9EA700),
                        ),
                        filled: true,
                        fillColor: Color(0x1B9EA700),
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(70),
                          borderSide: BorderSide(
                            color: Color(0xFF9EA700),
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 65, vertical: 8),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: genderController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.male_rounded,
                          color: Color(0xFF9EA700),
                        ),
                        filled: true,
                        fillColor: Color(0x1B9EA700),
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(70),
                          borderSide: BorderSide(
                            color: Color(0xFF9EA700),
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 65, vertical: 8),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: dobController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.date_range_rounded,
                          color: Color(0xFF9EA700),
                        ),
                        filled: true,
                        fillColor: Color(0x1B9EA700),
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(70),
                          borderSide: BorderSide(
                            color: Color(0xFF9EA700),
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 65, vertical: 8),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Color(0xFF9EA700),
                        ),
                        filled: true,
                        fillColor: Color(0x1B9EA700),
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Color(0xFF9EA700),
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 65, vertical: 8),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Color(0xFF9EA700),
                        ),
                        filled: true,
                        fillColor: Color(0x1B9EA700),
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Color(0xFF9EA700),
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 65, vertical: 8),
                      ),
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField<int>(
                      value: locations.isNotEmpty &&
                              locations.any((data) =>
                                  data['display_name'] ==
                                  loactionController.text)
                          ? locations.firstWhere(
                              (data) =>
                                  data['display_name'] ==
                                  loactionController.text,
                            )['id']
                          : null,
                      onChanged: (value) {
                        setState(() {
                          var matchedLocations = locations
                              .where((data) => data['id'] == value)
                              .toList();
                          selectedLocation = matchedLocations.isNotEmpty
                              ? matchedLocations.first['display_name']
                              : '';
                          loactionController.text =
                              selectedLocation!;
                        });
                      },
                      items: locations
                          .map((data) => DropdownMenuItem<int>(
                                value: data['id'],
                                child: Text(data['display_name']),
                              ))
                          .toList(),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.work_history_outlined,
                          color: Color(0xFF9EA700),
                        ),
                        filled: true,
                        fillColor: Color(0x1B9EA700),
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFF9EA700)),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 65, vertical: 8),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: TextFormField(
                              controller: privateAddressController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.location_city,
                                  color: Color(0xFF9EA700),
                                ),
                                filled: true,
                                fillColor: Color(0x1B9EA700),
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Color(0xFF9EA700),
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 65, vertical: 8),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: SizedBox(
                            child: TextFormField(
                              controller: privateAddress2Controller,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.location_city,
                                  color: Color(0xFF9EA700),
                                ),
                                filled: true,
                                fillColor: Color(0x1B9EA700),
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Color(0xFF9EA700),
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 65, vertical: 8),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: DropdownButtonFormField<int>(
                              isExpanded: true,
                              value: stateList.isNotEmpty &&
                                  stateList.any((data) =>
                                  data['name'] ==
                                      privateAddress3Controller.text)
                                  ? stateList.firstWhere(
                                    (data) =>
                                data['name'] ==
                                    privateAddress3Controller.text,
                              )['id']
                                  : null,
                              onChanged: (value) {
                                setState(() {
                                  var matchedLocations = stateList
                                      .where((data) => data['id'] == value)
                                      .toList();
                                  selectedState = matchedLocations.isNotEmpty
                                      ? matchedLocations.first['name']
                                      : '';
                                  privateAddress3Controller.text =
                                  selectedState!;
                                });
                              },
                              items: stateList
                                  .map((data) => DropdownMenuItem<int>(
                                value: data['id'],
                                child: Text(data['name']),
                              ))
                                  .toList(),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.location_on,
                                  color: Color(0xFF9EA700),
                                ),
                                filled: true,
                                fillColor: Color(0x1B9EA700),
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Color(0xFF9EA700)),
                                ),
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: 65, vertical: 8),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: SizedBox(
                            child: TextFormField(
                              controller: zipCodeController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.location_city,
                                  color: Color(0xFF9EA700),
                                ),
                                filled: true,
                                fillColor: Color(0x1B9EA700),
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Color(0xFF9EA700),
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 65, vertical: 8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField<int>(
                      isExpanded: true,
                      value: countryList.isNotEmpty &&
                          countryList.any((data) =>
                          data['name'] ==
                              countryController.text)
                          ? countryList.firstWhere(
                            (data) =>
                        data['name'] ==
                            countryController.text,
                      )['id']
                          : null,
                      onChanged: (value) {
                        setState(() {
                          var matchedLocations = countryList
                              .where((data) => data['id'] == value)
                              .toList();
                          selectedCountryList = matchedLocations.isNotEmpty
                              ? matchedLocations.first['name']
                              : '';
                          countryController.text =
                          selectedCountryList!;
                        });
                      },
                      items: countryList
                          .map((data) => DropdownMenuItem<int>(
                        value: data['id'],
                        child: Text(data['name']),
                      ))
                          .toList(),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.location_on,
                          color: Color(0xFF9EA700),
                        ),
                        filled: true,
                        fillColor: Color(0x1B9EA700),
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFF9EA700)),
                        ),
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 65, vertical: 8),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField<int>(
                      value: departments.isNotEmpty &&
                          departments.any((data) =>
                          data['name'] ==
                              departmentController.text)
                          ? departments.firstWhere(
                            (data) =>
                        data['name'] ==
                            departmentController.text,
                      )['id']
                          : null,
                      onChanged: (value) {
                        setState(() {
                          var matchedLocations = departments
                              .where((data) => data['id'] == value)
                              .toList();
                          selectedDepartments = matchedLocations.isNotEmpty
                              ? matchedLocations.first['name']
                              : '';
                          departmentController.text =
                          selectedDepartments!;
                        });
                      },
                      items: departments
                          .map((data) => DropdownMenuItem<int>(
                        value: data['id'],
                        child: Text(data['name']),
                      ))
                          .toList(),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.work_history_outlined,
                          color: Color(0xFF9EA700),
                        ),
                        filled: true,
                        fillColor: Color(0x1B9EA700),
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFF9EA700)),
                        ),
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 65, vertical: 8),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          saveChanges();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF9EA700),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(300, 45),
                        ),
                        child: Text('Save Changes')),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
