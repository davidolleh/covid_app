import 'package:bloc/bloc.dart';
import 'package:covid_app/model/entity/country.dart';
import 'package:covid_app/model/entity/covid_stats.dart';
import 'package:covid_app/model/repository/covid_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'covid_stats_event.dart';
part 'covid_stats_state.dart';

class
CovidStatsBloc extends Bloc<CovidStatsEvent, CovidStatsState> {
  CovidRepository repository;
  List<Country> country;
  String order;
  CovidStatsBloc(this.country, this.repository, this.order) : super(CovidStatsInitial(firstCountry: country[0])) {
    on<FetchCovidStats>((event, emit) async {
      // TODO: implement event handler
      emit(CovidStatsLoading(firstCountry: country[0]));//이 상태

      final List<CovidStats> dailyCovidStats = await repository.getCountryCovid(state.selectedCountry.slug, state.order);
      orderCovidStats(state, dailyCovidStats);//질문 dailyCovidStats = orderCovidStats해야될까? + dailyCovidstats도 state를 이용하면 안됨 다음 state를 이용해야됨 이걸 이용할 수 있을까 parameter를 state만 이용 할 수 있을까?
      final int maxConfirmed = changeMaxConfirmed(dailyCovidStats);
      emit(CovidStatsSuccess(dailyCovidStats: dailyCovidStats, selectedCountry: country[0], order: "Newest", maxConfirmed: maxConfirmed));
      // if(dailyCovidStats.isNotEmpty) {
      //   emit(CovidStatsSuccess(dailyCovidStats: dailyCovidStats, selectedCountry: country[0], order: "Newest", maxConfirmed: maxConfirmed));
      // }
      // else {
      //   emit(CovidStatsError(message: 'Error', firstCountry: country[0]));
      // }
    });

    on<SelectOrder>((event, emit) {
      emit(CovidStatsOrderUpdate(dailyCovidStats: state.dailyCovidStats, selectedCountry: state.selectedCountry, order: event.order, maxConfirmed: state.maxConfirmed));
      orderCovidStats(state, state.dailyCovidStats);
      emit(CovidStatsSuccess(dailyCovidStats: state.dailyCovidStats, selectedCountry: state.selectedCountry, order: event.order, maxConfirmed: state.maxConfirmed));
    });

    on<SelectCountry>((event, emit) async {
      Country selectedCountry = country[country.indexWhere((element) {
        return element.country == event.selectedCountry;
      })];
      emit(CovidStatsCountryUpdate(selectedCountry: selectedCountry, order
          : state.order));
      final List<CovidStats> dailyCovidStats = await repository.getCountryCovid(selectedCountry.slug, state.order);
      orderCovidStats(state, dailyCovidStats);
      int maxConfirmed = changeMaxConfirmed(dailyCovidStats);
      emit(CovidStatsSuccess(dailyCovidStats: dailyCovidStats, selectedCountry: selectedCountry, order: state.order, maxConfirmed: maxConfirmed));
    });
  }
}
void orderCovidStats(CovidStatsState state, List<CovidStats> dailyCovidStats) {
  if (state.order == 'Newest') {
    state.
    dailyCovidStats.sort((a,b) {
      // return a.confirmed.compareTo(b.confirmed);
      return b.date.toLowerCase().compareTo(a.date.toLowerCase());
    });
  }
  else if (state.order == 'Oldest') {
    state.dailyCovidStats.sort((a,b) {
      return a.date.toUpperCase().compareTo(b.date.toUpperCase());
    });//json parsing 부분 알기
  }
  else {
      dailyCovidStats.sort((b,a) {
      return a.deaths.compareTo(b.deaths);
    });
  }
}

int changeMaxConfirmed(List<CovidStats> dailyCovidStats) {
  int maxConfirmed = 0;
  dailyCovidStats.forEach((curr) {
  if (maxConfirmed < curr.confirmed) {
  maxConfirmed = curr.confirmed;
  }
  });
  return maxConfirmed;
}

// void orderCovidStats(Transition<CovidStatsEvent, CovidStatsState> transition) {
//   if (transition.nextState.order == 'Newest') {
//     transition.nextState.dailyCovidStats.sort((a,b) {
//       // return a.confirmed.compareTo(b.confirmed);
//       return b.date.toLowerCase().compareTo(a.date.toLowerCase());
//     });
//   }
//   else if (transition.nextState.order == 'Oldest') {
//       transition.nextState.dailyCovidStats.sort((a,b) {
//       return a.date.toUpperCase().compareTo(b.date.toUpperCase());
//     });//json parsing 부분 알기
//   }
//   else {
//       transition.nextState.dailyCovidStats.sort((b,a) {
//       return a.deaths.compareTo(b.deaths);
//     });
//   }
// }

// Future<void> fetchCovidStats() async {
//   _dailyCovidStats = await repository.getCountryCovid(_selectedCountry.slug, _order);
//   changeMaxConfirmed();
// }
//

// void changeSelectCountry(String newValue) {
//   _selectedCountry = countries[countries.indexWhere((country) => country.country == newValue)];
// }
//
// void changeSelectOrder(String newValue) {
//   _order = newValue;
// }