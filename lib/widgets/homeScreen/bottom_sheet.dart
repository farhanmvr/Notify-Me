import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/subject_list.dart';
import '../subjectsScreen/edit_sub_dialog.dart';
import '../alert/delete_alert.dart';

class MainBottomSheet extends StatelessWidget {
  String subId;
  MainBottomSheet(this.subId);

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => EditSubDialog(subId),
    );
  }

  void _showDeleteAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => DeleteAlert(
        onDelete: _onDelete,
        title: 'DELETE SUBJECT',
        body: 'Are you sure want to delete this subject ?',
        nb: 'This won\'t be able to retrieve once you delete this subject',
      ),
    );
  }

  void _onDelete(BuildContext context) {
    Provider.of<SubjectList>(context, listen: false).deleteSubject(context, subId);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(Icons.edit_outlined),
          title: Text(
            'Edit Subject',
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          onTap: () {
            Navigator.of(context).pop();
            _showEditDialog(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.delete_outline),
          title: Text(
            'Delete Subject',
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          onTap: () {
            _showDeleteAlert(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.undo_outlined),
          title: Text(
            'Undo',
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
        ),
        ListTile(
          leading: Icon(Icons.refresh_outlined),
          title: Text(
            'Reset Attendance',
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
