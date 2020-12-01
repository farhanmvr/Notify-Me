import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Attendance with ChangeNotifier {
  int goal;

  // Get goal percentage
  int get goalPercent => goal;

  // Fetch goal percentage
  Future<void> fetchGoal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.goal = prefs.getInt('goal')??80;
    notifyListeners();
  }

  // Set goal
  Future<void> setGoal(int goal) async {
    this.goal = goal;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('goal', goal);
  }
}
