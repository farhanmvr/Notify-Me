import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/subject.dart';
import '../alert/delete_alert.dart';
import '../../providers/subject_list.dart';
import '../../providers/day_subject_list.dart';

class SubjectTile extends StatelessWidget {
  final Subject subject;
  var subData;
  var daySubData;
  SubjectTile(this.subject);

  void _showAddSubDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => DeleteAlert(onDelete),
    );
  }

  void onDelete(BuildContext context) async {
    await subData.deleteSubject(subject.id);
    daySubData.deleteDaySubject(subject.id);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    subData = Provider.of<SubjectList>(context);
    daySubData = Provider.of<DaySubjects>(context);
    return ListTile(
      title: Text(
        subject.name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.delete_outline,
          color: Theme.of(context).errorColor,
        ),
        onPressed: () {
          _showAddSubDialog(context);
        },
      ),
    );
  }
}
