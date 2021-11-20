import 'package:covid_app/model/repository/covid_repository.dart';

import 'entity/country.dart';
import 'entity/covid_stats.dart';

class CovidModel {
  CovidRepository covidRepository = CovidRepository();

  // 중요한 데이터들(외부에서 수정하면 안됨)
  List<Country> _countries = [];
  List<CovidStats> _dailyCovidStats = [];
  Country _selectedCountry = Country();
  String _order = "Newest";

  // 외부에서 멤버 변수 값을 읽을때는 이런 방식으로
  List<Country> get countries => _countries;
  String get order => _order;
  List<CovidStats> get dailyCovidStats => _dailyCovidStats;
  Country get selectedCountry => _selectedCountry;

  // 외부에서 멤버 변수 값을 바꿀때는 이런 방식으로
  set countries(List<Country> newCountries) {
    _countries = newCountries;
    _selectedCountry = _countries[0];
  }

  set order(String newOrder) {
    _order = newOrder;
    orderDailyCovidStats(newOrder);
  }

  // 보조 함수
  void orderDailyCovidStats(String newOrder) {
    switch(newOrder) {
      case 'Newest':
        _dailyCovidStats.sort((a,b) {
          // return a.confirmed.compareTo(b.confirmed);
          return b.date.toLowerCase().compareTo(a.date.toLowerCase());
        });
        break;
      case 'Oldest':
        _dailyCovidStats.sort((a,b) {
          // return a.confirmed.compareTo(b.confirmed);
          return a.date.toLowerCase().compareTo(b.date.toLowerCase());
        });
        break;
      case 'Highest':
        _dailyCovidStats.sort((a,b) {
         return b.deaths.compareTo(a.deaths);
        });
    }
  }

  // API를 통해 값을 받아올때는 이런 방식으로
  Future<void> fetchCountries() async {
    _countries = await covidRepository.fetchCountries();
    _countries.sort((a,b) {
      return a.country.toLowerCase().compareTo(b.country.toLowerCase());
    });
    _selectedCountry = _countries[0];
  }

  Future<void> changeCountry(Country newCountry) async {
    _selectedCountry = newCountry;
    _dailyCovidStats = await covidRepository.fetchCovidStats(_selectedCountry.slug);
    orderDailyCovidStats(_order);
  }


}