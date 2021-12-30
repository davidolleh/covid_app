import 'package:covid_app/blocs/country/country_cubit.dart';
import 'package:covid_app/blocs/covid_stats/covid_stats_bloc.dart';
import 'package:covid_app/screens/main/main_view.dart';
import 'package:covid_repository/covid_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CovidStatsBloc>(
        create: (context) {
          return CovidStatsBloc(
              covidRepository: context.read<CovidRepository>()
          )
          ..add(
              CovidStatsRequested(
                selectedCountry: context.read<CountryCubit>().state.countries[0],
              )
          );
        },
        child: const MainView());
  }

}