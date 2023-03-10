import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/helper/DatabaseHelper.dart';
import 'package:firebase_demo/screen/EditPage.dart';
import 'package:firebase_demo/screen/homePage.dart';
import 'package:firebase_demo/screen/signInScreen.dart';
import 'package:firebase_demo/utils/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "My_Channel",
    "Notification Chennel",
    description: "Thsi Channel Is Used For Important notification",
    importance: Importance.max
);

final AndroidFlutterLocalNotificationsPlugin
      flutterLocalNotificationsPlugin = AndroidFlutterLocalNotificationsPlugin();



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      routes: {
        '/' : (context) => MyApp(),
        'signIn' : (context) => SignIn(),
        'home' : (context) => HomePage(),
        'edit' : (context) => EditPage()
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return HomePage();
          }
          else{
            return SignIn();
          }
        },
      ),
    );
  }
}


