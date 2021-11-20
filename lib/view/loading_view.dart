import 'package:covid_app/model/entity/country.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({required this.countries, Key? key}) : super(key: key);

  final List<Country> countries;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: const Text('Loading...'),
      ),
    );
  }
}