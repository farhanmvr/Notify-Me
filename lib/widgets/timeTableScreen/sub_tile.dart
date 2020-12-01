import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/day_subject.dart';
import '../alert/delete_alert.dart';
import '../../models/subject.dart';
import '../../providers/subject_list.dart';

class SubTile extends StatelessWidget {
  final DaySubject subject;
  const SubTile({Key key, this.subject}) : super(key: key);

  void _showAddSubDialog(BuildContext context) {
    showDialog(
        context: context, barrierDismissible: false, builder: (ctx) => DeleteAlert(onDelete));
  }

  void onDelete(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    Subject sub = Provider.of<SubjectList>(context).getSub(subject.subId);
    return ListTile(
      title: Text(
        sub.name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subject.time.format(context)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit_outlined, color: Theme.of(context).primaryColor),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.delete_outline, color: Theme.of(context).errorColor),
            onPressed: () {
              _showAddSubDialog(context);
            },
          ),
        ],
      ),
    );
  }
}
