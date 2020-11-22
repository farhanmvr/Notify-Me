import 'package:flutter/widgets.dart';

import '../models/subject.dart';
import '../helpers/subject_db_helper.dart';

class SubjectList with ChangeNotifier {
  List<Subject> _subjectList = [];

  // Get subject list
  List<Subject> get subjects => [..._subjectList];

  // Fetch all subjects
  Future<void> fetchAllSubjects() async {
    List<Map<String, dynamic>> subList = await SubjectDBHelper.subjects;
    _subjectList = subList.map(
      (sub) => Subject(
        id: sub['id'],
        name: sub['name'],
      ),
    ).toList();
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
}
