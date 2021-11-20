import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:covid_app/model/entity/covid_stats.dart';
import 'package:covid_app/model/entity/country.dart';


class CovidRepository{
  Future<List<Country>> fetchCountries() async {
    const String countryDataUrl = 'https://api.covid19api.com/countries';

    final http.Response response = await http.get(Uri.parse(countryDataUrl));
    final Iterable responseData = json.decode(response.body);
    final List<Country> countries = List.from(
        responseData.map(
                (countryJson) => Country.fromJson(countryJson)
        )
    );

    return countries;
  }

  Future<List<CovidStats>> fetchCovidStats(String countrySlug) async {
    var startDate = DateTime.now().subtract(const Duration(days: 201));
    String countryDataCovidUrl =
        'https://api.covid19api.com/live/country/$countrySlug/status/confirmed/date/${startDate}Z';
    final http.Response response = await http.get(Uri.parse(countryDataCovidUrl));
    final Iterable responseData = json.decode(response.body);

    List<CovidStats> covidData = List.from(responseData.map((dataJson) => CovidStats.fromJson(dataJson)));
    for (var data in covidData) {
      data.date = data.date.substring(0, 10);
    }
    for (var i in (Iterable.generate(covidData.length).toList().reversed)) {
      if(i == 0) continue;
      covidData[i].confirmed -= covidData[i-1].confirmed;
      covidData[i].deaths -= covidData[i-1].deaths;
      covidData[i].recovered -= covidData[i-1].recovered;
    }
    covidData.removeAt(0);

    return covidData;
  }
}