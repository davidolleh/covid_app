import 'package:json_annotation/json_annotation.dart';

// class CountryDataCovid {
//   final String url;
//   CountryDataCovid(this.url);

//   Future<dynamic> getJsonData() async {
//     http.Response response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       String jsonData = response.body;
//       var parsingData = jsonDecode(jsonData);

//       return parsingData;
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
// }
@JsonSerializable()
class CovidStats {
  CovidStats({
    this.country = 'Switzerland',
    this.confirmed = 20505,
    this.deaths = 666,
    this.recovered = 6415,
    this.active = 13424,
    this.date = '2020-04-04T00:00:00Z',
  });

  final String country;
  final int confirmed;
  final int deaths;
  final int recovered;
  final int active;
  String date;

  // factory CountryData.fromJson(Map<String, dynamic> json) =>
  //     _$UserFromJson(json);
  // Map<String, dynamic> toJson() => _$UserToJson(this);
  factory CovidStats.fromJson(Map<String, dynamic> json) {
    return CovidStats(
        country: json['Country'],
        confirmed: json['Confirmed'],
        deaths: json['Deaths'],
        recovered: json['Recovered'],
        active: json['Active'],
        date: json['Date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "country": country,
      'confirmed': confirmed,
      'deaths': deaths,
      'recovered': recovered,
      'active': active,
      'date': date,
    };
  }
}