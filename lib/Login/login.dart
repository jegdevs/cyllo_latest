import 'package:cyllo_mobile/erroDesign.dart';
import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'demo.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  bool urlCheck = false;
  bool disableFields = false;
  String? Database;
  bool? frstLogin ;
  String? errorMessage;
  bool isLoading = false;
  List<DropdownMenuItem<String>> dropdownItems = [];
  OdooClient? client;
  TextEditingController urlController = TextEditingController(text: "http://10.0.2.2:8017/");
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    if (formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
        errorMessage = null;
        disableFields = true;

      });
      try {
        final prefs = await SharedPreferences.getInstance();
        client = OdooClient(urlController.text.trim());
        final savedDb = prefs.getString('database');
        if (savedDb == null || savedDb.isEmpty) {
          setState(() {
            errorMessage = 'No database selected.';
            disableFields = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No database selected. Please choose a database first.')),
          );
          return;
        }
        print("Dataaaaaaa:$savedDb");
        var session = await client!.authenticate(
          savedDb!,
          emailController.text.trim(),
          passwordController.text.trim(),
        );
        print("Login successful: $session");
        print(session.id);
        if (session != null) {
          await saveSession(session);
          await addShared();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Demo()),
          );
        } else {
          setState(() {
            errorMessage = 'Authentication failed: No session returned.';
            disableFields = false;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$errorMessage')));
            print(errorMessage);
          });
        }
      } on OdooException {
        setState(() {
          errorMessage = 'Invalid username or password.';
          final snackBar = Customsnackbar().showSnackBar(
              "error", '$errorMessage', "error", () {});
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          print(errorMessage);
        });
      } catch (e) {
        setState(() {
          print(e);
          print(errorMessage);
          errorMessage = 'Network Error';
          final snackBar = Customsnackbar().showSnackBar(
              "error", '$errorMessage', "error", () {});
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          print(errorMessage);
        });
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }


  Future<void> addShared() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    final savedDb = prefs.getString('database');
    await prefs.setString('selectedDatabase', savedDb!);
    await prefs.setString('url', urlController.text.trim());
  }

  Future<void> saveSession(OdooSession session) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', session.userName ?? '');
    await prefs.setString('userLogin', session.userLogin?.toString() ?? '');
    await prefs.setInt('userId', session.userId ?? 0);
    await prefs.setString('sessionId', session.id);
    await prefs.setString('password', passwordController.text.trim());

    await prefs.setString('serverVersion', session.serverVersion ?? '');
    await prefs.setString('userLang', session.userLang ?? '');
    await prefs.setInt('partnerId', session.partnerId ?? 0);
    await prefs.setBool('isSystem', session.isSystem ?? false);
    await prefs.setString('userTimezone', session.userTz);

  }

  Future<void> saveLogin() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('urldata', urlController.text);
    await prefs.setString('emaildata', emailController.text);
    await prefs.setString('passworddata', passwordController.text);
    // await prefs.setString('database', Database ?? "");
    if (Database != null && Database!.isNotEmpty) {

      await prefs.setString('database', Database!);

    }

  }

  Future<String?> loginCheck()async {
    final prefs = await SharedPreferences.getInstance();
    final savedUrl = prefs.getString('urldata');
    print(savedUrl);
    final savedDb = prefs.getString('database');
    print(savedDb);
    //   if (savedUrl != null && savedDb != null) {
    //     setState(() {
    //       frstLogin = false;
    //     });
    //   }
    // }
    if (savedUrl != null && savedDb != null && savedDb.isNotEmpty) {
      setState(() {
        frstLogin = false;
        Database = savedDb;
      });
    }
    else{
      setState(() {
        frstLogin = true;
      });
    }
  }
  Future<void> fetchDatabaseList() async {
    setState(() {
      isLoading = true;
      urlCheck = false;
    });

    try {
      final baseUrl = urlController.text.trim();
      print(baseUrl);
      client = OdooClient(baseUrl);
      final response = await client!.callRPC('/web/database/list', 'call', {});
      final dbList = response as List<dynamic>;
      setState(() {
        dropdownItems = dbList
            .map((db) => DropdownMenuItem<String>(
          value: db,
          child: Text(db),
        ))
            .toList();
        urlCheck = true;
        errorMessage = null;
      });

    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching database list: $e';
        Database = null;
        urlCheck = false;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
@override
  void initState() {
  loginCheck();
  if(urlController.text.isNotEmpty){
    fetchDatabaseList();
  }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Positioned(
          top: -80,
          left: -80,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color:  Color(0xFF9EA700),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: -130,
          right: -130,
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              color:  Color(0xFF9EA700),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images.png',
                  width: 170,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding:  EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset:  Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Form( key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF9EA700),
                          ),
                        ),
                        SizedBox(height: 15),
                        if(frstLogin == true)...[
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter a URL';
                              }
                              final RegExp newReg = RegExp(
                                r'^(https?:\/\/)'
                                r'(([a-zA-Z0-9-_]+\.)+[a-zA-Z]{2,}'
                                r'|(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}))'
                                r'(:\d{1,5})?'
                                r'(\/[^\s]*)?$',
                                caseSensitive: false,
                              );

                              if (!newReg.hasMatch(value)) {
                                return 'Enter a valid  URL';
                              }
                              return null;
                            },
                            controller: urlController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Url',
                              prefixIcon: Icon(Icons.link, color: Colors.grey),
                            ),
                            onChanged: (value){
                                fetchDatabaseList();
                            },
                            enabled: !disableFields,
                          ),
                          SizedBox(height: 15),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(
                                Icons.storage,
                                color: Colors.grey,
                              ),
                            ),
                            dropdownColor: Colors.white,
                            hint: const Text("Choose Database"),
                            value: Database,
                            items: urlCheck? dropdownItems : [],
                            onChanged: disableFields? null:(value) {
                              setState(() {
                                Database = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Database is required";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                        ],
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email is required";
                            }
                            return null;
                          },
                          controller: emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.email, color: Colors.grey),
                          ),
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password is required";
                            }
                            return null;
                          },
                          controller: passwordController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.lock, color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if(Database==null){
                                errorMessage = 'Choose Database first';
                                final snackBar = Customsnackbar().showSnackBar(
                                    "error", '$errorMessage', "error", () {});
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                print(errorMessage);
                              }
                              saveLogin();
                              login();
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              backgroundColor: Color(0xFF9EA700),
                              foregroundColor: Colors.white,
                              minimumSize: Size(400, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 18),
                            )),
                        SizedBox(height: 10),
                        Center(
                          child: TextButton(
                            onPressed: () {
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF9EA700),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                frstLogin = true;
                              });
                            },
                              child: Text('Manage Database?',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF9EA700),
                              ),))
                          ,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
