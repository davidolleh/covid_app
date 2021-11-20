import 'package:flutter/material.dart';
import 'package:covid_app/controller/loading_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: LoadingPage(),//page들은 stack통해 따로 관리가 필요 없애줄건 없애준다 느낌으로 loading창은 아예 없어져도 상관 없잖아
    );
  }
}