import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/assignment.dart';
import '../../providers/assignment_list.dart';
import './assignment_tile.dart';

class Body extends StatelessWidget {
  Widget getWidget(BuildContext context, List<Assignment> assignments) {
    if (assignments.length == 0) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'It seems you don\'t have any assignments',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: assignments.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Padding(
              padding: index == 0 ? const EdgeInsets.only(top: 8) : const EdgeInsets.all(0),
              child: AssignmentTile(assignments[index]),
            ),
            if (index != assignments.length - 1) Divider(),
            if (index == assignments.length - 1)
              SizedBox(height: MediaQuery.of(context).size.height * .15),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final assignments = Provider.of<AssignmentList>(context).assignments;
    return getWidget(context, assignments);
  }
}
