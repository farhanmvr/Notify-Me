import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../models/subject.dart';
import '../../providers/subject_list.dart';
import '../../providers/day_subject_list.dart';
import '../../providers/attendance.dart';
import '../alert/delete_alert.dart';
import './edit_sub_dialog.dart';

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

  void _showEditSubDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => EditSubDialog(subject.id),
    );
  }

  void onDelete(BuildContext context) async {
    await subData.deleteSubject(context, subject.id);
  }

  @override
  Widget build(BuildContext context) {
    subData = Provider.of<SubjectList>(context);
    daySubData = Provider.of<DaySubjects>(context);
    final percent =
        (Provider.of<SubjectList>(context).percentage(subject.id) * 10).truncateToDouble() / 10;
    final goal = Provider.of<Attendance>(context).goal;
    final isSafe = Provider.of<SubjectList>(context).isSafe(goal: goal, id: subject.id);
    return ListTile(
      leading: CircularPercentIndicator(
        radius: 40,
        lineWidth: 4,
        percent: subData.percentage(subject.id) / 100,
        progressColor: isSafe ? Colors.green : Theme.of(context).errorColor,
        center: Text(
          percent == double.parse(percent.toStringAsFixed(0))
              ? percent.toStringAsFixed(0) + '%'
              : percent.toString() + '%',
          style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700),
        ),
      ),
      title: Text(
        subject.name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              Icons.delete_outline,
              color: Theme.of(context).errorColor,
            ),
            onPressed: () {
              _showAddSubDialog(context);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.edit_outlined,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              _showEditSubDialog(context);
            },
          ),
        ],
      ),
    );
  }
}
