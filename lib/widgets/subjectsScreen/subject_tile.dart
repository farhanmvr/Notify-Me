import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/subject.dart';
import '../alert/delete_alert.dart';
import '../../providers/subject_list.dart';
import '../../providers/day_subject_list.dart';
import '../../providers/assignment_list.dart';

class SubjectTile extends StatelessWidget {
  final Subject subject;
  var subData;
  var daySubData;
  SubjectTile(this.subject);

  void _showAddSubDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => DeleteAlert(
        onDelete: onDelete,
        title: 'DELETE SUBJECT',
        body: 'Are you sure want to delete this subject ?',
        nb: 'This won\'t be able to retrieve once you delete this subject',
      ),
    );
  }

  void onDelete(BuildContext context) async {
    await subData.deleteSubject(subject.id);
    daySubData.deleteBySubId(subject.id);
    Provider.of<AssignmentList>(context, listen: false).deleteBySubId(subject.id);
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
