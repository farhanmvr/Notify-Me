import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/homeScreen/body.dart';
import '../widgets/homeScreen/main_drawer.dart';
import '../widgets/homeScreen/home_detail_card.dart';
import '../providers/subject_list.dart';
import '../providers/day_subject_list.dart';
import '../providers/assignment_list.dart';
import '../providers/attendance.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFirst = true;

  Future<void> onStart() async {
    await Provider.of<Attendance>(context, listen: false).fetchGoal();
    await Provider.of<SubjectList>(context, listen: false).fetchAllSubjects();
    await Provider.of<DaySubjects>(context, listen: false).fetchTimeTable();
    Provider.of<AssignmentList>(context, listen: false).fetchAssignments();
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
      body: NestedScrollView(
        headerSliverBuilder: (ctx, innerBoxScrolled) => <Widget>[
          SliverAppBar(
            leading: SizedBox(),
            elevation: 0,
            pinned: false,
            expandedHeight: 130,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.all(8.0),
                child: HomeDetailsCard(),
              ),
            ),
          ),
        ],
        body: Body(),
      ),
    );
  }
}
