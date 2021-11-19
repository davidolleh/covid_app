// TODO:: Country랑 CovidStats라는 Entity 클래스들과 아래의 두 클래스들이랑은 차이가 없음 == 아래 2개는 필요 없는 클래스.
// TODO:: 이해가 안되면 질문 ㄱㄱ.
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