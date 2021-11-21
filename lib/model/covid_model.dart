import 'package:covid_app/model/entity/country.dart';
import 'package:covid_app/model/entity/covid_stats.dart';
import 'package:covid_app/model/repository/covid_repository.dart';


//다시 한번 정리해보자면 entity는 데이터 형태를 명시해주는 곳이고, model은 그냥 데이터 저장소이다 repository는 json값을 받아오는 것 뿐 그 외 작업은 하면 x
// TODO:: 이 Model은 한 페이지에서만 보는게 아니라, 로딩이 끝나면 메인 페이지에서 보게됨
// TODO:: 앱 전반에 필요한 Model
class CovidModel {//왜 모델 안에 api불러오는 것을 두엇는지 밑에 함수를 통해 countries에 값을 넣기 위해서 인듯
  // TODO:: API에 접근하기 위해 Repository 생성
  CovidRepository repository = CovidRepository();

  // TODO:: 앱에서 필요로 하는 데이터. 외부 접근을 막기위해 private 변수로 설정.
  List<Country> _countries = [];
  List<CovidStats> _dailyCovidStats = [];
  String _order = "Newest";
  Country _selectedCountry = Country();
  int _maxConfirmed = 0;

  // TODO:: 외부에서 값을 읽기 위해서는 getter가 필요.
  List<Country> get countries => _countries;
  List<CovidStats> get dailyCovidStats => _dailyCovidStats;
  String get order => _order;
  Country get selectedCountry => _selectedCountry;
  int get maxConfirmed => _maxConfirmed;

  //이것은 밑에 changeSelectCountry처럼 값을 넣기 위해 여기안에 만들어 놓은 거 같다 //데이터에 접근 하는 것이면 이것은 controller역할 인 거 같다
  //근데 밑에 것은 데이터를 그냥 넣는 것이고
  // 2번째 3번째는 값을 변경하는 것
  Future<void> fetchCountries() async {
    _countries = await repository.getCountry();
    _countries.sort((a,b) {
      return a.country.toLowerCase().compareTo(b.country.toLowerCase());
    });
    _selectedCountry = _countries[0];
  }

  void orderCovidStats() {
    if (_order == 'Newest') {
      _dailyCovidStats.sort((a,b) {
        // return a.confirmed.compareTo(b.confirmed);
        return b.date.toLowerCase().compareTo(a.date.toLowerCase());
      });
    }
    else if (_order == 'Oldest') {
      _dailyCovidStats.sort((a,b) {
        return a.date.toUpperCase().compareTo(b.date.toUpperCase());
      });//json parsing 부분 알기
    }
    else {
      _dailyCovidStats.sort((b,a) {
        return a.deaths.compareTo(b.deaths);
      });
    }
  }

  Future<void> fetchCovidSats() async {
    _dailyCovidStats = await repository.getCountryCovid(_selectedCountry.slug, _order);
    orderCovidStats();
    // _maxConfirmed = _dailyCovidStats.reduce((curr, next) => curr.confirmed > next.confirmed ? curr.confirmed : next.confirmed);
    _dailyCovidStats.forEach((curr) {
      if (_maxConfirmed < curr.confirmed) {
        _maxConfirmed = curr.confirmed;
      }
    });
  }

  void changeSelectCountry(Country selectedCountry ,String newValue) {
    _selectedCountry = countries[countries.indexWhere((country) => country.country == newValue)];
  }

  void changeSelectOrder(String newValue) {
    _order = newValue;
  }
//TODO:: 필요에 따라 추가적인 함수를 만들도록
}