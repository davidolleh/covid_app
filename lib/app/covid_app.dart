import 'package:covid_app/blocs/country/country_cubit.dart';
import 'package:covid_app/screens/loading/loading_page.dart';
import 'package:covid_repository/covid_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CovidApp extends StatelessWidget {
  final CovidRepository _covidRepository;

  const CovidApp({required CovidRepository covidRepository, Key? key})
      : _covidRepository = covidRepository, super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: _covidRepository,
        child: BlocProvider(
          create: (_) => CountryCubit(covidRepository: _covidRepository),
          child: MaterialApp(
            title: 'Covid',
            theme: ThemeData(
              primarySwatch: Colors.deepPurple,
            ),
            home: const LoadingPage(),
          ),
        )
    );

  }
}