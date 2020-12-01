import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/subject.dart';
import '../../models/assignment.dart';
import '../../providers/assignment_list.dart';
import '../../providers/subject_list.dart';
import '../../helpers/notification_helper.dart';

class AddAssignmentDialog extends StatefulWidget {
  final _parentContext;
  AddAssignmentDialog(this._parentContext);
  @override
  _AddAssignmentDialogState createState() => _AddAssignmentDialogState();
}

class _AddAssignmentDialogState extends State<AddAssignmentDialog> {
  final _titleController = TextEditingController();
  final _desController = TextEditingController();

  String _currentSub;
  List<Subject> subList;
  TimeOfDay _currentTime;
  DateTime _currentDate;

  void _addAssignment() {
    if (_titleController.text.trim().isEmpty ||
        _currentSub == null ||
        _currentSub == 'null' ||
        _currentTime == null ||
        _currentDate == null) return;

    Subject subject = subList.firstWhere((sub) => sub.id == _currentSub);
    DateTime dateTime = DateTime(
      _currentDate.year,
      _currentDate.month,
      _currentDate.day,
      _currentTime.hour,
      _currentTime.minute,
    );

    final id = DateTime.now().toString() + _currentSub;
    final assignment = Assignment(
      id: id,
      subId: subject.id,
      date: dateTime,
      time: _currentTime,
      description: _desController.text.trim(),
      title: _titleController.text.trim(),
    );

    Provider.of<AssignmentList>(context, listen: false).addAssignment(assignment);
    Navigator.of(context).pop();

    // Before one day
    NotificationHelper.scheduleAlarm(
      dateTime: dateTime.subtract(Duration(days: 1)),
      id: id.hashCode,
      title: 'Assignment Alert',
      body: 'You\'re having ${_titleController.text.trim()} of ${subject.name} tomorrow',
    );
    // Before one hour
    NotificationHelper.scheduleAlarm(
      dateTime: dateTime.subtract(Duration(hours: 1)),
      id: id.hashCode + 1,
      title: 'Assignment Alert',
      body:
          'The deadline of ${_titleController.text.trim()} of ${subject.name} is ${_currentTime.format(context)}',
    );
    // Before 10 mins
    NotificationHelper.scheduleAlarm(
      dateTime: dateTime.subtract(Duration(minutes: 10)),
      id: id.hashCode + 2,
      title: 'Assignment Alert',
      body:
          'Deadline of ${_titleController.text.trim()} is going to expire in 10 mins, Please submit it',
    );
    // On Time
    NotificationHelper.scheduleAlarm(
      dateTime: dateTime,
      id: id.hashCode + 3,
      title: 'Assignment Alert',
      body: 'Time of ${_titleController.text.trim()} is up, Hope you\'ve submitted it',
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

  void _showDatePicker(BuildContext context) async {
    DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: _currentDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 5000)),
    );
    if (pickedDate != null) {
      setState(() {
        _currentDate = pickedDate;
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
                          'ADD ASSIGNMENT',
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: _titleController,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          filled: true,
                          hintStyle: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.normal,
                          ),
                          hintText: "Title",
                          fillColor: Colors.white70),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: _desController,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          filled: true,
                          hintStyle: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.normal,
                          ),
                          hintText: "Description",
                          fillColor: Colors.white70),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: RaisedButton(
                      color: Colors.white,
                      onPressed: () {
                        _showDatePicker(context);
                      },
                      child: _currentDate == null
                          ? Text('Choose Date')
                          : Text(DateFormat('dd/MM/yyyy').format(_currentDate)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                        'Add Assignment',
                      ),
                      onPressed: () {
                        _addAssignment();
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
