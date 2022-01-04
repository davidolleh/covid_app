import 'package:bloc/bloc.dart';
import 'package:covid_app/model/entity/country.dart';
import 'package:covid_app/model/repository/covid_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'countries_state.dart';

class CountriesCubit extends Cubit<CountriesState> {
  final CovidRepository _covidRepository;

  CountriesCubit({required CovidRepository covidRepository})
      : _covidRepository = covidRepository,
        super(CountriesInitial());

  Future<void> fetchCountries() async {
    emit(CountriesLoadInProgress());
    try {
      List<Country> countries = await _covidRepository.getCountry();
      emit(CountriesLoadSuccess(newCountries: countries));
    } catch (e) {
      emit(CountriesLoadFail());
    }
  }
}
