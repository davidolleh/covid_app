import 'package:covid_app/model/entity/country.dart';
import 'package:covid_app/model/main_model.dart';
import 'package:flutter/material.dart';

import '../view/main_view.dart';

class MainPage extends StatefulWidget {
  List<Country> countries;

  MainPage({required this.countries});

  @override
  MainPageController createState() => MainPageController();
}

class MainPageController extends State<MainPage> {

  late MainModel model;

  @override
  void initState() {
    super.initState();
    model = MainModel(
        countries: widget.countries,
        order: 'Newest'
    );
    changeCountry(model.selectedCountry, model.order);
  }

  @override
  Widget build(BuildContext context) {
    return MainView(
      selectedCountry: model.selectedCountry,
      countries: model.countries,
      order: model.order,
      dailyCovidStats: model.dailyCovidStats,
      controller: this,
    );
  }

  void changeCountry(Country newCountry, String order) {
    model
        .changeCountry(newCountry, order)
        .then(
            (_) => setState(() {model = model;})
    );
  }

  void changeOrder(String newOrder) {
    setState(() {
      model.changeDailyCovidStatsOrder(newOrder);
    });
  }
}