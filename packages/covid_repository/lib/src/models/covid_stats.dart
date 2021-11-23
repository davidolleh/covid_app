import 'package:json_annotation/json_annotation.dart';

part 'covid_stats.g.dart';

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

  @JsonKey(name: 'Country')
  final String country;
  @JsonKey(name: 'Confirmed')
  int confirmed;
  @JsonKey(name: 'Deaths')
  int deaths;
  @JsonKey(name: 'Recovered')
  int recovered;
  @JsonKey(name: 'Active')
  final int active;
  @JsonKey(name: 'Date')
  String date;

  factory CovidStats.fromJson(Map<String, dynamic> json) =>
      _$CovidStatsFromJson(json);
  Map<String, dynamic> toJson() => _$CovidStatsToJson(this);
}