import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../providers/subject_list.dart';
import '../../models/subject.dart';

class EditSubDialog extends StatelessWidget {
  final subId;
  EditSubDialog(this.subId);

  TextEditingController _subNameController = TextEditingController();
  TextEditingController _presentController = TextEditingController();
  TextEditingController _absentController = TextEditingController();

  void _onPressed(BuildContext context) {
    final name = _subNameController.text;
    final present = int.tryParse(_presentController.text);
    final absent = int.tryParse(_absentController.text);

    if (name.isEmpty || present == null || absent == null || present < 0 || absent < 0) return;

    Subject sub = Subject(id: subId, name: name, present: present, absent: absent);
    Provider.of<SubjectList>(context, listen: false).editSubject(subId, sub);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final subData = Provider.of<SubjectList>(context, listen: false);
    final subject = subData.getSub(subId);
    _subNameController.text = subject.name;
    _presentController.text = subject.present.toString();
    _absentController.text = subject.absent.toString();
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
                    padding: const EdgeInsets.only(left: 15, top: 12),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.edit, color: Theme.of(context).primaryColor),
                        SizedBox(width: 4),
                        Text(
                          'EDIT SUBJECT',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
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
                        hintText: "Subject name",
                        fillColor: Colors.white70,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                flex: 3,
                                child: Text('Present: '),
                              ),
                              Flexible(
                                flex: 1,
                                child: TextField(
                                  controller: _presentController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                flex: 3,
                                child: Text('Absent: '),
                              ),
                              Flexible(
                                flex: 1,
                                child: TextField(
                                  controller: _absentController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: FlatButton(
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15)),
                              ),
                              color: Theme.of(context).accentColor,
                              textColor: Colors.white,
                              child: Text('Cancel'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: FlatButton(
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.only(bottomRight: Radius.circular(15))),
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              child: Text('Ok'),
                              onPressed: () {
                                _onPressed(context);
                              },
                            ),
                          ),
                        ),
                      ],
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
