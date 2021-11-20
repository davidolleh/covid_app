import 'package:covid_app/model/entity/dropdown_data.dart';

// TODO:: 필요없는 클래스임 지우는게 좋을듯
class DropDownController {
  void selectCountry(DropdownData dropdownData ,String newValue) {
      dropdownData.dropDownCountry = newValue;
  }

  void selectMenu(DropdownData dropdownData, String newValue) {
     dropdownData.dropDownMenu = newValue;
  }
}