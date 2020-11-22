import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import '../../providers/subject_list.dart';
import '../../providers/day_subject_list.dart';
import '../../models/subject.dart';
import '../../models/day_subject.dart';
import '../../helpers/notification_helper.dart';

class AddDaySubDialog extends StatefulWidget {
  final _parentContext;
  final _index;
  AddDaySubDialog(this._parentContext, this._index);

  @override
  _AddDaySubDialogState createState() => _AddDaySubDialogState();
}

class _AddDaySubDialogState extends State<AddDaySubDialog> {
  String _currentSub;
  List<Subject> subList;
  TimeOfDay _currentTime;

  void _addSub(BuildContext context) {
    // Scaffold.of(widget._parentContext).hideCurrentSnackBar();
    if (_currentSub == null || _currentSub == 'null' || _currentTime == null) return;
    Subject subject = subList.firstWhere((element) => element.id == _currentSub);
    String id = DateTime.now().toString() + subject.id;
    DaySubject sub = DaySubject(
      id: id,
      subId: subject.id,
      name: subject.name,
      day: Day(widget._index + 1),
      time: _currentTime,
    );
    Provider.of<DaySubjects>(context, listen: false).addSubject(
      day: Day(widget._index + 1),
      subject: sub,
    );
    Navigator.of(context).pop();

    Day day = Day(widget._index + 1);
    Time time = Time(_currentTime.hour, _currentTime.minute);

    // On time notification
    NotificationHelper.scheduleWeeklyNotification(
      id: id.hashCode,
      title: 'Class Reminder',
      body: 'You\'re having ${subject.name} class Now',
      day: day,
      time: time,
    );

    // Notification 30mins priorer
    DateTime now = DateTime.now();
    int dayInFlutter = widget._index == 0 ? 7 : widget._index;
    DateTime priorerTime = DateTime(
      now.year,
      now.month,
      dayInFlutter,
      _currentTime.hour,
      _currentTime.minute,
    ).subtract(Duration(minutes: 30));

    NotificationHelper.scheduleWeeklyNotification(
      id: id.hashCode + 1,
      title: 'Class Reminder',
      body: 'You\'re having ${subject.name} class at ${_currentTime.format(context)}',
      day: priorerTime.day == 7 ? Day(1) : Day(priorerTime.day+1),
      time: Time(priorerTime.hour,priorerTime.minute),
    );
  }

  void _showTimePicker(BuildContext context) async {
    TimeOfDay selectedTime = await showTimePicker(
      initialTime: _currentTime ?? TimeOfDay.now(),
      context: context,
    );
    if (selectedTime != null) {
      setState(() {
        _currentTime = selectedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    subList = Provider.of<SubjectList>(context).subjects;
    subList.insert(0, Subject(id: 'null', name: 'Choose subject'));
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'ADD SUBJECT',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          padding: const EdgeInsets.all(0),
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: subList.length == 0
                        ? Text('No subjects')
                        : Row(
                            children: [
                              Text(
                                'Subject:',
                                style: TextStyle(fontSize: 15),
                              ),
                              SizedBox(width: 10),
                              DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  onChanged: (value) {
                                    setState(() {
                                      _currentSub = value;
                                    });
                                  },
                                  value: _currentSub ?? subList[0].id,
                                  items: subList
                                      .map((sub) => DropdownMenuItem(
                                            child: Text(sub.name),
                                            value: sub.id,
                                          ))
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RaisedButton(
                      color: Colors.white,
                      onPressed: () {
                        _showTimePicker(context);
                      },
                      child: _currentTime == null
                          ? Text('Choose Time')
                          : Text(_currentTime.format(context)),
                    ),
                  ),
                  SizedBox(
                    height: 48,
                    child: FlatButton.icon(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
                      ),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      icon: Icon(Icons.add),
                      label: Text(
                        'Add Subject',
                      ),
                      onPressed: () {
                        _addSub(context);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
