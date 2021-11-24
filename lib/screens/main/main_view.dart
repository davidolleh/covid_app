import 'dart:math';

import 'package:covid_app/blocs/country/country_cubit.dart';
import 'package:covid_app/blocs/covid_stats/covid_stats_bloc.dart';
import 'package:covid_app/screens/data_page_dialog/data_page_dialog.dart';
import 'package:covid_app/screens/data_page_dialog/my_painter.dart';
import 'package:covid_repository/covid_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainView extends StatelessWidget {
  const MainView({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CountryCubit, CountryState>(
      builder: (context, state) {
        if(state is CountryLoadSuccess) {
          // CountryCubit state must be LoadSuccess by the time we get to Main Page
          List<Country> countries = state.countries;

          return Scaffold(
            resizeToAvoidBottomInset : false,
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: const Text('covid'),
            ),
            body: Center(
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
                      hint: const Text('choose a country'),
                      isExpanded: true,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20.0
                      ),
                      onChanged: (Country? newCountry) {
                        context.read<CovidStatsBloc>().add(
                            CovidStatsRequested(
                                selectedCountry: newCountry!
                            )
                        );
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
                          value: 'Newest',
                          isExpanded: true,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15.0
                          ),
                          onChanged: (String? newOrder) {
                            var covidStatsBloc = context.read<CovidStatsBloc>();
                            if(covidStatsBloc.state is CovidStatsLoadSuccess){
                              covidStatsBloc.add(
                                  CovidStatsOrderSelected(
                                      order: newOrder!,
                                      selectedCountry: covidStatsBloc.state.selectedCountry!,
                                      dailyCovidStats: covidStatsBloc.state.dailyCovidStats!
                                  )
                              );
                            }
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
                  BlocBuilder<CovidStatsBloc, CovidStatsState>(
                      builder: (context, state) {
                        if(state is CovidStatsLoadSuccess || state is CovidStatsOrderSuccess){
                          return Expanded(
                            child: ListView.separated(
                              padding: const EdgeInsets.all(8),
                              shrinkWrap: true,
                              itemCount: state.dailyCovidStats?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                int maxConfirmed = state.dailyCovidStats!.map((e) => e.confirmed).reduce(max);
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      List<CovidStats> dailyCovidStats = state.dailyCovidStats!;
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
                                            child: Text(state.dailyCovidStats![index].date,
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
                                                size: Size(250 * state.dailyCovidStats![index].confirmed / maxConfirmed.toDouble(), 0),
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
                          );
                        } else {
                          return const Expanded(
                            child: Text('loading'),
                          );
                        }
                      }
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Expanded(
            child: Text('Loading',
              style: TextStyle(
                color: Colors.white
              ),
            ),
          );
        }
      }
    );

  }
}