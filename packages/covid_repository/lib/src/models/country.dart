import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable()
class Country {
  Country({this.country='Barbados', this.slug='barbados', this.iso2='BB'});

  @JsonKey(name: 'Country')
  final String country;
  @JsonKey(name: 'Slug')
  final String slug;
  @JsonKey(name: 'ISO2')
  final String iso2;

  factory Country.fromJson(Map<String, dynamic> json) {
    return _$CountryFromJson(json);
  }
  Map<String, dynamic> toJson() => _$CountryToJson(this);
}