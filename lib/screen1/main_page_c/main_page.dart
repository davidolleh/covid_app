import 'package:covid_app/bloc/countries_c/countries_cubit.dart';
import 'package:covid_app/bloc/covid_stats_c/covid_stats_bloc.dart';
import 'package:covid_app/model/repository/covid_repository.dart';
import 'package:covid_app/screen1/main_page_c/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CovidStatsBloc(context.read<CovidRepository>())
        ..add(CovidStatsRequest(
          selectedCountry: context.read<CountriesCubit>().state.countries[0],
        )),
    child: const MainView(),
    );
  }
}
