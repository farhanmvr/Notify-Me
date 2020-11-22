import 'package:flutter/material.dart';

import '../../models/day_subject.dart';
import './sub_tile.dart';

class DayBody extends StatelessWidget {
  final List<DaySubject> subList;
  const DayBody({Key key, this.subList}) : super(key: key);

  Widget getWidget(BuildContext context) {
    if (subList.length == 0) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'It seems you haven\'t added any subjects yet',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: subList.length,
      itemBuilder: (context, index) => Column(
        children: [
          SubTile(subject: subList[index]),
          if (index != subList.length - 1) Divider(),
          if (index == subList.length - 1)
            SizedBox(height: MediaQuery.of(context).size.height * .15),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getWidget(context);
  }
}
