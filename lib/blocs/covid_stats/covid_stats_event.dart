part of 'covid_stats_bloc.dart';

abstract class CovidStatsEvent extends Equatable {
  final Country selectedCountry;

  const CovidStatsEvent({required this.selectedCountry});
}

class CovidStatsRequested extends CovidStatsEvent {
  const CovidStatsRequested({required Country selectedCountry}) :
      super(selectedCountry: selectedCountry);

  @override
  List<Object?> get props => [selectedCountry];

}

class CovidStatsOrderSelected extends CovidStatsEvent {
  final String order;
  final List<CovidStats> dailyCovidStats;

  const CovidStatsOrderSelected({
    required this.order,
    required Country selectedCountry,
    required this.dailyCovidStats
  }) : super(selectedCountry: selectedCountry);

  @override
  List<Object?> get props => [order, selectedCountry, dailyCovidStats];
}