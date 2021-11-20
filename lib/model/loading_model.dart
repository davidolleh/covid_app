
import 'entity/country.dart';
import 'repository/covid_repository.dart';

class LoadingModel {
  CovidRepository covidRepository = CovidRepository();

  late List<Country> countries;

  LoadingModel();

  Future<void> getCountries() async {
    countries = await covidRepository.getCountries();
    countries.sort((a,b) {
      return a.country.toLowerCase().compareTo(b.country.toLowerCase());
    });
  }
}