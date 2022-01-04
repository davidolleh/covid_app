import 'package:covid_app/blocs/covid_stats/covid_stats_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDropdownButton extends StatefulWidget {
  const OrderDropdownButton({Key? key}) : super(key: key);
  final List<String> orders = const ['Oldest', 'Newest', 'Highest'];

  @override
  _OrderDropdownButtonState createState() => _OrderDropdownButtonState();
}

class _OrderDropdownButtonState extends State<OrderDropdownButton> {
  late String currentOrder;

  @override
  void initState() {
    super.initState();
    currentOrder = widget.orders[0];
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: currentOrder,
        isExpanded: true,
        style: Theme.of(context).textTheme.bodyText1,
        onChanged: (String? newOrder) {
          var covidStatsBloc = context.read<CovidStatsBloc>();
          if(covidStatsBloc.state is CovidStatsUpdateSuccess) {
            covidStatsBloc.add(
                CovidStatsOrderSelected(
                    order: newOrder!,
                    selectedCountry: covidStatsBloc.state.selectedCountry!,
                    dailyCovidStats: covidStatsBloc.state.dailyCovidStats
                )
            );
            setState(() {
              currentOrder = newOrder;
            });
          }
        },
        items: widget.orders.map((String orderType) {
          return DropdownMenuItem(
            value: orderType,
            child: Center(
                child: Text(
                    orderType,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                )
            ),
          );
        }).toList()
    );
  }
}
