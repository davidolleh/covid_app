import 'package:covid_app/model/repository/covid_repository.dart';
import 'package:covid_app/screen/sub_page/error_page.dart';
import 'package:covid_app/screen/loading_screen/loading_view.dart';
import 'package:flutter/material.dart';

import 'package:covid_app/screen/main_page/main_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingPage extends StatelessWidget {
  final CovidRepository repository;

  const LoadingPage({required this.repository, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<CountriesBloc>().add(CountriesFetch());
    return BlocListener<CountriesBloc, CountriesState>(
        listener: (context, state) {
          if (state is CountriesSuccess) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MainPage(
                countries: state.countries,
                repository: repository,
                order: "Newest",
              );
            }));
          }
          else if (state is CountriesError) {
            const ErrorView(message: "Error");
          }
        },
        child: LoadingView());
  }
}
