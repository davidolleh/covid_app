class CountryEachItem {
  CountryEachItem({required this.countryNames, required this.countrySlugs});

  List<String> countryNames;
  List<String> countrySlugs;

  int getKoreaIndex(List<String> countryNames) {
    int koreaIndex;

    koreaIndex = countryNames.indexOf('Korea (South)');
    return koreaIndex;
  }
}

class CovidStatusEachItem {
  CovidStatusEachItem({required this.date, required this.deaths, required this.confirmed, required this.recovered, required this.maxConfirmed});

  List<String> date;
  List<int> deaths;
  List<int> confirmed;
  List<int> recovered;
  int maxConfirmed;
}