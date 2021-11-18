class covidStatusEachItem {
  covidStatusEachItem({required this.date, required this.deaths, required this.confirmed, required this.recovered, required this.maxConfirmed});

  List<String> date;
  List<int> deaths;
  List<int> confirmed;
  List<int> recovered;
  int maxConfirmed;
}