import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../models/day_subject.dart';
import '../../providers/subject_list.dart';
import '../../providers/attendance.dart';
import './bottom_sheet.dart';

class SubjectTile extends StatelessWidget {
  final DaySubject subject;
  SubjectTile(this.subject);
  @override
  Widget build(BuildContext context) {
    final sub = Provider.of<SubjectList>(context).getSub(subject.subId);
    final subData = Provider.of<SubjectList>(context);
    final percent =
        (Provider.of<SubjectList>(context).percentage(sub.id) * 10).truncateToDouble() / 10;
    final goal = Provider.of<Attendance>(context).goal;
    final isSafe = Provider.of<SubjectList>(context).isSafe(goal: goal, id: sub.id);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 4),
          child: Text(
            subject.time.format(context),
            style: TextStyle(fontSize: 10),
          ),
        ),
        GestureDetector(
          onTap: () {
            // Navigator.of(context).pushNamed(CalendarViewScreen.routeName, arguments: subject.id);
          },
          onLongPress: () {
            showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              builder: (context) => MainBottomSheet(subject.subId),
            );
          },
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * .6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          sub.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Attendance:',
                              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              '${sub.present}/${sub.present + sub.absent}',
                              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Status:',
                              style: TextStyle(
                                  color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 12),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Expanded(
                              child: Text(
                                subData.status(goal: goal, id: sub.id),
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      CircularPercentIndicator(
                        radius: 58,
                        percent: percent / 100,
                        lineWidth: 4,
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: isSafe ? Colors.green : Theme.of(context).errorColor,
                        center: Text(
                          percent == double.parse(percent.toStringAsFixed(0))
                              ? percent.toStringAsFixed(0) + '%'
                              : percent.toString() + '%',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              subData.absent(sub.id);
                            },
                            child: CircularPercentIndicator(
                              radius: 30,
                              lineWidth: 3,
                              percent: 1,
                              progressColor: Theme.of(context).errorColor,
                              center: Icon(
                                Icons.close,
                                color: Theme.of(context).errorColor,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          GestureDetector(
                            onTap: () {
                              subData.present(sub.id);
                            },
                            child: CircularPercentIndicator(
                              radius: 30,
                              lineWidth: 3,
                              percent: 1,
                              progressColor: Colors.green,
                              center: Icon(
                                Icons.done,
                                color: Colors.green,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
