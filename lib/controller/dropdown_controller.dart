import 'package:covid_app/model/entity/dropdown_data.dart';

class DropDownController {
  void selectCountry(DropdownData dropdownData ,String newValue) {
      dropdownData.dropDownCountry = newValue;
  }

  void selectMenu(DropdownData dropdownData, String newValue) {
     dropdownData.dropDownMenu = newValue;
  }
}