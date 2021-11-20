import 'package:covid_app/controller/main_page.dart';
import 'package:covid_app/model/repository/covid_repository.dart';

import 'entity/country.dart';
import 'entity/covid_stats.dart';

class MainModel {

  CovidRepository covidRepository = CovidRepository();

  final List<Country> _countries;
  List<CovidStats> _dailyCovidStats = [];
  Country _selectedCountry;
  String _order;

  List<Country> get countries => _countries;
  String get order => _order;
  List<CovidStats> get dailyCovidStats => _dailyCovidStats;
  Country get selectedCountry => _selectedCountry;

  MainModel({
    required countries,
    required order}) :
        _countries = countries,
        _selectedCountry = countries[0],
        _order = order;

  Future<void> changeCountry(Country newCountry, String order) async {
    _selectedCountry = newCountry;
    _dailyCovidStats = await covidRepository.getCountryCovid(_selectedCountry.slug, order);
  }

  void changeDailyCovidStatsOrder(String newOrder) {
    _order = newOrder;
    switch(newOrder) {
      case 'Newest':
        dailyCovidStats.sort((a,b) {
          // return a.confirmed.compareTo(b.confirmed);
          return b.date.toLowerCase().compareTo(a.date.toLowerCase());
        });
        break;
      case 'Oldest':
        dailyCovidStats.sort((a,b) {
          // return a.confirmed.compareTo(b.confirmed);
          return a.date.toLowerCase().compareTo(b.date.toLowerCase());
        });
        break;
      case 'Highest':
        dailyCovidStats.sort((a,b) {
          return b.deaths.compareTo(a.deaths);
        });
    }
  }


}