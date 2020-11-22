import 'package:flutter/material.dart';

import '../widgets/subjectsScreen/body.dart';
import '../widgets/subjectsScreen/add_sub_dialog.dart';

class SubjectsScreen extends StatelessWidget {
  static const routeName = '/subjects';

  void _showAddSubDialog(BuildContext context) {
    showDialog(
        context: context, barrierDismissible: false, builder: (ctx) => AddSubDialog(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subjects'),
      ),
      body: Body(),
      floatingActionButton: Builder(
        builder: (ctx) => FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
          onPressed: () {
            _showAddSubDialog(ctx);
          },
        ),
      ),
    );
  }
}
