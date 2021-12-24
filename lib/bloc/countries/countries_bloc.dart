import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid_app/model/covid_model.dart';
import 'package:covid_app/model/entity/country.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:covid_app/model/repository/covid_repository.dart';

part 'countries_event.dart';
part 'countries_state.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  CovidRepository repository;

  CountriesBloc(this.repository) : super(CountriesInitial()) {
    on<CountriesFetch>((event, emit) async {
      emit(CountriesLoading());
      final countries = await repository.getCountry();
        emit(CountriesSuccess(countries: countries));
      // else {
      //   emit(CountriesError(message: 'Error'));
      // }
    });
  }
}


