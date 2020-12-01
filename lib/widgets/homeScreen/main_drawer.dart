import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../screens/subjects_screen.dart';
import '../../screens/time_table_screen.dart';
import '../../screens/assignments_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Event Reminder',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  DateFormat('dd/MM/yyyy').format(DateTime.now()),
                )
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white70,
            ),
          ),
          GestureDetector(
            child: ListTile(
              title: Text('Subjects'),
              leading: Icon(
                Icons.account_balance_wallet,
                color: Color.fromRGBO(0, 0, 0, .65),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(SubjectsScreen.routeName);
              },
            ),
          ),
          GestureDetector(
            child: ListTile(
              title: Text('Time Table'),
              leading: Icon(
                Icons.timeline,
                color: Color.fromRGBO(0, 0, 0, .65),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(TimeTableScreen.routeName);
              },
            ),
          ),
          GestureDetector(
            child: ListTile(
              title: Text('Assignments'),
              leading: Icon(
                Icons.assignment_outlined,
                color: Color.fromRGBO(0, 0, 0, .65),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(AssignmentsScreen.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
