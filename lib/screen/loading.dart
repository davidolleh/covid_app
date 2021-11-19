import 'package:flutter/material.dart';

import 'package:covid_app/screen/main_page.dart';
import 'package:covid_app/model//repository/call_api.dart';

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

    getCountry().then((countryList) {
      countryList.sort((a,b) {
        return a.country.toLowerCase().compareTo(b.country.toLowerCase());
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MainPage(parseCountryName: List.from(countryList.map((countryName) => countryName.country)),parseCountrySlug: List.from(countryList.map((countryName) => countryName.slug)));
        //데이터 모델은 이미 만든 것이야 그것을 country.dart 에서 이미 만든 것 통해 만들었어 데이터의 가장 큰 모델만 만들면 돼 변형된 형태 그것은 만드는 것 아닌거 같음
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