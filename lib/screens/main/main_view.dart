import 'dart:math';

import 'package:covid_app/blocs/country/country_cubit.dart';
import 'package:covid_app/blocs/covid_stats/covid_stats_bloc.dart';
import 'package:covid_app/screens/main/widgets/widgets.dart';
import 'package:covid_repository/covid_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GreyContainer extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  const GreyContainer({
    this.width = 250.0,
    this.height = 50.0,
    required this.child,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 5.0),
      ),
      child: Center(
        child: child,
      ),
    );
  }
}


class MainView extends StatelessWidget{
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
              title: const Text('COVID'),
            ),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: GreyContainer(
                      child: Center(
                        child:  Text(
                          'COVID STATISTICS',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                    ),
                  ),
                  GreyContainer(
                    child: Center(
                      child: CountryDropdownButton(
                        countries: countries,
                      ),
                    ),
                  ),
                  const Align(
                    // alignment: Alignment.centerRight,
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 20.0
                      ),
                      child: GreyContainer(
                        width: 100.0,
                        height: 30.0,
                        child: OrderDropdownButton(),
                      ),
                    ),
                  ),
                  BlocBuilder<CovidStatsBloc, CovidStatsState>(
                      builder: (context, state) {
                        if(state is CovidStatsUpdateSuccess){
                          return Expanded(
                            child: state.dailyCovidStats == null ||
                                state.dailyCovidStats.isEmpty ?
                                  Text(
                                  'No Data Found',
                                  style: Theme.of(context).textTheme.headline1,
                                ) :
                                ListView.separated(
                                  padding: const EdgeInsets.all(8),
                                  shrinkWrap: true,
                                  itemCount: state.dailyCovidStats.length,
                                  itemBuilder: (context, index) {
                                    return buildDailyStatsItems(
                                        context,
                                        index,
                                        state.dailyCovidStats
                                    );
                                  },
                                  separatorBuilder: (_,__) =>
                                      const Divider(height: 8,),
                                ),
                          );
                        } else {
                          return const Expanded(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      }
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'Loading Failed, click the button below to reload',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                IconButton(
                    // TODO:: set state maybe?
                    onPressed: () => context.read<CountryCubit>().fetchCountries(),
                    icon: const Icon(Icons.restart_alt)
                )
              ],
            )
          );
        }
      }
    );
  }

  Widget buildDailyStatsItems(BuildContext context, int index, List<CovidStats> dailyCovidStats) {
    int maxConfirmed = dailyCovidStats.map((e) => e.confirmed).reduce(max);
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return DataPageDialog(
                covidStat: dailyCovidStats[index],
              );
            }
        );
      },
      child: DailyCovidStatsItem(
        date: dailyCovidStats[index].date,
        ratioToMax: dailyCovidStats[index].confirmed
            / maxConfirmed.toDouble(),
      )
    );

  }
}