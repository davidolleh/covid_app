import 'package:covid_app/blocs/country/country_cubit.dart';
import 'package:covid_app/routes/app_router.dart';
import 'package:covid_repository/covid_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CovidApp extends StatelessWidget {
  final CovidRepository _covidRepository;
  final AppRouter _router;

  const CovidApp({
    required CovidRepository covidRepository,
    required AppRouter router,
    Key? key})
      : _covidRepository = covidRepository,
        _router = router,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: _covidRepository,
        child: BlocProvider(
          create: (_) => CountryCubit(covidRepository: _covidRepository),
          child:
            MaterialApp.router(
              routeInformationParser: _router.defaultRouteParser(),
              routerDelegate: _router.delegate(),
              title: 'COVID',
              theme: ThemeData(
                primarySwatch: Colors.deepPurple
              ),
            )
        )
    );

  }
}