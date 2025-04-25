import 'dart:developer';

import 'package:cyllo_mobile/Login/demo.dart';
import 'package:cyllo_mobile/Login/login.dart';
import 'package:cyllo_mobile/isarModel/customerViewModel.dart';
import 'package:cyllo_mobile/isarModel/leadModel.dart';
import 'package:cyllo_mobile/isarModel/profileModel.dart';
import 'package:cyllo_mobile/isarModel/quotationsModel.dart';
import 'package:cyllo_mobile/isarModel/teamsModel.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'isarModel/activityModel.dart';
import 'isarModel/pipelineModel.dart';

late Isar isar;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [
        CustomerSchema,
        NewpipeSchema,
        UserImageSchema,
        TagSchema,
        NewactSchema,
        SaleOrderSchema,
        ActivitySchema,
        CategorySchema,
        LeadisarSchema,
        SalesTeamIsarSchema,
        UserProfileSchema,
      ],
      directory: dir.path,
      inspector: true,
    );
    print('Isar initialized successfully');
  } catch (e) {
    print('Failed to initialize Isar: $e');

  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/main',
      routes: {
        '/main': (context) =>  First(),
        '/login': (context) =>  Login(),
        '/Demo': (context) =>  Demo(),
      },
    );
  }
}

class First extends StatelessWidget {
   First({super.key});

  Future<bool> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (loggedIn == false) {
      print("not logged $loggedIn");
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: checkLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: Color(0xFF9EA700),
                size: 100,
              ),
            );
          } else if (snapshot.hasError || snapshot.data == false) {
            Future.microtask(() {
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            });
          } else {
            Future.microtask(() {
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/Demo');
              }
            });
          }
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: Color(0xFF9EA700),
              size: 100,
            ),
          );
        },
      ),
    );
  }
}
// fghjk