import 'package:covid_app/routes/app_router.dart';
import 'package:covid_repository/covid_repository.dart';
import 'package:flutter/material.dart';

import 'app/covid_app.dart';


void main() => runApp(
    CovidApp(
      covidRepository: CovidRepository(),
      router: AppRouter(),
    )
);