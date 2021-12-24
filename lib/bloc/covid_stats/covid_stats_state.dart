part of 'covid_stats_bloc.dart';

@immutable
abstract class CovidStatsState extends Equatable{
  final List<CovidStats> _dailyCovidStats;
  final String _order;
  final Country _selectedCountry;
  final int _maxConfirmed;

  const CovidStatsState({
    required List<CovidStats> dailyCovidStats,
    required String order,
    required Country selectedCountry,
    required int maxConfirmed
}) : _dailyCovidStats = dailyCovidStats, _order = order, _selectedCountry = selectedCountry, _maxConfirmed = maxConfirmed;

  List<CovidStats> get dailyCovidStats => _dailyCovidStats;
  String get order => _order;
  Country get selectedCountry => _selectedCountry;
  int get maxConfirmed => _maxConfirmed;

  // set dailyCovidStats(List<CovidStats> value) => (_dailyCovidStats = value);
  // set order(String order) => (_order = order);
  // set selectCountry(Country selectCountry) => (_selectedCountry = selectCountry);
  // set maxConfirmed(int maxConfirmed) => (_maxConfirmed = maxConfirmed);
}

class CovidStatsInitial extends CovidStatsState {
  final Country firstCountry;

  CovidStatsInitial({
    required this.firstCountry,
  }) : super(dailyCovidStats: [],
      order: 'Newest',
      selectedCountry: firstCountry,
      maxConfirmed: 0
  );

  @override
  List<Object> get props => [];
}

class CovidStatsLoading extends CovidStatsState {
  final Country firstCountry;

  CovidStatsLoading({
    required this.firstCountry
    }) : super(dailyCovidStats: [],
      order: 'Newest',
      selectedCountry: firstCountry,
      maxConfirmed: 0
  );
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CovidStatsSuccess extends CovidStatsState {
  const CovidStatsSuccess({
    required List<CovidStats> dailyCovidStats,
    required Country selectedCountry,
    required String order,
    required int maxConfirmed,
  }) : super(dailyCovidStats: dailyCovidStats,
      order: order,
      selectedCountry: selectedCountry,
      maxConfirmed: maxConfirmed
  );

  @override
  // TODO: implement props
  List<Object?> get props => [dailyCovidStats];
}

class CovidStatsError extends CovidStatsState {
  final String message;
  final Country firstCountry;

  CovidStatsError({
    required this.message,
    required this.firstCountry
  }): super(
      dailyCovidStats: [],
      order: 'Newest',
      selectedCountry: firstCountry,
      maxConfirmed: 0
  );

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class CovidStatsOrderUpdate extends CovidStatsState {
  const CovidStatsOrderUpdate ({
    required List<CovidStats> dailyCovidStats,
    required Country selectedCountry,
    required String order,
    required int maxConfirmed,
  }): super(
      dailyCovidStats: dailyCovidStats,
      order: order,
      selectedCountry: selectedCountry,
      maxConfirmed: maxConfirmed
  );
  @override
  // TODO: implement props
  List<Object?> get props => [order, selectedCountry, maxConfirmed];
}

class CovidStatsCountryUpdate extends CovidStatsState {

  CovidStatsCountryUpdate({
    required Country selectedCountry,
    required String order,
  }) : super(
      dailyCovidStats: [],
      order: order,
      selectedCountry: selectedCountry,
      maxConfirmed: 0
  );

  @override
  // TODO: implement props
  List<Object?> get props => [order, selectedCountry, maxConfirmed];
}
