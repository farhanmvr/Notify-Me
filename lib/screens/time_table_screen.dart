import 'package:flutter/material.dart';

import '../widgets/timeTableScreen/body.dart';
import '../widgets/timeTableScreen/add_day_sub_dialog.dart';

class TimeTableScreen extends StatelessWidget {
  static const routeName = '/time-table';
  int _currentIndex = 0;

  void _showAddSubDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AddDaySubDialog(context, _currentIndex),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Time Table'),
          bottom: TabBar(
            labelColor: Colors.black,
            isScrollable: true,
            onTap: (value) => _currentIndex = value,
            physics: BouncingScrollPhysics(),
            tabs: [
              Tab(text: 'Sunday'),
              Tab(text: 'Monday'),
              Tab(text: 'Tuesday'),
              Tab(text: 'Wednesday'),
              Tab(text: 'Thursday'),
              Tab(text: 'Friday'),
              Tab(text: 'Saturday'),
            ],
          ),
        ),
        body: Body(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddSubDialog(context);
          },
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
