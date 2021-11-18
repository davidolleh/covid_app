import 'package:covid_app/model/entity/country.dart';
import 'package:covid_app/model/entity/country_each_item.dart';

// List<dynamic> getCountryList(List<Country> countryList) {
//   List<String> countriesNameList = List.from(countryList.map((country) => country.country));// controller를 통해 model countriesList, counstriesSlug, sort까지 해줘야돼
//   List<String> countriesSlugs = List.from(countryList.map((country) => country.slug));
//
//   countriesNameList.sort((a, b) {
//     return a.toLowerCase().compareTo(b.toLowerCase());
//   });
//
//   countryEachItem(countryNames: countriesNameList, countrySlugs: countriesSlugs);
//
//   return countriesNameList;
// }

List<List<String>> getCountryList(List<Country> countryList) {
  List<String> countriesNameList = List.from(countryList.map((country) => country.country));// controller를 통해 model countriesList, counstriesSlug, sort까지 해줘야돼
  List<String> countriesSlugs = List.from(countryList.map((country) => country.slug));

  countriesNameList.sort((a, b) {
    return a.toLowerCase().compareTo(b.toLowerCase());
  });

  countryEachItem(countryNames: countriesNameList, countrySlugs: countriesSlugs);

  return [countriesNameList, countriesSlugs];
}
