import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid_repository/covid_repository.dart';
import 'package:equatable/equatable.dart';

part 'covid_stats_event.dart';
part 'covid_stats_state.dart';

class CovidStatsBloc extends Bloc<CovidStatsEvent, CovidStatsState> {
  final CovidRepository _covidRepository;

  CovidStatsBloc({required CovidRepository covidRepository})
      : _covidRepository = covidRepository, super(const CovidStatsInitial()) {
    on<CovidStatsRequested>((event, emit) async {
      emit(CovidStatsUpdateInProgress(selectedCountry: event.selectedCountry));
      try{
        var newDailyCovidStats = await _covidRepository.fetchCovidStats(event.selectedCountry.slug);
        emit(
            CovidStatsUpdateSuccess(
              selectedCountry: event.selectedCountry,
              newDailyCovidStats: newDailyCovidStats,
            )
        );
      } catch(e) {
        emit(CovidStatsUpdateFailure(
            selectedCountry: event.selectedCountry,
            previousCovidStats: state.dailyCovidStats
        ));
      }
    });
    on<CovidStatsOrderSelected>((event, emit) {
      emit(
          CovidStatsUpdateSuccess(
              selectedCountry: event.selectedCountry,
              newDailyCovidStats: event.dailyCovidStats
          )
      );
    });
  }

  List<CovidStats> orderDailyCovidStats(String newOrder) {
    List<CovidStats> orderedDailyCovidStats = state.dailyCovidStats;
    switch(newOrder) {
      case 'Newest':
        orderedDailyCovidStats.sort((a,b) =>
            b.date.toLowerCase().compareTo(a.date.toLowerCase()));
        break;
      case 'Oldest':
        orderedDailyCovidStats.sort((a,b) =>
            a.date.toLowerCase().compareTo(b.date.toLowerCase()));
        break;
      case 'Highest':
      default:
      orderedDailyCovidStats.sort((a,b) =>
            b.confirmed.compareTo(a.confirmed));
    }
    return orderedDailyCovidStats;
  }
}
