import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../providers/attendance.dart';
import '../../providers/subject_list.dart';

class HomeDetailsCard extends StatelessWidget {
  Widget _detailsRow({IconData icon, String title, String value}) {
    return Row(
      children: <Widget>[
        Icon(icon, size: 26),
        SizedBox(width: 3),
        Text(title, style: TextStyle(fontSize: 15)),
        SizedBox(width: 3),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalPercent =
        (Provider.of<SubjectList>(context).totalPercentage() * 10).truncateToDouble() / 10;
    final goal = Provider.of<Attendance>(context).goal;
    final isSafe = totalPercent >= goal;
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _detailsRow(
                          icon: Icons.flag,
                          title: 'Goal',
                          value: '${goal}%',
                        ),
                        SizedBox(height: 2),
                        _detailsRow(
                            icon: Icons.bubble_chart,
                            title: 'Total',
                            value: totalPercent == double.parse(totalPercent.toStringAsFixed(0))
                                ? totalPercent.toStringAsFixed(0) + '%'
                                : totalPercent.toString() + '%'),
                      ],
                    ),
                    CircularPercentIndicator(
                      radius: 55,
                      center: Text(
                        totalPercent == double.parse(totalPercent.toStringAsFixed(0))
                            ? totalPercent.toStringAsFixed(0) + '%'
                            : totalPercent.toString() + '%',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      progressColor: isSafe ? Colors.green : Theme.of(context).errorColor,
                      percent: totalPercent/100,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  DateFormat('dd EEEE yyyy').format(DateTime.now()),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
