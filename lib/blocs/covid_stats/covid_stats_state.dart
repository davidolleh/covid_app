part of 'covid_stats_bloc.dart';

abstract class CovidStatsState extends Equatable {
  abstract final Country? selectedCountry;
  abstract final List<CovidStats>? dailyCovidStats;

  const CovidStatsState();
}

class CovidStatsInitial extends CovidStatsState {
  @override
  List<Object> get props => [];
  @override
  Country? get selectedCountry => null;
  @override
  List<CovidStats>? get dailyCovidStats => null;
}

/// When fetch request is made, there exists a non-null [selectedCountry]
/// with which fetch request is sent.
class CovidStatsLoadInProgress extends CovidStatsState {
  final Country _selectedCountry;

  const CovidStatsLoadInProgress({
    required Country selectedCountry})
      : _selectedCountry = selectedCountry;

  @override
  Country? get selectedCountry => _selectedCountry;

  @override
  List<CovidStats>? get dailyCovidStats => null;

  @override
  List<Object?> get props => [_selectedCountry];

}

/// On successful response from fetch request, there exists both non-null
/// [selectedCountry] and [dailyCovidStats] from the response.
class CovidStatsLoadSuccess extends CovidStatsState {
  final Country _selectedCountry;
  final List<CovidStats> _dailyCovidStats;

  const CovidStatsLoadSuccess({
    required Country newCountry,
    required List<CovidStats> newDailyCovidStats})
      : _selectedCountry = newCountry,
        _dailyCovidStats = newDailyCovidStats;


  @override
  List<Object?> get props => [_selectedCountry, _dailyCovidStats];

  @override
  Country? get selectedCountry => _selectedCountry;

  @override
  List<CovidStats>? get dailyCovidStats => _dailyCovidStats;

}

/// On failed reseponse from fetch request, there exists a non-null
/// [selectedCountry] but not [dailyCovidStats]
class CovidStatsLoadFailure extends CovidStatsState {

  final Country _attemptedCountry;

  CovidStatsLoadFailure({required Country attemptedCountry})
      : _attemptedCountry = attemptedCountry;

  @override
  List<Object?> get props => [];

  @override
  List<CovidStats>? get dailyCovidStats => null;

  @override
  Country? get selectedCountry => _attemptedCountry;

}

class CovidStatsOrderSuccess extends CovidStatsState {
  final String _order;
  final Country _selectedCountry;
  final List<CovidStats> _dailyCovidStats;

  CovidStatsOrderSuccess({
    required String order,
    required Country selectedCountry,
    required List<CovidStats> dailyCovidStats})
      : _order = order,
        _selectedCountry = selectedCountry,
        _dailyCovidStats = dailyCovidStats {
    orderDailyCovidStats(order);
  }

  void orderDailyCovidStats(String newOrder) {
    switch(newOrder) {
      case 'Newest':
        _dailyCovidStats.sort((a,b) =>
            b.date.toLowerCase().compareTo(a.date.toLowerCase()));
        break;
      case 'Oldest':
        _dailyCovidStats.sort((a,b) =>
            a.date.toLowerCase().compareTo(b.date.toLowerCase()));
        break;
      case 'Highest':
      default:
        _dailyCovidStats.sort((a,b) =>
            b.confirmed.compareTo(a.confirmed));
    }
  }

  String get order => _order;

  @override
  List<Object?> get props => [_order, _selectedCountry, _dailyCovidStats];

  @override
  List<CovidStats>? get dailyCovidStats => _dailyCovidStats;

  @override
  Country? get selectedCountry => _selectedCountry;

}