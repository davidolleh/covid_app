import 'package:covid_app/model/covid_model.dart';
import 'package:covid_app/view/loading_view.dart';
import 'package:flutter/material.dart';

import 'package:covid_app/view/main_page.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  LoadingController createState() => LoadingController();
}

class LoadingController extends State<Loading> {
  // TODO:: 이 컨트롤러가 바라볼 Model
  late CovidModel model;

  @override
  void initState() {
    super.initState();
    model = CovidModel();
    fetchCountries();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingView(
      countries: model.countries,
      controller: this
    );
  }

  void fetchCountries() {
    model.fetchCountries().then((_) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MainPage(model: model);
        //데이터 모델은 이미 만든 것이야 그것을 country.dart 에서 이미 만든 것 통해 만들었어 데이터의 가장 큰 모델만 만들면 돼 변형된 형태 그것은 만드는 것 아닌거 같음
      }
      ));
    });
    // 원래는 받기 전에 한바퀴 돔 navigator가 밖에 있어서 먼저 다음페이지로 이동해보고 본다
    // then whencomplete 자료들을 받은 다음 이것을 행동해라 async 받고 나서 다음페이지 넘겨주기
    //비동기적 프로그램 flutter 공부하기
  }
}