part of 'countries_cubit.dart';

@immutable
abstract class CountriesState extends Equatable {
    abstract final List<Country> countries;// 추상 변수 무조건 상속 받은 애들이 이 친구의 값을 정의해 주어야 한다
    //이게 다름
    const CountriesState();
}

class CountriesInitial extends CountriesState {
  @override//추상 클래스에서 추상 countries를 정의해 주었으니 그것을 다 정의해 get으로 정의해줌
  List<Country> get countries => []; //get은 다른 class에서 사용할때 countries를 사용해 주는 것 그것을 하면 []를 return 할 것임  이 state일 때 countries를 사용하면 []를 return
  //다른 class에서 countries를 사용하면 []가 들어 잇을 것임
  @override
  List<Object?> get props => [];//CountriesState를 Equatable를 상속 받았으므로 그것에 대한 비교 대상?
  //state를 Equatable를 상속 받은 class이므로 자동적으로 state가 변경 되었을때 즉 countriesInitial에서 CountriesLoadInProgress로 변경 되면 그 안에 값이
  //get props는 단지 props를 통해 비교하고 싶은 것 즉 새로운 들어온 정보들을 비교하고 싶으니깐 비교하고 싶은 것을 넣는 것 같은 class를 비교하는 것
}

class CountriesLoadInProgress extends CountriesState {
  @override
  List<Country> get countries => [];

  @override
  List<Object?> get props => [];
}

class CountriesLoadSuccess extends CountriesState {
  @override
  List<Country> get countries => _newCountries; // 이 state일때 다른 class에서 countries를 사용하면 _newcountries 를 불러온다

  final List<Country> _newCountries; //이 class일때 newCountries에다가 countries 정보들을 담아 둘 것

  const CountriesLoadSuccess({
    required List<Country> newCountries,
  }): _newCountries = newCountries;

  @override
  List<Object?> get props => countries; // 개인의 class를 비교하는 것 다른 class끼리 비교하는 것이 아니라 만약에 이 클라스가 2개 인스턴스화 되면 그것 들끼리 비교하는 것 비교 대상은 countries
}

class CountriesLoadFail extends CountriesState {
  @override
  List<Country> get countries => [];

  @override
  List<Object?> get props => [];
}