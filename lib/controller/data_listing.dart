import 'package:covid_app/model/entity/covid_stats.dart';
import 'package:covid_app/model/entity/each_item.dart';

// TODO:: 이렇게 함수만 만드는 것은 좋은 습관이 아님.
// TODO:: Controller 클래스 내에 비즈니스 로직 넣고, Model 내에 데이터 request 및 response 로직 넣는걸로
CountryEachItem getCountryList(var data) {
  List<String> countriesNameList = List.from(data.map((country) => country.country));// controller를 통해 model countriesList, counstriesSlug, sort까지 해줘야돼
  List<String> countriesSlugs = List.from(data.map((country) => country.slug));

  countriesNameList.sort((a, b) {
    return a.toLowerCase().compareTo(b.toLowerCase());
  });

  countriesSlugs.sort((a,b) {
    return a.toLowerCase().compareTo(b.toLowerCase());
  });

  return CountryEachItem(countryNames: countriesNameList, countrySlugs: countriesSlugs);
}

CovidStatusEachItem getCovidStatusList(var data) {
  List<String> date = List.from(data.map((status) => status.date));
  List<int> deaths = List.from(data.map((status) => status.deaths));
  List<int> confirmed = List.from(data.map((status) => status.confirmed));
  List<int> recovered = List.from(data.map((status) => status.recovered));
  int maxConfirmed = confirmed.reduce((curr, next) => curr > next ? curr: next);

  return CovidStatusEachItem(date: date, deaths: deaths, confirmed: confirmed, recovered: recovered, maxConfirmed: maxConfirmed);
}