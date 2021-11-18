import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:covid_app/model//entity/covid_stats.dart';
import 'package:covid_app/model//entity/country.dart';

//repository 를 만들때 또한 class형태로 만들어 주어야 할까?
Future<List<Country>> getCountry() async {
  const String countryDataUrl = 'https://api.covid19api.com/countries';//이거 또한 따로 url entity를 저장해 주어야 될까?

  final http.Response response = await http.get(Uri.parse(countryDataUrl));
  final Iterable responseData = json.decode(response.body);
  // iterable loop을 돌리기 위해서 사용하는 것
  final List<Country> countries = List.from(responseData.map((countryJson) => Country.fromJson(countryJson)));

  return countries;
}

Future<List<CovidStats>> getCountryCovid(String countrySlug, String dropDownValueMenu) async {
  String countryDataCovidUrl =
      'https://api.covid19api.com/live/country/$countrySlug/status/confirmed/date/2020-03-21T13:13:30Z';
  final http.Response response = await http.get(Uri.parse(countryDataCovidUrl));
  final Iterable responseData = json.decode(response.body);

  List<CovidStats> covidData = List.from(responseData.map((dataJson) => CovidStats.fromJson(dataJson)));
  covidData.forEach((data) {
    data.date = data.date.substring(0, 10);
  });
  //sort 는 datacontroller 에 이용해야 되겠지 call_api는 데이터 전달하는 역할 가공 하고 데이터를 바꾸는 것은 controller
  if (dropDownValueMenu == 'Newest') {
    covidData.sort((b,a) {
      // return a.confirmed.compareTo(b.confirmed);
      return a.date.toLowerCase().compareTo(b.date.toLowerCase());
    });
  }
  else if (dropDownValueMenu == 'Oldest') {
    covidData.sort((a,b) {
      return a.date.toUpperCase().compareTo(b.date.toUpperCase());
    });//json parsing 부분 알기
  }
  else {
    covidData.sort((b,a) {
      return a.deaths.compareTo(b.deaths);
    });
  }
  return covidData;
}