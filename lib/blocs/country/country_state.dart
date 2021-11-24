part of 'country_cubit.dart';

abstract class CountryState extends Equatable {
  abstract final List<Country> countries;

  const CountryState();
}

class CountryInitial extends CountryState {
  @override
  List<Country> get countries => [];

  @override
  List<Object> get props => [];
}

class CountryLoadInProgress extends CountryState {

  @override
  List<Country> get countries => [];

  @override
  List<Object?> get props => [];

}

class CountryLoadSuccess extends CountryState {
  @override
  List<Country> get countries => _newCountries;

  final List<Country> _newCountries;

  const CountryLoadSuccess({required List<Country> newCountries})
      : _newCountries = newCountries;

  @override
  List<Object?> get props => countries;

}

class CountryLoadFailure extends CountryState {
  @override
  List<Country> get countries => [];

  @override
  List<Object?> get props => [];

}