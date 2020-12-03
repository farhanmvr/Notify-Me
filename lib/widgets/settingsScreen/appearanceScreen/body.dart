import 'package:flutter/material.dart';

import './theme_dialog.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isTimeTable = true;

  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (context) => ThemeDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Display',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.brightness_4_outlined,
                    size: 28,
                  ),
                ],
              ),
              title: Text(
                'Theme',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text('Light'),
              onTap: _showThemeDialog,
            ),
            Divider(),
            Text(
              'Mode',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            ListTile(
              title: Text(
                'Time Table',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: Switch(
                value: _isTimeTable,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (isActive) {
                  setState(() {
                    _isTimeTable = isActive;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
