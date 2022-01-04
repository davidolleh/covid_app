import 'package:bloc/bloc.dart';
import 'package:covid_app/model/entity/country.dart';
import 'package:covid_app/model/entity/covid_stats.dart';
import 'package:covid_app/model/repository/covid_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'covid_stats_event.dart';

part 'covid_stats_state.dart';

class CovidStatsBloc extends Bloc<CovidStatsEvent, CovidStatsState> {
  final CovidRepository _covidRepository;

  CovidStatsBloc(CovidRepository covidRepository)
      : _covidRepository = covidRepository,
        super(CovidStatsInitial()) {
    on<CovidStatsRequest>((event, emit) async {
      emit(
          CovidStatsLoadInProgress(newSelectCountry: event.newSelectedCountry));
      try {
        List<CovidStats> newCovidStats = await _covidRepository
            .getCountryCovid(event.newSelectedCountry.slug);
        emit(CovidStatsLoadSuccess(
            newSelectCountry: state.selectedCountry,
            newCovidStats: newCovidStats));
      } catch (e) {
        emit(const CovidStatsLoadFail());
      }
    });
    on<CovidStatsSelectOrder>((event, emit) {
      orderDailyCovidStats(event.newOrder);
      emit(CovidStatsSelectedOrder(
          order: event.newOrder,
          newSelectedCountry: state.selectedCountry,
          newCovidStats: state.covidStats));
    });
  }

  void orderDailyCovidStats(String newOrder) {
    switch (newOrder) {
      case 'Newest':
        state.covidStats.sort(
            (a, b) => b.date.toLowerCase().compareTo(a.date.toLowerCase()));
        break;
      case 'Oldest':
        state.covidStats.sort(
            (a, b) => a.date.toLowerCase().compareTo(b.date.toLowerCase()));
        break;
      case 'Highest':
      default:
        state.covidStats.sort((a, b) => b.confirmed.compareTo(a.confirmed));
    }
  }
}
