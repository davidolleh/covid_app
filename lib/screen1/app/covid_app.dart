import 'package:covid_app/bloc/countries_c/countries_cubit.dart';
import 'package:covid_app/model/repository/covid_repository.dart';
import 'package:covid_app/routes/app_router.dart';
import 'package:covid_app/screen1/app/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CovidApp extends StatelessWidget {
  final CovidRepository _covidRepository;
  final AppRouter _appRouter;

  const CovidApp(
      {required CovidRepository covidRepository,
      required AppRouter appRouter,
      Key? key})
      : _covidRepository = covidRepository,
        _appRouter = appRouter,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _covidRepository,
      child: BlocProvider(
        create: (_) => CountriesCubit(covidRepository: _covidRepository),
        child: MaterialApp.router(
          routeInformationParser: _appRouter.defaultRouteParser(),
          routerDelegate: _appRouter.delegate(),
          title: 'COVID',
          theme: appTheme,
        ),
      ),
    );
  }
}
