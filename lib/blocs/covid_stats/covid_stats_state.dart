part of 'covid_stats_bloc.dart';

abstract class CovidStatsState extends Equatable {
  final Country? selectedCountry;
  final List<CovidStats> dailyCovidStats;

  const CovidStatsState({
    required this.selectedCountry,
    this.dailyCovidStats = const [],
  });

  @override
  List<Object?> get props => [selectedCountry, dailyCovidStats];
}

class CovidStatsInitial extends CovidStatsState {
  const CovidStatsInitial()
      : super(selectedCountry: null);

  @override
  List<Object> get props => [];
}

/// When fetch request is made, there exists a non-null [selectedCountry]
/// with which fetch request is sent.
class CovidStatsUpdateInProgress extends CovidStatsState {

  const CovidStatsUpdateInProgress({
    required Country selectedCountry})
      : super(selectedCountry: selectedCountry);
}

/// On successful response from fetch request, there exists both non-null
/// [selectedCountry] and [dailyCovidStats] from the response.
class CovidStatsUpdateSuccess extends CovidStatsState {
  const CovidStatsUpdateSuccess({
    required Country selectedCountry,
    required List<CovidStats> newDailyCovidStats})
      : super(
          selectedCountry: selectedCountry,
          dailyCovidStats: newDailyCovidStats
      );
}

/// On failed reseponse from fetch request, there exists a non-null
/// [selectedCountry] but not [dailyCovidStats]
class CovidStatsUpdateFailure extends CovidStatsState {

  const CovidStatsUpdateFailure({
    required Country selectedCountry,
    required List<CovidStats> previousCovidStats
  })
      : super(
          selectedCountry: selectedCountry,
          dailyCovidStats: previousCovidStats
      );
}