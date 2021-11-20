import 'dart:math';

import 'package:covid_app/controller/main_page.dart';
import 'package:covid_app/model/entity/country.dart';
import 'package:covid_app/model/entity/covid_stats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data_page_dialog.dart';
import 'my_painter.dart';

class MainView extends StatelessWidget {
  const MainView({
    required this.selectedCountry,
    required this.countries,
    required this.dailyCovidStats,
    required this.order,
    required this.controller,
    Key? key
  }) : super(key: key);

  final Country selectedCountry;
  final List<Country> countries;
  final List<CovidStats> dailyCovidStats;
  final String order;
  final MainPageController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('covid'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 250.0,
              height: 50.0,
              margin: EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 5.0),
              ),
              child: const Center(
                child:  Text(
                  'COVID STATISTICS',
                  style:  TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Container(
              width: 250.0,
              height: 100.0,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 5.0),
              ),
              child: DropdownButton<Country>(
                  value: selectedCountry,
                  isExpanded: true,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20.0
                  ),
                  onChanged: (Country? newCountry) {
                    controller.changeCountry(newCountry!, order);
                  },
                  items: countries.map(
                          (Country c) =>
                              DropdownMenuItem(
                                value: c,
                                child: Text(c.country),
                              )
                  ).toList(),
              ),
            ),
            Align(
              // alignment: Alignment.centerRight,
              alignment: Alignment.centerRight,
              child: Container(
                width: 100.0,
                height: 30.0,
                margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 5.0),
                ),
                child: DropdownButton(
                    value: order,
                    isExpanded: true,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15.0
                    ),
                    onChanged: (String? newOrder) {
                      controller.changeOrder(newOrder!);
                    },
                    items: ['Oldest', 'Newest', 'Highest'].map((String orderType) {
                      return DropdownMenuItem(
                        value: orderType,
                        child: Text(orderType),
                      );
                    }).toList()
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                shrinkWrap: true,
                itemCount: dailyCovidStats.length,
                itemBuilder: (BuildContext context, int index) {
                  int maxConfirmed = dailyCovidStats.map((e) => e.confirmed).reduce(max);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return DataPageDialog(
                            date: dailyCovidStats[index].date, 
                            deaths: dailyCovidStats[index].deaths, 
                            confirmed: dailyCovidStats[index].confirmed, 
                            recovered: dailyCovidStats[index].recovered);
                      }));
                    },
                    child: Container(
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
                              child: Text(dailyCovidStats[index].date,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Row(
                              children: [
                                CustomPaint(
                                  size: Size(250 * dailyCovidStats[index].confirmed / maxConfirmed.toDouble(), 0),
                                  painter: MyPainter(),
                                ),
                              ]
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(
                  height: 8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}