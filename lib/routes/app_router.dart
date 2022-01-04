import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:covid_app/screen1/loading_screen_c/loading_page.dart';
import 'package:covid_app/screen1/main_page_c/main_page.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: LoadingPage, initial: true),
    AutoRoute(page: MainPage)
  ],
)
class AppRouter extends _$AppRouter {}