import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/assignment.dart';
import '../../providers/subject_list.dart';

class AssignmentTile extends StatelessWidget {
  final Assignment assignment;
  AssignmentTile(this.assignment);
  @override
  Widget build(BuildContext context) {
    final sub = Provider.of<SubjectList>(context).getSub(assignment.subId);
    return ListTile(
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
    );
  }
}
