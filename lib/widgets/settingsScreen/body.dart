import 'package:flutter/material.dart';

import '../../screens/appearance_screen.dart';
import '../../screens/goal_percent_screen.dart';
import '../../screens/notification_screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.graphic_eq_outlined,
                  size: 30,
                ),
              ],
            ),
            title: const Text(
              'Appearance',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: const Text('Dark mode, Theme, switch mode'),
            onTap: () => Navigator.of(context).pushNamed(AppearenceScreen.routeName),
          ),
          ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications_none,
                  size: 30,
                ),
              ],
            ),
            title: const Text(
              'Notifications',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: const Text('Notification, mute, sound'),
            onTap: () => Navigator.of(context).pushNamed(NotificationScreen.routeName),
          ),
          ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.app_registration,
                  size: 30,
                ),
              ],
            ),
            title: Text(
              'Goal Percentage',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text('Set goal percentage'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => GoalPercentScreen(false)),
            ),
          ),
          ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.help_outline,
                  size: 30,
                ),
              ],
            ),
            title: Text(
              'Help',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text('FAQ, contact us, privacy policy'),
          ),
          Divider(),
          ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.share_outlined,
                  size: 30,
                ),
              ],
            ),
            title: Text(
              'Share App',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text('Share this app to your friends'),
          ),
        ],
      ),
    );
  }
}
