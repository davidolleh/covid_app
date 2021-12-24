import 'package:covid_app/bloc/countries/countries_bloc.dart';
import 'package:covid_app/bloc/covid_stats/covid_stats_bloc.dart';
import 'package:covid_app/model/entity/country.dart';
import 'package:covid_app/model/entity/covid_stats.dart';
import 'package:covid_app/model/repository/covid_repository.dart';
import 'package:covid_app/screen/sub_page/error_page.dart';
import 'package:covid_app/screen/loading_screen/loading_view.dart';
import 'package:covid_app/screen/main_page/main_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  final CovidRepository repository;
  final List<Country> countries;
  final String order;

  const MainPage({required this.countries ,required this.repository, required this.order, Key? key}) : super(key: key);

  // CovidStatsBloc covidStatsBloc = CovidStatsBloc(country, repository, order)

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CovidStatsBloc(countries, repository, "Newest"),
      child: BlocBuilder<CovidStatsBloc, CovidStatsState>(
          builder: (context, state) {
            if (state is CovidStatsInitial) {
              context.read<CovidStatsBloc>().add(FetchCovidStats());
            }
            else if (state is CovidStatsLoading) {
              return LoadingView();
            }
            else if (state is CovidStatsSuccess) {
              return const MainPageView();
            }
            else if (state is CovidStatsError) {
              return ErrorView(message: state.message);
            }
            return Container();
          }
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return BlocProvider.value(
  //     value: context.read<CountxriesBloc>(),
  //     //countriesBloc 하고 나서 provider를 통해서 제공해주고 거기서 사용한다면?
  //     child: BlocProvider(
  //       create: (_) => CovidStatsBloc(countries, repository, order),
  //       child: BlocBuilder<CovidStatsBloc, CovidStatsState>(
  //           builder: (context, state) {
  //             if (state is CovidStatsInitial) {
  //               BlocProvider.of<CovidStatsBloc>(context).add(FetchCovidStats());
  //             }
  //             else if (state is CovidStatsLoading) {
  //               print("hi6");
  //               return LoadingView();
  //             } else if (state is CovidStatsSuccess) {
  //               print("hi7");
  //               return const MainPageView();
  //             } else if (state is CovidStatsError) {
  //               print("hi8");
  //               return ErrorView(message: state.message);
  //             }
  //             print("hi9");
  //             return Container();
  //           }
  //       ),
  //     ),
  //   );
  // }
}
