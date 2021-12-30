import 'package:covid_app/blocs/country/country_cubit.dart';
import 'package:covid_app/blocs/covid_stats/covid_stats_bloc.dart';
import 'package:covid_app/screens/main/main_page.dart';
import 'package:covid_repository/covid_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'loading_view.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<CountryCubit>().fetchCountries();
    return BlocListener<CountryCubit, CountryState>(
      listener: (BuildContext context, state) {
        if(state is CountryLoadSuccess){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => MainPage())
          );
        }
      },
      child: const LoadingView(),
    );
  }

}