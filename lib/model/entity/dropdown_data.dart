class DropdownData {
  String dropDownCountry = 'Korea (South)';
  String dropDownMenu = 'Newest';

  void selectCountry(String newValue) {
    dropDownCountry = newValue;
  }

  void selectMenu(String newValue) {
    dropDownMenu = newValue;
  }
}