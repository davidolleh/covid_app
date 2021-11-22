import 'package:covid_app/model/covid_model.dart';
import 'package:covid_app/view/loading_view.dart';
import 'package:flutter/material.dart';

import 'package:covid_app/controller/main_page.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  LoadingController createState() => LoadingController();
}

class LoadingController extends State<Loading> {
  // TODO:: 이 컨트롤러가 바라볼 Model
  // 컨트롤러가 model이랑 view 연결 -> loading view 에서 가지고갈 데이터는 covid model을 가지고 view에게 데이터를 전달해주고
  // 컨트롤러가 바라볼 model이라는 것은 무엇인가?
  //tree의 root leaf controller 가 root 왼쪽 view 오른쪽 model
  late CovidModel model;

  @override
  void initState() {
    super.initState();
    model = CovidModel();//model에 데이터를 받아와서 보여줌 이것은 data를 view에 데이터를 넘겨주기위해서 만든 페이지: -> data, view연결? = controller이다
    fetchCountries();
  }
  //지금 data를 view에 넘겨줄 페이지를 따로 만들었다
  // data를 바당ㅇ서
  //그동안 보여줄 화면 화면은 화면 역할만 하면 됨으로 loading page에서는 data가 있을 필요가 없어 그러니깐 그냥  보이는 것만 나뚜면 되고 나머지 data전달은 controller에서 하는 것임
  //mainpage으로 보내는 것 도한 controller의 역할 인것인가?
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
  }
}