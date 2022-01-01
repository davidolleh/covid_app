import 'package:covid_repository/covid_repository.dart';
import 'package:flutter/material.dart';

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget> [
          const SizedBox(
            height: 15.0,
          ),
          Text(
            covidStat.date,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [//logic 속에서 값을 controller 로 들어가는 것이다.
              const Text(
                '감염자',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              Text(
                covidStat.confirmed.toString() + '명',
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                '완치',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              Text(
                covidStat.recovered.toString() + '명',
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                '사망',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              Text(
                covidStat.deaths.toString() + '명',
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
            ],
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
