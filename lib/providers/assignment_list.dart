import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/assignment.dart';
import '../helpers/assignments_db_helper.dart';
import '../helpers/notification_helper.dart';

class AssignmentList with ChangeNotifier {
  List<Assignment> _assignmentList = [];

  List<Assignment> get assignments => [..._assignmentList];

  // Add Assignments
  void addAssignment(Assignment assignment) {
    _assignmentList.add(assignment);
    _assignmentList.sort((a, b) => a.date.compareTo(b.date));
    notifyListeners();

    AssignmentsDBHelper.insert({
      'id': assignment.id,
      'subId': assignment.subId,
      'title': assignment.title,
      'description': assignment.description,
      'dateTime': assignment.date.toIso8601String(),
    });
  }

  // Fetch all assignments
  Future<void> fetchAssignments() async {
    final data = await AssignmentsDBHelper.assignments;
    data.forEach((el) {
      DateTime date = DateTime.parse(el['dateTime']);
      if (date.compareTo(DateTime.now()) < 0) {
        AssignmentsDBHelper.deleteExpired(el['id']);
        NotificationHelper.deleteNotificatons(el['id'].hashCode);
        NotificationHelper.deleteNotificatons(el['id'].hashCode+1);
        NotificationHelper.deleteNotificatons(el['id'].hashCode+2);
        NotificationHelper.deleteNotificatons(el['id'].hashCode+3);
      } else {
        TimeOfDay time = TimeOfDay(hour: date.hour, minute: date.minute);
        _assignmentList.add(Assignment(
          id: el['id'],
          subId: el['subId'],
          title: el['title'],
          description: el['description'],
          date: date,
          time: time,
        ));
      }
    });
    _assignmentList.sort((a, b) => a.date.compareTo(b.date));
    notifyListeners();
  }
}
