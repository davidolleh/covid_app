import 'package:covid_app/screen/loading_screen/loading.dart';
import 'package:covid_app/model/entity/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorView extends StatelessWidget {
  final String message;
  const ErrorView({required this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(message),
      ),
    );
  }
}


// class ErrorView extends StatefulWidget {
//   final String message;
//
//   const ErrorView({Key? key,
//     required this.message,
//   }) : super(key: key);
//
//   @override
//   State<ErrorView> createState() => _ErrorViewState();
// }
//
// class _ErrorViewState extends State<ErrorView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text(widget.message),
//       ),
//     );
//   }
// }