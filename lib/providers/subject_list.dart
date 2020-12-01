import 'package:flutter/widgets.dart';

import '../models/subject.dart';
import '../helpers/subject_db_helper.dart';
import '../helpers/time_table_db_helper.dart';
import '../helpers/notification_helper.dart';

class SubjectList with ChangeNotifier {
  List<Subject> _subjectList = [];

  // Get subject list
  List<Subject> get subjects => [..._subjectList];

  // Get subject by ID
  Subject getSub(String id) {
    return _subjectList.firstWhere((sub) => sub.id == id);
  }

  // Fetch all subjects
  Future<void> fetchAllSubjects() async {
    List<Map<String, dynamic>> subList = await SubjectDBHelper.subjects;
    _subjectList = subList
        .map(
          (sub) => Subject(
            id: sub['id'],
            name: sub['name'],
          ),
        )
        .toList();
    notifyListeners();
  }

  // Add subject
  void addSubject({String name}) {
    String id = DateTime.now().toString() + name;
    _subjectList.add(Subject(id: id, name: name));
    notifyListeners();
    SubjectDBHelper.insert({
      'id': id,
      'name': name,
    });
  }

  // Delete subject
  void deleteSubject(String id) async {
    _subjectList.removeWhere((el) => el.id == id);
    notifyListeners();

    // Delete Notifications
    final notficationIds = await TimeTableDBHelper.getNotificationIds(id);
    notficationIds.forEach((el) async {
      await NotificationHelper.deleteNotificatons(el['id'].hashCode);
      await NotificationHelper.deleteNotificatons(el['id'].hashCode + 1);
    });

    // Delete form db
    await SubjectDBHelper.deleteById(id);
  }
}
