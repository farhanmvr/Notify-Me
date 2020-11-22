import 'package:flutter/material.dart';

import '../../models/subject.dart';
import '../Alert/delete_alert.dart';

class SubjectTile extends StatelessWidget {
  final Subject subject;
  SubjectTile(this.subject);

  void _showAddSubDialog(BuildContext context) {
    showDialog(
        context: context, barrierDismissible: false, builder: (ctx) => DeleteAlert(onDelete));
  }

  void onDelete(BuildContext context) {
    
  }

  @override
  Widget build(BuildContext context) {
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
