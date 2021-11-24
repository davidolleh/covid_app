import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid_repository/covid_repository.dart';
import 'package:equatable/equatable.dart';

part 'covid_stats_event.dart';
part 'covid_stats_state.dart';

class CovidStatsBloc extends Bloc<CovidStatsEvent, CovidStatsState> {
  final CovidRepository _covidRepository;

  CovidStatsBloc({required CovidRepository covidRepository})
      : _covidRepository = covidRepository, super(CovidStatsInitial()) {
    on<CovidStatsRequested>((event, emit) async {
      emit(CovidStatsLoadInProgress(selectedCountry: event.selectedCountry));
      try{
        var newDailyCovidStats = await _covidRepository.fetchCovidStats(event.selectedCountry.slug);
        emit(
            CovidStatsLoadSuccess(
              newCountry: event.selectedCountry,
              newDailyCovidStats: newDailyCovidStats,
            )
        );
      } catch(e) {
        emit(CovidStatsLoadFailure(attemptedCountry: event.selectedCountry));
      }
    });
    on<CovidStatsOrderSelected>((event, emit) {
      emit(
          CovidStatsOrderSuccess(
              order: event.order,
              selectedCountry: event.selectedCountry,
              dailyCovidStats: event.dailyCovidStats
          )
      );
    });
  }
}
