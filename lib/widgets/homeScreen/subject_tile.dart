import 'package:flutter/material.dart';

import '../../models/day_subject.dart';

class SubjectTile extends StatelessWidget {
  final DaySubject subject;
  SubjectTile(this.subject);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListTile(
      title: Text(
        subject.name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subject.time.format(context)),
    );
  }
}
