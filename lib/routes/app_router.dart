import 'package:auto_route/auto_route.dart';
import 'package:covid_app/screens/screens.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(initial: true, page: LoadingPage),
    AutoRoute(page: MainPage)
  ]
)
class AppRouter extends _$AppRouter{}