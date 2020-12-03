import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../providers/attendance.dart';
import '../../../screens/home_screen.dart';

class Body extends StatefulWidget {
  final isFirst;
  Body(this.isFirst);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  double _goalPercent;
  @override
  void initState() {
    if (widget.isFirst)
      _goalPercent = 80;
    else
      _goalPercent = Provider.of<Attendance>(context, listen: false).goal * 1.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final attendanceData = Provider.of<Attendance>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircularPercentIndicator(
                radius: 200,
                percent: _goalPercent.round() / 100,
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Theme.of(context).primaryColor,
                lineWidth: 10,
                center: Text(
                  '${_goalPercent.round()}%',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Slider(
                value: _goalPercent,
                min: 1,
                max: 100,
                divisions: 99,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (newValue) {
                  setState(() {
                    _goalPercent = newValue;
                  });
                },
              ),
            ],
          ),
        ),
        RaisedButton(
          onPressed: () async {
            attendanceData.setGoal(_goalPercent.round());
            if (widget.isFirst) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('isFirst', false);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (BuildContext context) => HomeScreen(isFirst: false)),
              );
            } else
              Navigator.of(context).pop();
          },
          elevation: 35,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 40),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text('SET GOAL', style: TextStyle(fontSize: 17)),
          ),
        ),
      ],
    );
  }
}
