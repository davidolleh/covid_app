import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:covid_app/model/entity/covid_stats.dart';
import 'package:covid_app/model/entity/country.dart';


class CovidRepository{
  Future<List<Country>> getCountries() async {
    // TODO:: URL은 Entity 만들 필요 없음. Entity는 API에서 받는 데이터를 저장하는 클래스임.
    const String countryDataUrl = 'https://api.covid19api.com/countries';//이거 또한 따로 url entity를 저장해 주어야 될까?

    final http.Response response = await http.get(Uri.parse(countryDataUrl));
    final Iterable responseData = json.decode(response.body);
    // iterable loop을 돌리기 위해서 사용하는 것
    // TODO:: 아래의 줄이 정확히 뭘하는 코드인지 나한테 카톡으로 설명해서 보내봐. (map 함수, Iterable, List.from 함수 설명)
    final List<Country> countries = List.from(responseData.map((countryJson) => Country.fromJson(countryJson)));

    return countries;
  }

// TODO:: Entity 이름 바꿨으니 이 함수 이름도 바꿔봐(Refactor -> Rename)
  Future<List<CovidStats>> getCountryCovid(String countrySlug, String order) async {
    String countryDataCovidUrl =
        'https://api.covid19api.com/live/country/$countrySlug/status/confirmed/date/2020-03-21T13:13:30Z';
    final http.Response response = await http.get(Uri.parse(countryDataCovidUrl));
    final Iterable responseData = json.decode(response.body);

    List<CovidStats> covidData = List.from(responseData.map((dataJson) => CovidStats.fromJson(dataJson)));
    covidData.forEach((data) {
      data.date = data.date.substring(0, 10);
    });
    // TODO:: Repository는 데이터 가공을 하지 말아야 함. Sorting은 일단 지금은 Repository에서 하지 않는걸로.
    //sort 는 datacontroller 에 이용해야 되겠지 call_api는 데이터 전달하는 역할 가공 하고 데이터를 바꾸는 것은 controller
    // TODO:: a,b argument를 쓰는 람다 함수(익명 함수)가 많은데, 순서가 이렇게 계속 바뀔 필요가 있나?(e.g. a,b; b,a; a,b) 순서를 통일하도록 하자(a,b).
    if (order == 'Newest') {
      covidData.sort((b,a) {
        // return a.confirmed.compareTo(b.confirmed);
        return a.date.toLowerCase().compareTo(b.date.toLowerCase());
      });
    }
    else if (order == 'Oldest') {
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
}