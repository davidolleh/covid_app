import 'package:covid_app/bloc/countries/countries_bloc.dart';
import 'package:covid_app/bloc/covid_stats/covid_stats_bloc.dart';

import 'package:covid_app/model/repository/covid_repository.dart';
import 'package:covid_app/screen/sub_page/error_page.dart';
import 'package:covid_app/screen/loading_screen/loading_view.dart';
import 'package:flutter/material.dart';

import 'package:covid_app/screen/main_page/main_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Loading extends StatelessWidget {
  final CovidRepository repository;

  const Loading({required this.repository, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CountriesBloc, CountriesState>(
        listener: (context, state) {
          if (state is CountriesInitial) {
            print('hi1');
            context.read<CountriesBloc>().add(CountriesFetch());
            // BlocProvider.of<CountriesBloc>(context).add(CountriesFetch());
          }
          else if (state is CountriesSuccess) {
            print("hi2");
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              // return BlocProvider(
              //   create: (context) => CovidStatsBloc(state.countries, repository, "Newest"),
              //   child: MainPage(
              //       repository: repository,
              //   ),
              // );
              return MainPage(countries: state.countries,
                repository: repository,
                order: "Newest",
              );
            }));
          }
        },
        child: LoadingView()
    );
    return BlocBuilder<CountriesBloc, CountriesState>(
        builder: (context, state) {
          if (state is CountriesInitial) {
            context.read<CountriesBloc>().add(CountriesFetch());
            // BlocProvider.of<CountriesBloc>(context).add(CountriesFetch());
          }
          else if (state is CountriesLoading) {
            print("hi1");
            return LoadingView();
          }
          else if (state is CountriesSuccess) {
            print("hi2");
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              // return BlocProvider(
              //   create: (context) => CovidStatsBloc(state.countries, repository, "Newest"),
              //   child: MainPage(
              //       repository: repository,
              //   ),
              // );
              return MainPage(countries: state.countries,
                    repository: repository,
                  order: "Newest",
                );
            }));
          }
          else if (state is CountriesError) {
            print("hi3");
            return ErrorView(message: state.message);
          }
          return Container();
        });
  }
}