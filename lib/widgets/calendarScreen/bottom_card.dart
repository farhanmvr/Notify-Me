import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class BottomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Icon(Icons.calendar_today,
                          size: 38, color: Theme.of(context).accentColor),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        '25',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'SEPT',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              SizedBox(width: 5),
              Text(
                'MONDAY',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TimelineTile(
                  indicatorStyle: IndicatorStyle(
                    height: 25,
                    width: 25,
                    color: Colors.green,
                  ),
                  isFirst: true,
                  alignment: TimelineAlign.start,
                  endChild: Container(
                      height: 100,
                      width: 20,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '12:15 PM - 1:15 PM',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                ),
                TimelineTile(
                  indicatorStyle: IndicatorStyle(
                    height: 25,
                    width: 25,
                    color: Theme.of(context).errorColor,
                  ),
                  isFirst: false,
                  alignment: TimelineAlign.start,
                  endChild: Text(
                    '12:15 PM - 1:15 PM',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
