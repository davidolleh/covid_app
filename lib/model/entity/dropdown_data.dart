// TODO:: Dropdown에 들어갈 값들은 굳이 클래스로 안 묶어줘도 됨. 각각을 그냥 State 클래스에 멤버 변수로 넣는게 나을듯.
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