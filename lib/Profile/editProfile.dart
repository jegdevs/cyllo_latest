import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cyllo_mobile/Profile/profilePage.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:typed_data';


class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  final formKey = GlobalKey<FormState>();
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
  File? selectedImage;
  String? newImage;
  IconData? errorIcon;

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
  List<Map<String, dynamic>> departments = [];
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

  Future<void> departmnet() async {
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

  Future<void> Country() async {
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

  Future<void> State() async {
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
            if (response != null && response is List && response.isNotEmpty) {
              newImage = response[0]['image_1920'];
            }
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
    bool trycheck = false;
    String errorMessage = "An error occurred. Please try again.";
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
      'private_state_id': stateList
          .where((data) => data['name'] == selectedState)
          .isNotEmpty
          ? stateList.firstWhere((data) => data['name'] == selectedState)['id']
          : null,
      'private_zip': zipCodeController.text,
      'private_country_id': countryList
          .where((data) => data['name'] == selectedCountryList)
          .isNotEmpty
          ? countryList
          .firstWhere((data) => data['name'] == selectedCountryList)['id']
          : null,
      'department_id': departments
          .where((data) => data['name'] == selectedDepartments)
          .isNotEmpty
          ? departments
          .firstWhere((data) => data['name'] == selectedDepartments)['id']
          : null,
      'gender': genderController.text,
      'birthday': dobController.text,
      'image_1920': newImage,
    };
      try {
        print("user ID...");
        final prefs = await SharedPreferences.getInstance();
        final userid = prefs.getInt("userId") ?? "";
        if (userid == "" || userid == 0) {
          throw Exception("User ID not found. Please log in again.");
        }
        final response = await client?.callKw({
          'model': 'res.users',
          'method': 'write',
          'args': [
            [userid],
            updatedData,
          ],
          'kwargs': {},
        });
        print('uiii$response');
        print("Profile updated successfully");
        if (response == true){
          setState(() {
            trycheck = true;
          });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Profilepage()));
        await getProfileData();
      }
          else{
      throw Exception("API call failed");
      }
      } catch (e) {
        print('1');
        setState(() {
          errorIcon = Icons.warning_amber_rounded;
        });
        if (e is SocketException) {
          print('2');
          setState(() {
            errorIcon =
                Icons.signal_wifi_statusbar_connected_no_internet_4_outlined;
          });
          errorMessage = "No internet connection. Please check your network.";
        } else if (e.toString().contains("OdooException")) {
          print('3');
          setState(() {
            errorIcon = Icons.warning_amber_rounded;
          });
          errorMessage = "Cyllo Server Error......";
        }
        else if (trycheck == false) {
          print('4');
          setState(() {
            errorIcon = Icons.warning_amber_rounded;
          });
          errorMessage = "API call failed......";
        }
        else {
          print('5');
          setState(() {
            errorIcon = Icons.warning_amber_rounded;
          });
          errorMessage = "Error: ${e.toString()}";
        }
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                height: 280,
                child: Column(
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          errorIcon,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      height: 160,
                      width: 329,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            errorMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 20),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 40,
                                  vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'OK',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
        print("Error updating profile$e");
      };
  }

  Future<void> uploadProfile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);

      newImage = base64Encode(await selectedImage!.readAsBytes());

      setState(() {
        profileImage = base64Decode(newImage!);
      });
    }
  }

  final Map<String, String> genderOptions = {
    'male': 'Male',
    'female': 'Female',
    'other': 'Other',
  };

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
                height: 50.0,
                width: 500,
                color: Colors.white,
              ),
            );
          }),
          Row(
              children: [
                Expanded(
                    child: Container(
                      height: 50,
                      width: 50,
                      color: Colors.white,
                    ),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: Container(
                    height: 50,
                    width: 50,
                    color: Colors.white,
                  ),
                ),
              ],
          ),
          SizedBox(height: 6,),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  width: 50,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 5,),
              Expanded(
                child: Container(
                  height: 50,
                  width: 50,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 8),
            child: Container(
              height: 50.0,
              width: 500,
              color: Colors.white,
            ),
          )
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
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Profilepage()));
              // getProfileData();
            },
            icon: Icon(Icons.navigate_before)),
        backgroundColor:Color(0xFF9EA700),
        title: Text('Edit Profile'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: isLoading
          ? SimmerLoad()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      SafeArea(
                        child: Center(
                          child: Stack(children: [
                            CircleAvatar(
                              backgroundImage: profileImage != null
                                  ? MemoryImage(profileImage!)
                                  : AssetImage('assets/pf.jpeg')
                                      as ImageProvider,
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
                                child: Center(
                                    child: IconButton(
                                        padding: EdgeInsets.all(0),
                                        color: Colors.white,
                                        onPressed: () {
                                          uploadProfile();
                                        },
                                        icon: Center(
                                            child: Icon(
                                          Icons.image_search,
                                          size: 35,
                                        )))),
                              ),
                            ),
                          ]),
                        ),
                      ),
                      Text(
                        name!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text('Chief Executive Officer'),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) =>
                            value!.isEmpty ? "Please enter your name" : null,
                        controller: nameController,
                        onChanged: (text) {
                          if (formKey.currentState!.validate()) {
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
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
                      CustomDropdown<String>(
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Please select gender";
                        },

                        decoration: CustomDropdownDecoration(
                          closedFillColor: Color(0x1B9EA700),
                          closedBorderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Select Gender',
                        items: genderOptions.values.toList(),
                        initialItem:
                            genderOptions[genderController.text.trim()],
                        onChanged: (value) {
                          setState(() {
                            genderController.text = genderOptions.entries
                                .firstWhere((entry) => entry.value == value)
                                .key;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your date of birth";
                          }
                        },
                        controller: dobController,
                        readOnly: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.date_range_rounded,
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
                        onTap: () async {
                          final date = await showDatePickerDialog(
                            context: context,
                            initialDate: DateTime.now(),
                            minDate: DateTime(1900),
                            maxDate: DateTime.now(),
                            width: 300,
                            height: 300,
                            currentDate: DateTime.now(),
                            daysOfTheWeekTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                            disabledCellsTextStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            enabledCellsDecoration: BoxDecoration(),
                            enabledCellsTextStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            selectedCellTextStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            selectedCellDecoration: BoxDecoration(
                              color: Color(0xFF9EA700),
                              shape: BoxShape.circle,
                            ),
                            leadingDateTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black38,
                            ),
                            initialPickerType: PickerType.days,
                            currentDateDecoration: BoxDecoration(
                              color: Color(0xFF9EA700),
                              shape: BoxShape.circle,
                            ),
                            currentDateTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            slidersColor: Color(0xFF9EA700),
                            highlightColor: Color(0xFF9EA700),
                            slidersSize: 25,
                            splashRadius: 12,
                          );
                          if (date != null) {
                            setState(() {
                              dobController.text =
                                  "${date.year} - ${date.month} - ${date.day}";
                            });
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your email";
                          } else if (!RegExp(
                                  r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                              .hasMatch(value)) {
                            return "Please enter valid email";
                          }
                        },
                        onChanged: (text) {
                          if (formKey.currentState!.validate()) {
                          }
                        },
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
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Please enter your phone number";
                          else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                            return "Please enter valid 10-digit number";
                          }
                          return null;
                        },
                        onChanged: (text) {
                          if (formKey.currentState!.validate()) {
                          }
                        },
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
                      // DropdownButtonFormField<int>(
                      //   value: locations.isNotEmpty &&
                      //           locations.any((data) =>
                      //               data['display_name'] ==
                      //               loactionController.text)
                      //       ? locations.firstWhere(
                      //           (data) =>
                      //               data['display_name'] ==
                      //               loactionController.text,
                      //         )['id']
                      //       : null,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       var matchedLocations = locations
                      //           .where((data) => data['id'] == value)
                      //           .toList();
                      //       selectedLocation = matchedLocations.isNotEmpty
                      //           ? matchedLocations.first['display_name']
                      //           : '';
                      //       loactionController.text = selectedLocation!;
                      //     });
                      //   },
                      //   items: locations
                      //       .map((data) => DropdownMenuItem<int>(
                      //             value: data['id'],
                      //             child: Text(data['display_name']),
                      //           ))
                      //       .toList(),
                      //   decoration: InputDecoration(
                      //     prefixIcon: Icon(
                      //       Icons.work_history_outlined,
                      //       color: Color(0xFF9EA700),
                      //     ),
                      //     filled: true,
                      //     fillColor: Color(0x1B9EA700),
                      //     border: InputBorder.none,
                      //     focusedBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(12),
                      //       borderSide: BorderSide(color: Color(0xFF9EA700)),
                      //     ),
                      //     contentPadding:
                      //         EdgeInsets.symmetric(horizontal: 65, vertical: 8),
                      //   ),
                      // ),
                      CustomDropdown<String>(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter your work address";
                          }
                        },
                        decoration: CustomDropdownDecoration(
                          closedFillColor: Color(0x1B9EA700),
                          closedBorderRadius: BorderRadius.circular(12),
                        ),
                        // hintText: '${privateAddress3Controller.text}',
                        hintBuilder: (context, selectedItem, enabled) {
                          return Text(
                            '${loactionController.text}',
                            style: TextStyle(color: Colors.black),
                          );
                        },
                        items: locations
                            .map<String>(
                                (data) => data['display_name'].toString())
                            .toList(),
                        initialItem: locations.any((data) =>
                                data['display_name'] ==
                                loactionController.text.trim())
                            ? loactionController.text.trim()
                            : null,
                        onChanged: (value) {
                          setState(() {
                            var matchedLocation = locations.firstWhere(
                                (data) => data['display_name'] == value);
                            selectedLocation = matchedLocation['display_name'];
                            loactionController.text = selectedLocation!;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your address";
                                  }
                                },
                                onChanged: (text) {
                                  if (formKey.currentState!.validate()) {
                                  }
                                },
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your address";
                                  }
                                },
                                onChanged: (text) {
                                  if (formKey.currentState!.validate()) {
                                  }
                                },
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
                              child: CustomDropdown<String>(
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return "Please enter your address";
                                //   }
                                // },
                                decoration: CustomDropdownDecoration(
                                  closedFillColor: Color(0x1B9EA700),
                                  closedBorderRadius: BorderRadius.circular(12),
                                ),
                                // hintText: '${privateAddress3Controller.text}',
                                hintBuilder: (context, selectedItem, enabled) {
                                  return Text(
                                    '${privateAddress3Controller.text}',
                                    style: TextStyle(color: Colors.black),
                                  );
                                },
                                items: stateList
                                    .map<String>(
                                        (data) => data['name'].toString())
                                    .toList(),
                                initialItem: stateList.any((data) =>
                                        data['name'] ==
                                        privateAddress3Controller.text.trim())
                                    ? privateAddress3Controller.text.trim()
                                    : null,
                                onChanged: (value) {
                                  setState(() {
                                    var matchedLocation = stateList.firstWhere(
                                        (data) => data['name'] == value);
                                    selectedState = matchedLocation['name'];
                                    privateAddress3Controller.text =
                                        selectedState!;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: SizedBox(
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your zip code";
                                  }
                                },
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
                      CustomDropdown<String>(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your country";
                          }
                        },
                        decoration: CustomDropdownDecoration(
                          closedFillColor: Color(0x1B9EA700),
                          closedBorderRadius: BorderRadius.circular(12),
                        ),
                        hintBuilder: (context, selectedItem, enabled) {
                          return Text(
                            '${countryController.text}',
                            style: TextStyle(color: Colors.grey),
                          );
                        },
                        items: countryList
                            .map<String>((data) => data['name'].toString())
                            .toList(),
                        initialItem: countryList.any((data) =>
                                data['name'] == countryController.text.trim())
                            ? countryController.text.trim()
                            : null,
                        onChanged: (value) {
                          setState(() {
                            var matchedLocation = countryList
                                .firstWhere((data) => data['name'] == value);
                            selectedCountryList = matchedLocation['name'];
                            countryController.text = selectedCountryList!;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomDropdown<String>(
                        decoration: CustomDropdownDecoration(
                          closedFillColor: Color(0x1B9EA700),
                          closedBorderRadius: BorderRadius.circular(12),
                        ),
                        hintBuilder: (context, selectedItem, enabled) {
                          return Text(
                            '${departmentController.text}',
                            style: TextStyle(color: Colors.black),
                          );
                        },
                        items: departments
                            .map<String>((data) => data['name'].toString())
                            .toList(),
                        initialItem: departments.any((data) =>
                                data['name'] ==
                                departmentController.text.trim())
                            ? departmentController.text.trim()
                            : null,
                        onChanged: (value) {
                          setState(() {
                            var matchedLocation = departments
                                .firstWhere((data) => data['name'] == value);
                            selectedDepartments = matchedLocation['name'];
                            departmentController.text = selectedDepartments!;
                          });
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) saveChanges();
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
            ),
    );
  }
}
