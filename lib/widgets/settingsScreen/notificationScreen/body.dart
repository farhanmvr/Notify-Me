import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isClass = true;
  bool _isAssignment = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Assignment Notification',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            trailing: Switch(
              value: _isAssignment,
              onChanged: (val) {
                setState(() {
                  _isAssignment = val;
                });
              },
            ),
          ),
          ListTile(
            leading: Text(''),
            title: Text('10 min before'),
            trailing: Switch(
              activeColor: Colors.green,
              value: _isAssignment,
              onChanged: (val) {
                setState(() {
                  _isAssignment = val;
                });
              },
            ),
          ),
          ListTile(
            leading: Text(''),
            title: Text('1 hour before'),
            trailing: Switch(
              activeColor: Colors.green,
              value: _isAssignment,
              onChanged: (val) {
                setState(() {
                  _isAssignment = val;
                });
              },
            ),
          ),
          ListTile(
            leading: Text(''),
            title: Text('1 day before'),
            trailing: Switch(
              activeColor: Colors.green,
              value: _isAssignment,
              onChanged: (val) {
                setState(() {
                  _isAssignment = val;
                });
              },
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Class Notification',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            trailing: Switch(
              value: _isClass,
              onChanged: (val) {
                setState(() {
                  _isClass = val;
                });
              },
            ),
          ),
          ListTile(
            leading: Text(''),
            title: Text('30 min before'),
            trailing: Switch(
              activeColor: Colors.green,
              value: _isAssignment,
              onChanged: (val) {
                setState(() {
                  _isAssignment = val;
                });
              },
            ),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Exam Notification',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            trailing: Switch(
              value: _isClass,
              onChanged: (val) {
                setState(() {
                  _isClass = val;
                });
              },
            ),
          ),
          ListTile(
            leading: Text(''),
            title: Text('10 min before'),
            trailing: Switch(
              activeColor: Colors.green,
              value: _isAssignment,
              onChanged: (val) {
                setState(() {
                  _isAssignment = val;
                });
              },
            ),
          ),
          ListTile(
            leading: Text(''),
            title: Text('1 hour before'),
            trailing: Switch(
              activeColor: Colors.green,
              value: _isAssignment,
              onChanged: (val) {
                setState(() {
                  _isAssignment = val;
                });
              },
            ),
          ),
          ListTile(
            leading: Text(''),
            title: Text('1 day before'),
            trailing: Switch(
              activeColor: Colors.green,
              value: _isAssignment,
              onChanged: (val) {
                setState(() {
                  _isAssignment = val;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
