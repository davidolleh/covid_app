part of 'country_cubit.dart';

abstract class CountryState extends Equatable {
  const CountryState();
}

class CountryInitial extends CountryState {
  @override
  List<Object> get props => [];
}

class CountryLoadInProgress extends CountryState {
  @override
  List<Object?> get props => [];

}

class CountryLoadSuccess extends CountryState {
  final List<Country> countries;

  const CountryLoadSuccess({required this.countries});

  @override
  List<Object?> get props => countries;

}

class CountryLoadFailure extends CountryState {
  @override
  List<Object?> get props => [];

}