part of 'covid_stats_bloc.dart';

@immutable
abstract class CovidStatsEvent extends Equatable {}

class CovidStatsRequest extends CovidStatsEvent {
  final Country newSelectedCountry;

  CovidStatsRequest({required Country selectedCountry}) :
        newSelectedCountry = selectedCountry;

  @override
  List<Object?> get props => [newSelectedCountry];
}

// class CovidStatsSelectCountry extends CovidStatsEvent {
//   final Country _newSelectCountry;
//
//   CovidStatsSelectCountry({required Country newSelectCountry})
//       : _newSelectCountry = newSelectCountry;
//
//   Country get newSelectCountry => _newSelectCountry;
//
//   @override
//   List<Object?> get props => [_newSelectCountry];
// }

class CovidStatsSelectOrder extends CovidStatsEvent {
  final String _newOrder;

  CovidStatsSelectOrder({required String newOrder}) : _newOrder = newOrder;

  String get newOrder => _newOrder;

  @override
  List<Object?> get props => [_newOrder];
}
