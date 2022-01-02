import 'package:covid_repository/covid_repository.dart';
import 'package:flutter/material.dart';

class DataRow extends StatelessWidget {
  final String type;
  final int number;
  const DataRow({
    required this.type,
    required this.number,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          type,
          style: Theme.of(context).textTheme.headline1,
        ),
        Text(
          '$number 명',
          style: Theme.of(context).textTheme.headline1,
        ),
      ],
    );
  }
}


class DataPageDialog extends StatelessWidget {
  final CovidStats covidStat;

  const DataPageDialog({
    required this.covidStat,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: buildDataBox(context),
    );
  }

  Widget buildDataBox(context) {
    return Container(
      width: 300.0,
      height: 400.0,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget> [
          const SizedBox(
            height: 15.0,
          ),
          Text(
            covidStat.date,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(
            height: 30,
          ),
          DataRow(
              type: '감염자',
              number: covidStat.confirmed
          ),
          const Spacer(),
          DataRow(
              type: '완치',
              number: covidStat.recovered
          ),
          const Spacer(),
          DataRow(
              type: '사망',
              number: covidStat.deaths
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 30.0),
              alignment: Alignment.bottomCenter,
              height: 50.0,
              width: 100.0,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(color: Colors.black,offset: Offset(0,10),
                        blurRadius: 10
                    ),
                  ]
              ),
              // color: Colors.black,
              child: const Text(
                '확인',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
