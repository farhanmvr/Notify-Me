import 'package:flutter/material.dart';

import '../widgets/assignmentsScreen/body.dart';
import '../widgets/assignmentsScreen/add_assignment_dialog.dart';

void _showAddAssignmentDialog(BuildContext context) {
    showDialog(
        context: context, barrierDismissible: false, builder: (ctx) => AddAssignmentDialog(context));
  }

class AssignmentsScreen extends StatelessWidget {
  static const routeName = '/assignments';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignments'),
      ),
      body: Body(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {
          _showAddAssignmentDialog(context);
        },
      ),
    );
  }
}
