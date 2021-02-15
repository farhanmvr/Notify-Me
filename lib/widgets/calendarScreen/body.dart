import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import './bottom_card.dart';

class Body extends StatefulWidget {
  final subId;
  Body(this.subId);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  CalendarController _controller;

  @override
  void initState() {
    _controller = CalendarController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          child: TableCalendar(
            // events: _events,
            calendarController: _controller,
            endDay: DateTime.now(),
            availableCalendarFormats: const {CalendarFormat.month: 'Month'},
            calendarStyle: CalendarStyle(
              markersColor: Colors.deepPurple,
              todayColor: Colors.grey,
              selectedColor: Theme.of(context).primaryColor,
            ),
            headerStyle: HeaderStyle(
              centerHeaderTitle: true,
            ),
            onDaySelected: (date, events, holidays) => null,
          ),
        ),
        Expanded(
          child: BottomCard(),
        ),
      ],
    );
  }
}
