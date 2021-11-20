import 'package:covid_app/model/covid_model.dart';
import 'package:covid_app/model/entity/country.dart';
import 'package:flutter/material.dart';

import '../view/main_view.dart';

class MainPage extends StatefulWidget {
  final CovidModel _model;

  const MainPage({
    required CovidModel model,
    Key? key}) :
        _model = model,
        super(key: key);

  @override
  MainPageController createState() => MainPageController();
}

class MainPageController extends State<MainPage> {

  late CovidModel _model;

  @override
  void initState() {
    super.initState();
    _model = widget._model;
    changeCountry(_model.selectedCountry, _model.order);
  }

  @override
  Widget build(BuildContext context) {
    return MainView(
      selectedCountry: _model.selectedCountry,
      countries: _model.countries,
      order: _model.order,
      dailyCovidStats: _model.dailyCovidStats,
      controller: this,
    );
  }

  void changeCountry(Country newCountry, String order) {
    _model
        .changeCountry(newCountry)
        .then(
            (_) => setState(() {_model = _model;})
    );
  }

  void changeOrder(String newOrder) {
    setState(() {
      _model.order = newOrder;
    });
  }
}