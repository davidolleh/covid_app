import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:covid_app/screen/covid_data_page.dart';
import 'package:covid_app/model//entity/covid_stats.dart';
import 'package:covid_app/model/repository/call_api.dart';
import 'package:covid_app/screen/my_painter.dart';

class MainPage extends StatefulWidget {
  MainPage({required this.parseCountryName, required this.parseCountrySlug});

  // var parseCountry;
  List<String> parseCountryName;
  List<String> parseCountrySlug;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String dropDownValueCountry = 'Korea (South)';// 바뀔것 같은것은 변수화 시켜서 저장 해서 이용
  String dropDownValueMenu = 'Newest';
  int i = 0;
  // List<CountryDataCovid> parseCountryCovid = [];
  List<CovidStats> covidData = [];
  @override
  Widget build(BuildContext context) {

    // Future<List<CovidStats>> getCountryCovid(String countrySlug, String dropDownValueMenu) async {
    //   String countryDataCovidUrl =
    //       'https://api.covid19api.com/live/country/$countrySlug/status/confirmed/date/2020-03-21T13:13:30Z';
    //   final http.Response response = await http.get(Uri.parse(countryDataCovidUrl));
    //   final Iterable responseData = json.decode(response.body);
    //
    //   List<CovidStats> covidData = List.from(responseData.map((dataJson) => CovidStats.fromJson(dataJson)));
    //   covidData.forEach((data) {
    //     data.date = data.date.substring(0, 10);
    //   });
    //   if (dropDownValueMenu == 'Newest') {
    //     covidData.sort((b,a) {
    //       // return a.confirmed.compareTo(b.confirmed);
    //       return a.date.toLowerCase().compareTo(b.date.toLowerCase());
    //     });
    //   }
    //   else if (dropDownValueMenu == 'Oldest') {
    //     covidData.sort((a,b) {
    //       return a.date.toUpperCase().compareTo(b.date.toUpperCase());
    //     });//json parsing 부분 알기
    //   }
    //   else {
    //     covidData.sort((b,a) {
    //       return a.deaths.compareTo(b.deaths);
    //     });
    //   }
    //   return covidData;
    // }
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('covid'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 250.0,
              height: 50.0,
              margin: EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 5.0),
              ),
              child: const Center(
                child:  Text(
                  'COVID STATISTICS',
                  style:  const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Container(
              width: 250.0,
              height: 100.0,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 5.0),
              ),
              child: DropdownButton(
                  value: dropDownValueCountry,
                  isExpanded: true,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20.0
                  ),
                  onChanged: (String? newValue) {
                    setState(() {//어떠한 값을 가지고 잇다고 하고 state을 참조 데이터를 state에서 바꿔줘야한다 state가 변하면 여기서 data받아오는 것을 새롭게 한다 그러면 futur함수를 어디다 노아야 할지 생각해보자
                      //list가 state가 list자체도 하나의 상태이니깐
                      // getCountryCovid(widget.parseCountrySlug[widget.parseCountryName.indexOf(newValue!)], dropDownValueMenu).then((value) {
                        // covidData = value;
                        // }//! null 값 error null safety
                      // );//type이 안맞아
                      //future builder를 사용하면 이렇게 setState안에 넣어줘야 한다이것이 바뀌면 밑에 상태도 바뀐다 그러면 한번에 setState으로 묶어줘야지
                      dropDownValueCountry = newValue!;
                      //mvc패턴 역할의 완벽한 분리
                    });
                  },
                  items: widget.parseCountryName.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList()
              ),
            ),
            Align(
              // alignment: Alignment.centerRight,
              alignment: Alignment.centerRight,
              child: Container(
                width: 100.0,
                height: 30.0,
                margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 5.0),
                ),
                child: DropdownButton(
                    value: dropDownValueMenu,
                    isExpanded: true,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15.0
                    ),
                    onChanged: (String? newValue) {
                      setState(() {//하나가 바뀌면 다른 애들도 바뀐것을 인지 하지 않는 것이다
                        dropDownValueMenu = newValue!;
                      });
                    },
                    items: <String>['Oldest', 'Newest', 'Highest'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()
                ),
              ),
            ),
            FutureBuilder(
                future: getCountryCovid(widget.parseCountrySlug[widget.parseCountryName.indexOf(dropDownValueCountry)], dropDownValueMenu),
                builder: (BuildContext context, AsyncSnapshot<List<CovidStats>> snapshot) {
                  List<Widget> children;
                  if (snapshot.hasData) {
                    List<String> date = List.from(snapshot.data!.map((data) => data.date));
                    List<int> deaths = List.from(snapshot.data!.map((data) => data.deaths));
                    List<int> confirmed = List.from(snapshot.data!.map((data) => data.confirmed));
                    int maxConfirmed = confirmed.reduce((curr, next) => curr > next ? curr: next);
                    List<int> recovered = List.from(snapshot.data!.map((data) => data.recovered));
                    children = <Widget> [
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(8),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return DataPageDialog(date: date[index], deaths: deaths[index], confirmed: confirmed[index], recovered: recovered[index]);
                                  }));
                                },
                                child: Container(
                                  height: 30,
                                  color: Colors.purple,
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 8),
                                        width: 100,
                                        height: 20,
                                        color: Colors.blueGrey,
                                        child: Center(
                                          child: Text(date[index],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: CustomPaint(
                                          // size: Size(confirmed[index].toDouble() / minConfirmed + 20, 0),
                                          size: Size(250 * confirmed[index] / maxConfirmed.toDouble(), 0),
                                          // size: Size(50, 0),
                                          painter: MyPainter(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => const Divider(
                            height: 8,
                          ),
                        ),
                      ),
                    ];
                  }
                  else if (snapshot.hasError) {
                    print('error');
                    children = const <Widget>[
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Awaiting result...'),
                      )
                    ];
                  }
                  else {
                    print('else');
                    children = const <Widget>[
                      SizedBox(
                        child: CircularProgressIndicator(),
                        width: 60,
                        height: 60,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Awaiting result...'),
                      )
                    ];
                  }
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: children,
                    ),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
