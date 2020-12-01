import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../alert/delete_alert.dart';
import '../../models/assignment.dart';
import '../../providers/subject_list.dart';
import '../../providers/assignment_list.dart';

class AssignmentTile extends StatelessWidget {
  final Assignment assignment;
  AssignmentTile(this.assignment);

  Future<bool> _showDeleteDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx) => DeleteAlert(
        onDelete: onDelete,
        title: 'DELETE ASSIGNMENT',
        body: 'Are you sure want to delete this assignment?',
        nb: 'This won\'t be able to retrieve once you delete this assignment',
      ),
    );
  }

  void onDelete(BuildContext context) {
    Provider.of<AssignmentList>(context, listen: false).deleteById(assignment.id);
  }

  @override
  Widget build(BuildContext context) {
    final sub = Provider.of<SubjectList>(context).getSub(assignment.subId);
    final size = MediaQuery.of(context).size;
    return Dismissible(
      key: Key(assignment.id),
      direction: DismissDirection.endToStart,
      movementDuration: Duration(microseconds: 500),
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        child: Padding(
          padding: EdgeInsets.only(right: size.width * .1),
          child: Icon(
            Icons.delete_outline,
            color: Theme.of(context).errorColor,
          ),
        ),
      ),
      confirmDismiss: (ctx) => _showDeleteDialog(context),
      child: ListTile(
        title: Text(
          assignment.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2),
            Text(sub.name, style: TextStyle(color: Colors.black)),
            if (assignment.description != null) SizedBox(height: 2),
            if (assignment.description != null) Text(assignment.description),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(DateFormat('MMM dd').format(assignment.date)),
            Text(assignment.time.format(context)),
          ],
        ),
      ),
    );
  }
}
