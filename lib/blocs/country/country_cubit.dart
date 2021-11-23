import 'package:bloc/bloc.dart';
import 'package:covid_repository/covid_repository.dart';
import 'package:equatable/equatable.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  CountryCubit() : super(CountryInitial());

  Future<void> fetchCountries() async {
    emit(CountryLoadInProgress());
    try {
      CovidRepository().fetchCountries()
        ..then((newCountries) =>
            emit(CountryLoadSuccess(countries: newCountries)))
        ..onError((Exception error, stackTrace) {
            emit(CountryLoadFailure());
            return <Country>[];
          });
    } catch(e) {
      emit(CountryLoadFailure());
    }
  }
}
