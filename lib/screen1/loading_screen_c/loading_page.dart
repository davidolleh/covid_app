import 'package:covid_app/bloc/countries_c/countries_cubit.dart';
import 'package:covid_app/routes/app_router.dart';
import 'package:covid_app/screen1/loading_screen_c/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<CountriesCubit>().fetchCountries();
    return BlocListener(
        listener: (context, state) {
          if (state is CountriesLoadSuccess) {
            context.replaceRoute(const MainRoute());
          }
          // else if (state is CountriesLoadFail) {
          //   return
          // }
        },
      child: const LoadingView(),
    );
  }
}
