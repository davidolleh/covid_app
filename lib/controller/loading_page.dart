import 'package:covid_app/model/covid_model.dart';
import 'package:covid_app/view/loading_view.dart';
import 'package:flutter/material.dart';

import 'package:covid_app/controller/main_page.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  LoadingController createState() => LoadingController();
}

class LoadingController extends State<LoadingPage> {
  late CovidModel model;

  @override
  void initState() {
    super.initState();
    model = CovidModel();
    getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingView(countries: model.countries);
  }

  void getCountries() {
    model
        .getCountries()
        .then(
            (_) {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return MainPage(
                      model: model,
                    );
                  })
              );
            });
  }
}