part of 'covid_stats_bloc.dart';

abstract class CovidStatsEvent extends Equatable {
  const CovidStatsEvent();
}

class CovidStatsRequested extends CovidStatsEvent {
  final Country selectedCountry;

  const CovidStatsRequested({required this.selectedCountry});

  @override
  List<Object?> get props => [selectedCountry];

}

class CovidStatsOrderSelected extends CovidStatsEvent {
  final String order;
  final Country selectedCountry;
  final List<CovidStats> dailyCovidStats;

  const CovidStatsOrderSelected({
    required this.order,
    required this.selectedCountry,
    required this.dailyCovidStats
  });

  @override
  List<Object?> get props => [order, selectedCountry, dailyCovidStats];
}