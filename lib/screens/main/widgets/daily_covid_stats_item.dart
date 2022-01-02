import 'package:flutter/material.dart';

import 'my_painter.dart';

class DailyCovidStatsItem extends StatelessWidget {
  final String date;
  final double ratioToMax;

  const DailyCovidStatsItem({
    required this.date,
    required this.ratioToMax,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      color: Colors.purple,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 8, right: 8),
            width: 100,
            height: 20,
            color: Colors.blueGrey,
            child: Center(
              child: Text(
                date,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ),
          CustomPaint(
            size: Size(250 * ratioToMax, 0),
            painter: MyPainter(),
          ),
        ],
      ),
    );
  }
}
