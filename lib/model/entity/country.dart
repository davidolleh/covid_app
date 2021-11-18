import 'package:json_annotation/json_annotation.dart';
// import 'country_data.g.dart';

// class CountryData {
//   final String url;
//   CountryData(this.url);

//   Future<dynamic> getJsonData() async {
//     http.Response response = await http.get(Uri.parse(url));
//     // 데이터 직렬화 하는 이유: data자체만 넘겨서 내 언어에 맞게 수정하는 것

//     if (response.statusCode == 200) {
//       String jsonData = response.body;
//       // var parsingDataAll = jsonDecode(jsonData);
//       var parsingData = jsonDecode(jsonData);
//       // var parsingData = json.decoder(jsonData)
//       // json.decode(json.encode(jsonData)) as Map<String, dynamic>;
//       //api를 가져올때 전체를 들고 오는 것이지 가려서 받을 수 없다
//       return parsingData;
//     } else {
//       response.reasonPhrase;
//     }
//   }
// }

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
}//entity