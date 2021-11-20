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
    String countryDataCovidUrl =
        'https://api.covid19api.com/live/country/$countrySlug/status/confirmed/date/2020-03-21T13:13:30Z';
    final http.Response response = await http.get(Uri.parse(countryDataCovidUrl));
    final Iterable responseData = json.decode(response.body);

    List<CovidStats> covidData = List.from(responseData.map((dataJson) => CovidStats.fromJson(dataJson)));
    covidData.forEach((data) => data.date = data.date.substring(0, 10));
    return covidData;
  }
}