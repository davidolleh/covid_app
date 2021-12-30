import 'package:covid_app/blocs/country/country_cubit.dart';
import 'package:covid_app/routes/app_router.dart';
import 'package:covid_app/screens/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';

import 'loading_view.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<CountryCubit>().fetchCountries();
    return BlocListener<CountryCubit, CountryState>(
      listener: (BuildContext context, state) {
        if(state is CountryLoadSuccess){
          context.replaceRoute(MainRoute());
        }
      },
      child: const LoadingView(),
    );
  }

}