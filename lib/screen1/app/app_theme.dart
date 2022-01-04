import 'package:flutter/material.dart';

const TitleTextSize = 20.0;
const SmallTextSize = 15.0;

const AppBarTextStyle = TextStyle(
    color: Colors.white,
    fontSize: TitleTextSize
);

const TitleTextStyle = TextStyle(
    color: Colors.black,
    fontSize: TitleTextSize,
    fontWeight: FontWeight.w400
);

const DarkBackgroundTextStyle = TextStyle(
    color: Colors.white,
    fontSize: SmallTextSize,
    fontWeight: FontWeight.w400
);

const LightBackgroundTextStyle = TextStyle(
    color: Colors.black,
    fontSize: SmallTextSize,
    fontWeight: FontWeight.w400
);

final appTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    appBarTheme: const AppBarTheme(
        titleTextStyle: AppBarTextStyle
    ),
    textTheme: const TextTheme(
        headline1: TitleTextStyle,
        bodyText1: LightBackgroundTextStyle,
        bodyText2: DarkBackgroundTextStyle
    )
);