import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import './screens/home_screen.dart';
import './screens/subjects_screen.dart';
import './screens/time_table_screen.dart';
import './providers/subject_list.dart';
import 'providers/day_subject_list.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_launcher');
  final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (int id, String title, String body, String payload) async {});
  final InitializationSettings initializationSettings =
      InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ${payload}');
    }
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => SubjectList()),
        ChangeNotifierProvider(create: (ctx) => DaySubjects()),
      ],
      child: MaterialApp(
        title: 'Notify Me',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromRGBO(60, 9, 108, 1),
          accentColor: Color.fromRGBO(90, 24, 154, 1),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
            color: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            textTheme: TextTheme(
              title: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        home: HomeScreen(),
        routes: {
          SubjectsScreen.routeName: (ctx) => SubjectsScreen(),
          TimeTableScreen.routeName: (ctx) => TimeTableScreen(),
        },
      ),
    );
  }
}
