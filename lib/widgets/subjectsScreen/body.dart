import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/subject_list.dart';
import '../../models/subject.dart';
import './subject_tile.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  Widget getWidget(BuildContext context, List<Subject> subjects) {
    if (subjects.length == 0) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'It seems you haven\'t added any subjects yet, please add your subjects here',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            SubjectTile(subjects[index]),
            if (index != subjects.length - 1) Divider(),
            if (index == subjects.length - 1)
              SizedBox(height: MediaQuery.of(context).size.height * .15),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final subjects = Provider.of<SubjectList>(context).subjects;
    return getWidget(context, subjects);
  }
}
