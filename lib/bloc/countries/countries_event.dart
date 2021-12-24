part of 'countries_bloc.dart';

@immutable
abstract class CountriesEvent extends Equatable {}

class CountriesFetch extends CountriesEvent {
  @override
  List<Object> get props => [];
}
