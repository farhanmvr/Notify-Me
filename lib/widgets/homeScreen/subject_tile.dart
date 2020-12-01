import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../models/day_subject.dart';
import '../../models/subject.dart';
import '../../providers/subject_list.dart';

class SubjectTile extends StatelessWidget {
  final DaySubject subject;
  SubjectTile(this.subject);
  @override
  Widget build(BuildContext context) {
    Subject sub = Provider.of<SubjectList>(context).getSub(subject.subId);
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            // Navigator.of(context).pushNamed(CalendarViewScreen.routeName, arguments: subject.id);
          },
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                              '2/3',
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
                                  color: Colors.grey, fontWeight: FontWeight.w700, fontSize: 13),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Expanded(
                              child: Text(
                                'Attend next 2 classes to get back on track',
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
                        percent: .5,
                        lineWidth: 4,
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Theme.of(context).errorColor,
                        center: Text(
                          '50%',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              // subject.addAbsent();
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
                              // subject.addPresent();
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
