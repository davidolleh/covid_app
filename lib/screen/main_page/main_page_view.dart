import 'package:flutter/material.dart';

import 'package:covid_app/screen/sub_page/covid_data_page.dart';
import 'package:covid_app/screen/sub_page/my_painter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageView extends StatelessWidget {
  const MainPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('covid'),
      ),
      body: BlocBuilder<CovidStatsBloc, CovidStatsState>(
        builder: (context, state) {
          return Center(
            child: Column(
              children: [
                Container(
                  width: 250.0,
                  height: 50.0,
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 5.0),
                  ),
                  child: const Center(
                    child: Text(
                      'COVID STATISTICS',
                      style: TextStyle(
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
                  child: DropdownButton(
                      value: context.read<CovidStatsBloc>()
                          .state
                          .selectedCountry
                          .country,
                      isExpanded: true,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 20.0),
                      // onChanged: (String? newValue) {
                      //   context
                      //       .read<CovidStatsBloc>()
                      //       .add(SelectCountry(selectedCountry: newValue));
                      //   // widget.controller.onFecthCovidStats();
                      // },
                      onChanged: (String? newValue) {
                        context
                            .read<CovidStatsBloc>()
                            .add(SelectCountry(selectedCountry: newValue));
                      },                     
                      items: context.read<CountriesBloc>()
                          .state
                          .countries
                          .map((country) => DropdownMenuItem(
                              value: country.country,
                              child: Text(country.country)))
                          .toList()),
                ),
                Align(
                  // alignment: Alignment.centerRight,
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 100.0,
                    height: 30.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 5.0),
                    ),
                    child: DropdownButton(
                        value: context.read<CovidStatsBloc>().state.order,
                        isExpanded: true,
                        style: const TextStyle(
                            color: Colors.black, fontSize: 15.0),
                        onChanged: (String? newValue) {
                          context
                              .read<CovidStatsBloc>()
                              .add(SelectOrder(order: newValue!));
                        },
                        items: <String>['Oldest', 'Newest', 'Highest']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    shrinkWrap: true,
                    itemCount: BlocProvider.of<CovidStatsBloc>(context)
                        .state
                        .dailyCovidStats
                        .length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return DataPageDialog(
                                  date: context.read<CovidStatsBloc>()
                                      .state
                                      .dailyCovidStats[index]
                                      .date,
                                  deaths: context.read<CovidStatsBloc>()
                                      .state
                                      .dailyCovidStats[index]
                                      .deaths,
                                  confirmed:
                                      context.read<CovidStatsBloc>()
                                          .state
                                          .dailyCovidStats[index]
                                          .confirmed,
                                  recovered:
                                      context.read<CovidStatsBloc>()
                                          .state
                                          .dailyCovidStats[index]
                                          .recovered);
                          }));
                        },
                        child: Container(
                          height: 30,
                          color: Colors.purple,
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 8),
                                width: 100,
                                height: 20,
                                color: Colors.blueGrey,
                                child: Center(
                                  child: Text(
                                    BlocProvider.of<CovidStatsBloc>(context)
                                        .state
                                        .dailyCovidStats[index]
                                        .date,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: CustomPaint(
                                  // size: Size(confirmed[index].toDouble() / minConfirmed + 20, 0),
                                  size: Size(
                                      250 *
                                          BlocProvider.of<CovidStatsBloc>(
                                                  context)
                                              .state
                                              .dailyCovidStats[index]
                                              .confirmed /
                                          BlocProvider.of<CovidStatsBloc>(
                                                  context)
                                              .state
                                              .maxConfirmed
                                              .toDouble(),
                                      0),
                                  // size: Size(50, 0),
                                  painter: MyPainter(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      height: 8,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
