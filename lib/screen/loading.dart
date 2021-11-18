import 'package:covid_app/controller/data_listing.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:covid_app/model//entity/country.dart';
import 'package:covid_app/screen/main_page.dart';
import 'package:covid_app/model//repository/call_api.dart';
import 'package:covid_app/controller/data_listing.dart';

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

    // getCountry().then((countryNameList) {
    //   List<String> countriesNameList = List.from(countryNameList.map((country) => country.country));// controller를 통해 model countriesList, counstriesSlug, sort까지 해줘야돼
    //   List<String> countriesSlugs = List.from(countryNameList.map((country) => country.slug));
    //     Navigator.push(context, MaterialPageRoute(builder: (context) {
    //       return MainPage(parseCountryName: countriesNameList,parseCountrySlug: countriesSlugs);
    //         }
    //       ));
    //     });
    getCountry().then((countryNameList) {
      // List<String> countriesNameList = List.from(countryNameList.map((country) => country.country));// controller를 통해 model countriesList, counstriesSlug, sort까지 해줘야돼
      // List<String> countriesSlugs = List.from(countryNameList.map((country) => country.slug));
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MainPage(parseCountryName: getCountryList(countryNameList)[0],parseCountrySlug: countriesSlugs);
      }
      ));
    });
    // 원래는 받기 전에 한바퀴 돔 navigator가 밖에 있어서 먼저 다음페이지로 이동해보고 본다
    // then whencomplete 자료들을 받은 다음 이것을 행동해라 async 받고 나서 다음페이지 넘겨주기
    //비동기적 프로그램 flutter 공부하기
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