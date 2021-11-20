import 'package:covid_app/model/entity/country.dart';
import 'package:covid_app/model/entity/covid_stats.dart';
import 'package:covid_app/model/repository/covid_repository.dart';

// TODO:: 이 Model은 한 페이지에서만 보는게 아니라, 로딩이 끝나면 메인 페이지에서 보게됨
// TODO:: 앱 전반에 필요한 Model
class CovidModel {
  // TODO:: API에 접근하기 위해 Repository 생성
  CovidRepository repository = CovidRepository();

  // TODO:: 앱에서 필요로 하는 데이터. 외부 접근을 막기위해 private 변수로 설정.
  List<Country> _countries = [];
  List<CovidStats> _dailyCovidStats = [];
  String _order = "Newest";
  Country _selectedCountry = Country();

  // TODO:: 외부에서 값을 읽기 위해서는 getter가 필요.
  List<Country> get countries => _countries;
  List<CovidStats> get dailyCovidStats => _dailyCovidStats;
  String get order => _order;
  Country get selectedCountry => _selectedCountry;

  Future<void> fetchCountries() async {
    _countries = await repository.getCountry();
    _countries.sort((a,b) {
      return a.country.toLowerCase().compareTo(b.country.toLowerCase());
    });
    _selectedCountry = _countries[0];
  }

//TODO:: 필요에 따라 추가적인 함수를 만들도록

}