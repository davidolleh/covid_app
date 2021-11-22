import 'package:covid_app/model/covid_model.dart';
import 'package:covid_app/view/main_page_view.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  // const MainPage({Key? key}) : super(key: key);
  MainPage({required this.model});
  CovidModel model;


  @override
  MainPageController createState() => MainPageController();
}

class MainPageController extends State<MainPage> {
  // get selectController => widget.model.s
  // set order(String newOrder) {
  //   widget.model.order = newOrder;
  // }//이런걸로

  // set,get controller사용 x on... onevent onCountryChange 새로 함수 만드는것
  // view model 접근 불가 view에서 input 호출 해서 이 함수 호출시켜서 controller가 모델에서 값을 바꿔라

  void onChangeSelectCountry(String newValue) {
    widget.model.changeSelectCountry(newValue);
    widget.model.fetchCovidStats().then((_) {
      widget.model.orderCovidStats();
      setState(() {
      });
    }
    );
  }
  //처음에는 setState안에 모든 위에 3함수를 집어 넣엇다 그런데 그러면 화면에 보여지지 않는다 내 생각에는 fetchCovidStats이 async함수 이므로 그런거 같다 그렇게 되면 화면 먼저 보여지고 데이터를 불러오는 거같다

  void onChangeSelectOrder(String newValue) {
    setState(() {
      widget.model.changeSelectOrder(newValue);
      widget.model.orderCovidStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    //view는 model를 알면 안돼
    return MainPageView(
        countries: widget.model.countries,
        dailyCovidStats: widget.model.dailyCovidStats,
        order: widget.model.order,
        selectedCountry: widget.model.selectedCountry,
        maxConfirmed: widget.model.maxConfirmed,
        controller: this
    );
  }
}
