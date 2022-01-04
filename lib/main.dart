import 'package:covid_app/model/repository/covid_repository.dart';
import 'package:covid_app/routes/app_router.dart';
import 'package:covid_app/screen1/app/covid_app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CovidApp(covidRepository: CovidRepository(), appRouter: AppRouter()));
}

