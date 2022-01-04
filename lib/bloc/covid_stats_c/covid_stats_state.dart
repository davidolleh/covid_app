part of 'covid_stats_bloc.dart';

@immutable
abstract class CovidStatsState extends Equatable {
  final Country? _selectedCountry;
  final List<CovidStats> _covidStats;

  const CovidStatsState(
      {required Country? selectedCountry,
      required List<CovidStats> covidStats})
      : _selectedCountry = selectedCountry,
        _covidStats = covidStats;

  Country? get selectedCountry => _selectedCountry;

  List<CovidStats> get covidStats => _covidStats;
}

class CovidStatsInitial extends CovidStatsState {
  CovidStatsInitial() : super(selectedCountry: null, covidStats: []);

  @override
  List<Object?> get props => [];
}

class CovidStatsLoadInProgress extends CovidStatsState {
  CovidStatsLoadInProgress({required Country? newSelectCountry})
      : super(selectedCountry: newSelectCountry, covidStats: []);

  @override
  List<Object?> get props => [selectedCountry];
}

class CovidStatsLoadSuccess extends CovidStatsState {
  const CovidStatsLoadSuccess(
      {required Country? newSelectCountry,
      required List<CovidStats> newCovidStats})
      : super(selectedCountry: newSelectCountry, covidStats: newCovidStats);

  @override
  // TODO: implement props
  List<Object?> get props => [selectedCountry, covidStats];
}

class CovidStatsLoadFail extends CovidStatsState {
  const CovidStatsLoadFail(): super(selectedCountry: null, covidStats: const []);

  @override
  List<Object?> get props => [];
}

class CovidStatsLoadSelectCountry extends CovidStatsState {
  final String _order;

  const CovidStatsLoadSelectCountry(
      {required String order,
        required Country? newSelectedCountry,
        required List<CovidStats> newCovidStats})
      : _order = order,
        super(selectedCountry: newSelectedCountry, covidStats: newCovidStats);

  String get order => _order;

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class CovidStatsSelectedOrder extends CovidStatsState {
  final String _order;

  const CovidStatsSelectedOrder(
      {required String order,
      required Country? newSelectedCountry,
      required List<CovidStats> newCovidStats})
      : _order = order,
        super(selectedCountry: newSelectedCountry, covidStats: newCovidStats);

  String get order => _order;

  @override
  List<Object?> get props => [_order, selectedCountry, covidStats];
}
