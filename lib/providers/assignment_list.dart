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

  // Delete by id
  Future<void> deleteById(String id) async {
    _assignmentList.removeWhere((element) => element.id == id);
    notifyListeners();

    // Delete assignment Notifications
    await NotificationHelper.deleteNotificatons(id.hashCode);
    await NotificationHelper.deleteNotificatons(id.hashCode + 1);
    await NotificationHelper.deleteNotificatons(id.hashCode + 2);
    await NotificationHelper.deleteNotificatons(id.hashCode + 3);
    // Delete from db
    await AssignmentsDBHelper.deleteById(id);
  }

  // Delete Assignment by Subject ID
  Future<void> deleteBySubId(String subId) async {
    _assignmentList.removeWhere((element) => element.subId == subId);
    notifyListeners();

    // Delete assignment Notifications
    final asgmtNtfcnIds = await AssignmentsDBHelper.getNotificationIds(subId);
    asgmtNtfcnIds.forEach((el) async {
      await NotificationHelper.deleteNotificatons(el['id'].hashCode);
      await NotificationHelper.deleteNotificatons(el['id'].hashCode + 1);
      await NotificationHelper.deleteNotificatons(el['id'].hashCode + 2);
      await NotificationHelper.deleteNotificatons(el['id'].hashCode + 3);
    });
    // Delete from db
    await AssignmentsDBHelper.deleteBySubId(subId);
  }

  // Fetch all assignments
  Future<void> fetchAssignments() async {
    final data = await AssignmentsDBHelper.assignments;
    data.forEach((el) {
      DateTime date = DateTime.parse(el['dateTime']);
      if (date.compareTo(DateTime.now()) < 0) {
        AssignmentsDBHelper.deleteById(el['id']);
        NotificationHelper.deleteNotificatons(el['id'].hashCode);
        NotificationHelper.deleteNotificatons(el['id'].hashCode + 1);
        NotificationHelper.deleteNotificatons(el['id'].hashCode + 2);
        NotificationHelper.deleteNotificatons(el['id'].hashCode + 3);
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
