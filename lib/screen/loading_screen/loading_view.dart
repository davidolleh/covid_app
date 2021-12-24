import 'package:covid_app/screen/loading_screen/loading.dart';
import 'package:covid_app/model/entity/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Loading...'),
      ),
    );
  }
}
// class LoadingView extends StatelessWidget {
//   LoadingView({
//     required this.controller,
//     required this.countries,
//     Key? key
//   }) : super(key: key);
//
//   // TODO:: Controller는 데이터 접근용이 아니라 유저 Input 넘겨주기 위해 필요
//   final LoadingController controller;
//
//   // TODO:: 유저에게 보여줄 데이터. 로딩 페이지에서는 필요하지 않지만 예시로 넣음.
//   final List<Country> countries;
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text('Loading...'),
//       ),
//     );
//   }
// }