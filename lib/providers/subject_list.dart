import 'package:flutter/widgets.dart';

import '../models/subject.dart';
import '../helpers/subject_db_helper.dart';
import '../helpers/time_table_db_helper.dart';
import '../helpers/notification_helper.dart';
import '../helpers/subject_helper.dart';

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
            present: sub['present'],
            absent: sub['absent'],
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

  // Add present
  void present(String id) {
    final subject = _subjectList.firstWhere((el) => el.id == id);
    subject.present++;
    notifyListeners();
    SubjectDBHelper.present(id);
  }

  // Add absent
  void absent(String id) {
    final subject = _subjectList.firstWhere((el) => el.id == id);
    subject.absent++;
    notifyListeners();
    SubjectDBHelper.absent(id);
  }

  // get total percentage
  double totalPercentage() {
    if (_subjectList.length == 0) return 0;
    double percent = 0;
    _subjectList.forEach((sub) {
      percent += SubjectHelper.percentage(
        presentClasses: sub.present,
        totalClasses: sub.present + sub.absent,
      );
    });
    return percent / _subjectList.length;
  }

  // get percentage
  double percentage(String id) {
    final subject = _subjectList.firstWhere((el) => el.id == id);
    return SubjectHelper.percentage(
      presentClasses: subject.present,
      totalClasses: subject.present + subject.absent,
    );
  }

  // get status
  String status({String id, int goal}) {
    final subject = _subjectList.firstWhere((el) => el.id == id);
    return SubjectHelper.status(
      goalPercentage: goal,
      presentClasses: subject.present,
      totalClasses: subject.present + subject.absent,
    );
  }

  // isSafe
  bool isSafe({String id, int goal}) {
    final subject = _subjectList.firstWhere((el) => el.id == id);
    return SubjectHelper.isSafe(
      goalPercentage: goal,
      presentClasses: subject.present,
      totalClasses: subject.present + subject.absent,
    );
  }
}
