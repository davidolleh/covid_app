import 'package:covid_app/bloc/countries/countries_bloc.dart';
import 'package:covid_app/bloc/covid_stats/covid_stats_bloc.dart';
import 'package:covid_app/model/repository/covid_repository.dart';
import 'package:flutter/material.dart';
import 'package:covid_app/screen/loading_screen/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CovidRepository repository = CovidRepository();
    return BlocProvider(
      create: (_) => CountriesBloc(repository),
      child: MaterialApp(
        title: 'Covid',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: Loading(repository: repository),
      ),
    );
  }
}