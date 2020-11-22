import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/subject_list.dart';

class AddSubDialog extends StatelessWidget {
  final _parentContext;
  AddSubDialog(this._parentContext);

  final _subNameController = TextEditingController();

  void _addSub(BuildContext context) {
    Scaffold.of(_parentContext).hideCurrentSnackBar();
    if (_subNameController.text.trim().isEmpty) {
      Scaffold.of(_parentContext).showSnackBar(SnackBar(
        content: Text('Enter subject name'),
        backgroundColor: Theme.of(context).errorColor,
        duration: Duration(seconds: 1),
      ));
      Timer(Duration(seconds: 2), () {
        Scaffold.of(_parentContext).hideCurrentSnackBar();
      });
      return;
    }
    Provider.of<SubjectList>(context, listen: false)
        .addSubject(name: _subNameController.text.trim());
    Navigator.of(context).pop();
    _showSnackbar();
  }

  void _showSnackbar() {
    Scaffold.of(_parentContext).showSnackBar(SnackBar(
      content: Text('subject added successfully'),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 1),
    ));
    Timer(Duration(seconds: 2), () {
      Scaffold.of(_parentContext).hideCurrentSnackBar();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'ADD SUBJECT',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          padding: const EdgeInsets.all(0),
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: _subNameController,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                          filled: true,
                          hintStyle:
                              TextStyle(color: Colors.grey[800], fontWeight: FontWeight.normal),
                          hintText: "Enter subject name",
                          fillColor: Colors.white70),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      height: 48,
                      child: FlatButton.icon(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
                        ),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        icon: Icon(Icons.add),
                        label: Text(
                          'Add Subject',
                        ),
                        onPressed: () {
                          _addSub(context);
                        },
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
