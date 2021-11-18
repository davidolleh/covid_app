import 'package:flutter/material.dart';
import 'package:covid_app/repository/country.dart';
import 'package:covid_app/screen/main_page.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:covid_app/repository/covid_stats.dart';


class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCountry().then((countryNameList) {
      List<String> countriesList = List.from(countryNameList.map((country) => country.country));
      List<String> countriesSlugs = List.from(countryNameList.map((country) => country.slug));
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MainPage(parseCountryName: countriesList,parseCountrySlug: countriesSlugs);
            }
          ));
        });
    // 원래는 받기 전에 한바퀴 돔 navigator가 밖에 있어서 먼저 다음페이지로 이동해보고 본다
    // then whencomplete 자료들을 받은 다음 이것을 행동해라 async 받고 나서 다음페이지 넘겨주기
    //비동기적 프로그램 flutter 공부하기
  }

  Future<List<Country>> getCountry() async {
    const String countryDataUrl = 'https://api.covid19api.com/countries';

    final http.Response response = await http.get(Uri.parse(countryDataUrl));
    final Iterable responseData = json.decode(response.body);
    // iterable loop을 돌리기 위해서 사용하는 것
    final List<Country> countries = List.from(responseData.map((countryJson) => Country.fromJson(countryJson)));

    List<String> countriesList = List.from(countries.map((country) => country.country));

    return countries;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: const Text('Loading...'),
      ),
    );
  }
}