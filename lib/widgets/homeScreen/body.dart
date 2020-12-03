import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/day_subject_list.dart';
import '../../models/day_subject.dart';
import './subject_tile.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final daySubData = Provider.of<DaySubjects>(context);
    List<DaySubject> subList;
    switch (DateTime.now().weekday) {
      case 1:
        subList = daySubData.monSub;
        break;
      case 2:
        subList = daySubData.tueSub;
        break;
      case 3:
        subList = daySubData.wedSub;
        break;
      case 4:
        subList = daySubData.thuSub;
        break;
      case 5:
        subList = daySubData.friSub;
        break;
      case 6:
        subList = daySubData.satSub;
        break;
      case 7:
        subList = daySubData.sunSub;
        break;
    }
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: ListView.builder(
        itemCount: subList.length,
        itemBuilder: (context, index) => Column(
          children: [
            SubjectTile(subList[index]),
            if(index==subList.length-1) SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
