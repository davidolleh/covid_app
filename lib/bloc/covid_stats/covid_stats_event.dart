part of 'covid_stats_bloc.dart';

@immutable
abstract class CovidStatsEvent {}

class FetchCovidStats extends CovidStatsEvent {


  @override
  String toString() {
    return "fetch covid stats";
  }
}

class SelectCountry extends CovidStatsEvent {
  final String? selectedCountry;

  SelectCountry({
    required this.selectedCountry
  });
  @override
  String toString() {
    return 'change country';
  }
}


class SelectOrder extends CovidStatsEvent {
  final String order;

  SelectOrder({
    required this.order
  });
  @override
  String toString() {
    return 'change order';
  }
}
