import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Country {
  Country({this.country='Barbados', this.slug='barbados', this.iso2='BB'});

  final String country;
  final String slug;
  final String iso2;
  // factory CountryData.fromJson(Map<String, dynamic> json) =>
  //     _$UserFromJson(json);
  // Map<String, dynamic> toJson() => _$UserToJson(this);
  //jsondata를 가지고 와서 그것을 class를 만들 거야 그것을 class형태로 만들어서 넣을 거야
  // 이 class는 하나의 country를 하나씩 가져와서 만들어주는 것
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(//column data,, row 각 나라
      country: json['Country'],
      slug: json['Slug'],
      iso2: json['ISO2'],
    );
  }//logic 말고
  //flat한 형태 가지고 오는 것 이것을 따로 list끼리 묵어주는 게 필요할까

  Map<String, dynamic> toJson() {
    return {
      "country": country,
      "slug": slug,
      "iso2": iso2,
    };
  }
}//entity api로 가져온 데이터 저장 형태
// model은 데이터와 로직만
// view 보이는 화면 input을 받는다
// controller 모데 view와 model 연결
//controller 함수를 불러서 그안에서 setState해서 값을 변경 시키자 setState함수 자체를 controller로 옮겨놔라 -> 당연히 변하는 값들은 model로 설정해야 되겠지