import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './screens/home_screen.dart';
import './screens/subjects_screen.dart';
import './screens/time_table_screen.dart';
import './screens/assignments_screen.dart';
import './screens/settings_screen.dart';
import './screens/appearance_screen.dart';
import './screens/notification_screen.dart';
import './screens/calendar_screen.dart';
import './providers/subject_list.dart';
import './providers/day_subject_list.dart';
import './providers/assignment_list.dart';
import './providers/attendance.dart';

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

  SharedPreferences pref = await SharedPreferences.getInstance();
  bool isFirst = pref.getBool('isFirst') ?? true;

  runApp(MyApp(isFirst));
}

class MyApp extends StatelessWidget {
  final isFirst;
  MyApp(this.isFirst);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => SubjectList()),
        ChangeNotifierProvider(create: (ctx) => DaySubjects()),
        ChangeNotifierProvider(create: (ctx) => AssignmentList()),
        ChangeNotifierProvider(create: (ctx) => Attendance()),

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
        home: HomeScreen(isFirst: isFirst),
        routes: {
          SubjectsScreen.routeName: (ctx) => SubjectsScreen(),
          TimeTableScreen.routeName: (ctx) => TimeTableScreen(),
          AssignmentsScreen.routeName: (ctx) => AssignmentsScreen(),
          SettingsScreen.routeName: (ctx) => SettingsScreen(),
          AppearenceScreen.routeName: (ctx) => AppearenceScreen(),
          NotificationScreen.routeName: (ctx) => NotificationScreen(),
          CalendarScreen.routeName: (ctx) => CalendarScreen(),
        },
      ),
    );
  }
}
