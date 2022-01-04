
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:covid_app/model/entity/country.dart';
import 'package:covid_app/model/repository/covid_repository.dart';
import 'package:covid_app/screen/loading_screen/loading.dart';
import 'package:covid_app/screen/main_page/main_page.dart';
import 'package:flutter/cupertino.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: LoadingPage, initial: true),
    AutoRoute(page: MainPage,)
  ],
)
class AppRouter extends _$AppRouter {}