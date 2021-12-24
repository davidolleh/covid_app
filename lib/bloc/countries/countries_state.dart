part of 'countries_bloc.dart';

@immutable
abstract class CountriesState extends Equatable {
  final List<Country> _countries;

  const CountriesState({
    required List<Country> countries
  }) : _countries = countries;

  List<Country> get countries => _countries; //외부에서 그냥 countries를 사용하기 위해서 countries를 사용하면 _countries값을 불러온다
}

class CountriesInitial extends CountriesState {
  CountriesInitial() : super(countries: []);

  @override
  List<Object> get props => [];
}

class CountriesLoading extends CountriesState {
  CountriesLoading() : super(countries: []);

  @override
  List<Object> get props => [];
}

class CountriesSuccess extends CountriesState {

  const CountriesSuccess({
    required List<Country> countries
  }) : super(countries: countries);
  @override
  List<Object> get props => [countries];
}

class CountriesError extends CountriesState {
  final String message;

  CountriesError({
    required this.message
  }) : super(countries: []);

  @override
  List<Object> get props => [message];
}

