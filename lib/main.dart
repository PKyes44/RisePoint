import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:survey_jys/authentication/login_screen.dart';
import 'package:survey_jys/firebase_options.dart';
import 'package:survey_jys/notification.dart';
import 'package:survey_jys/screens/vote_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color mainColor = const Color(0xffFD3C4F);
  bool isToken = false;
  String? studentNumber = "";
  String? name = "";
  String? point = "";

  @override
  void initState() {
    // FlutterLocalNotification.init();
    // FlutterLocalNotification.requestNotificationPermission();
    // getPermissions();
    super.initState();
    _autoLoginCheck();

    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('isGameOver/');
    starCountRef.onValue.listen((DatabaseEvent event) {
      // FlutterLocalNotification.sendLocalNotification(
      //   idx: 0,
      //   title: 'RissPoint',
      //   content: '게임이 종료되었습니다 !',
      // );
      print("Show Push Notification");
    });
  }

  void getPermissions() async {
    if (await Permission.contacts.request().isGranted) {}

    Map<Permission, PermissionStatus> statuses = await [
      Permission.accessNotificationPolicy,
    ].request();
    print(statuses[Permission.accessNotificationPolicy]);
  }

  void _autoLoginCheck() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    studentNumber = pref.getString('studentNumber');
    name = pref.getString('name');
    point = pref.getString('point');

    if (studentNumber != null && name != null && point != null) {
      isToken = true;
      setState(() {});
      print("Token Completed : $studentNumber - $name - $point");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JYS승자예측',
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: mainColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: mainColor,
        ),
        useMaterial3: true,
      ),
      home: isToken
          ? MakeQuestionScreen(
              studentNumber: studentNumber,
              name: name,
              point: point,
            )
          : const LoginScreen(),
    );
  }
}
