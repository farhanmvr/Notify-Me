import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/homeScreen/body.dart';
import '../widgets/homeScreen/main_drawer.dart';
import '../providers/subject_list.dart';
import '../providers/day_subject_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFirst = true;

  Future<void> onStart() async {
    await Provider.of<DaySubjects>(context, listen: false).fetchTimeTable();
    await Provider.of<SubjectList>(context, listen: false).fetchAllSubjects();
  }

  @override
  void didChangeDependencies() async {
    if (isFirst) {
      await onStart();
    }
    isFirst = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notify Me'),
      ),
      drawer: MainDrawer(),
      body: Body(),
    );
  }
}
