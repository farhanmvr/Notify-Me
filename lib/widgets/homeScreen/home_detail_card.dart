import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
    final size = MediaQuery.of(context).size;
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
                          value: '80%',
                        ),
                        SizedBox(height: 2),
                        _detailsRow(
                          icon: Icons.bubble_chart,
                          title: 'Total',
                          value: '75.4%',
                        ),
                      ],
                    ),
                    CircularPercentIndicator(
                      radius: size.width * .035 + 34,
                      center: Text(
                        '80%',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width * .035),
                      ),
                      progressColor: Colors.green,
                      percent: .8,
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
