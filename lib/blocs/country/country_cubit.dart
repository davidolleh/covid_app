import 'package:bloc/bloc.dart';
import 'package:covid_repository/covid_repository.dart';
import 'package:equatable/equatable.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  final CovidRepository _covidRepository;

  CountryCubit({required CovidRepository covidRepository})
      : _covidRepository = covidRepository, super(CountryInitial());

  Future<void> fetchCountries() async {
    emit(CountryLoadInProgress());
    var newCountries = await _covidRepository.fetchCountries();
    try {
      emit(CountryLoadSuccess(newCountries: newCountries));
    } catch(e) {
      emit(CountryLoadFailure());
    }
  }
}
