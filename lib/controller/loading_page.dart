import 'package:covid_app/model/loading_model.dart';
import 'package:covid_app/view/loading_view.dart';
import 'package:flutter/material.dart';

import 'package:covid_app/controller/main_page.dart';
import 'package:covid_app/model/repository/covid_repository.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  LoadingController createState() => LoadingController();
}

class LoadingController extends State<LoadingPage> {
  late LoadingModel model;

  @override
  void initState() {
    super.initState();
    model = LoadingModel();
    getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingView();
  }

  void getCountries() {
    model.getCountries().then(
            (_) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MainPage(
          countries: model.countries,
        );
      }));
    });
  }
}