import 'package:covid_app/blocs/covid_stats/covid_stats_bloc.dart';
import 'package:covid_repository/covid_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryDropdownButton extends StatefulWidget {
  const CountryDropdownButton({required this.countries, Key? key}) : super(key: key);

  final List<Country> countries;

  @override
  _CountryDropdownButtonState createState() => _CountryDropdownButtonState();
}

class _CountryDropdownButtonState extends State<CountryDropdownButton> {
  late Country selectedCountry;

  @override
  void initState() {
    super.initState();
    selectedCountry = widget.countries[0];
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Country>(
      hint: const Text('choose a country'),
      value: selectedCountry,
      isExpanded: true,
      style: const TextStyle(
          color: Colors.black,
          fontSize: 20.0
      ),
      onChanged: (Country? newCountry) {
        if(newCountry != null){
          context.read<CovidStatsBloc>().add(
              CovidStatsRequested(
                  selectedCountry: newCountry
              )
          );
          setState(() {
            selectedCountry = newCountry;
          });
        }
      },
      items: List.from(
          widget.countries.map(
              (Country c) =>
                  DropdownMenuItem(
                    value: c,
                    child: Text(c.country),
                  )
          )
      ),
    );
  }
}
