import 'package:covid_app/model/covid_model.dart';
import 'package:flutter/material.dart';

import 'package:covid_app/view/covid_data_page.dart';
import 'package:covid_app/model/entity/covid_stats.dart';
import 'package:covid_app/model/repository/covid_repository.dart';
import 'package:covid_app/view/my_painter.dart';

// TODO:: Loading 페이지 예시를 토대로 재구성 해보기
class MainPage extends StatefulWidget {
  MainPage({required this.model});

  CovidModel model;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late CovidModel model;

  @override
  void initState() {
    super.initState();
    model = widget.model;
  }

  @override
  Widget build(BuildContext context) {
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
                  value: model.selectedCountry.country,
                  isExpanded: true,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20.0
                  ),
                  // onChanged: (String? newValue) {
                  //   setState(() {//어떠한 값을 가지고 잇다고 하고 state을 참조 데이터를 state에서 바꿔줘야한다 state가 변하면 여기서 data받아오는 것을 새롭게 한다 그러면 futur함수를 어디다 노아야 할지 생각해보자
                  //     //list가 state가 list자체도 하나의 상태이니깐
                  //     // getCountryCovid(widget.parseCountrySlug[widget.parseCountryName.indexOf(newValue!)], dropDownValueMenu).then((value) {
                  //       // covidData = value;
                  //       // }//! null 값 error null safety
                  //     // );//type이 안맞아
                  //     //future builder를 사용하면 이렇게 setState안에 넣어줘야 한다이것이 바뀌면 밑에 상태도 바뀐다 그러면 한번에 setState으로 묶어줘야지
                  //     dropdownData.dropDownCountry = newValue!;
                  //     //mvc패턴 역할의 완벽한 분리
                  //   });
                  // },
                  onChanged: (String? newValue) {
                    setState(() {
                      model.changeSelectCountry(model.selectedCountry, newValue!);
                      // model.selectedCountry = model.countries[model.countries.indexWhere((country) => country.country == newValue)]!;//이것은 내가 model에서 setter를 정의하면 할 수 있는 행동
                      model.fetchCovidSats();
                    });
                  },
                  // TODO:: Model에 맞게 items 값 수정함.
                  items: model.countries.map((country) =>
                              DropdownMenuItem(
                                  value: country.country,
                                  child: Text(country.country)
                              ))
                      .toList()
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
                    value: model.order,
                    isExpanded: true,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15.0
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        // dropdownData.selectMenu(newValue!);
                        //지금 변하는 것을 view자리에 햇는ㄴ데 setstate자리 자체를 controlloer로 옮기자
                        // model.selectCountry(model., newValue)
                        model.changeSelectOrder(newValue!);
                        model.orderCovidStats();
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
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                shrinkWrap: true,
                itemCount: model.dailyCovidStats.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return DataPageDialog(date: model.dailyCovidStats[index].date, deaths: model.dailyCovidStats[index].deaths, confirmed: model.dailyCovidStats[index].confirmed, recovered: model.dailyCovidStats[index].recovered);
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
                              child: Text(model.dailyCovidStats[index].date,
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
                              size: Size(250 * model.dailyCovidStats[index].confirmed / model.maxConfirmed.toDouble(), 0),
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
            // TODO:: 지금 바로 실행하면 FutureBuilder 자체는 에러뜸. 이는 Model 구현 사항을 남겨두었기 때문임.
            // TODO:: FutureBuilder는 개인적으로 지금 단계에서 쓸 위젯은 아닌듯.
            // TODO:: 그냥 Listview에 값 넘겨주는 식으로 구현해보기.
            // FutureBuilder(
            //     // TODO:: Model에 맞춰 future 값 수정
            //     future: model.repository.getCountryCovid(
            //         model.countries[model.countries.indexWhere((country) => country == model.selectedCountry)].slug,
            //         model.order
            //     ),
            //     builder: (BuildContext context, AsyncSnapshot<List<CovidStats>> snapshot) {
            //       List<Widget> children;
            //       if (snapshot.hasData) {
            //         List<int> confirmed = List.from(snapshot.data!.map((e) => e.confirmed));
            //         int maxConfirmed = confirmed.reduce((curr, next) => curr > next ? curr : next);
            //         children = <Widget> [
            //           Expanded(
            //             child: ListView.separated(
            //               padding: const EdgeInsets.all(8),
            //               shrinkWrap: true,
            //               itemCount: snapshot.data!.length,
            //               itemBuilder: (BuildContext context, int index) {
            //                 return GestureDetector(
            //                     onTap: () {
            //                       Navigator.push(context, MaterialPageRoute(builder: (context) {
            //                         return DataPageDialog(date: snapshot.data![index].date, deaths: snapshot.data![index].deaths, confirmed: snapshot.data![index].confirmed, recovered: snapshot.data![index].recovered);
            //                       }));
            //                     },
            //                     child: Container(
            //                       height: 30,
            //                       color: Colors.purple,
            //                       child: Row(
            //                         children: [
            //                           Container(
            //                             margin: const EdgeInsets.only(left: 8),
            //                             width: 100,
            //                             height: 20,
            //                             color: Colors.blueGrey,
            //                             child: Center(
            //                               child: Text(snapshot.data![index].date,
            //                                 textAlign: TextAlign.center,
            //                                 style: const TextStyle(
            //                                   color: Colors.white,
            //                                 ),
            //                               ),
            //                             ),
            //                           ),
            //                           Center(
            //                             child: CustomPaint(
            //                               // size: Size(confirmed[index].toDouble() / minConfirmed + 20, 0),
            //                               size: Size(250 * snapshot.data![index].confirmed / maxConfirmed.toDouble(), 0),
            //                               // size: Size(50, 0),
            //                               painter: MyPainter(),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                 );
            //               },
            //               separatorBuilder: (BuildContext context, int index) => const Divider(
            //                 height: 8,
            //               ),
            //             ),
            //           ),
            //         ];
            //       }
            //       else if (snapshot.hasError) {
            //         print('error');
            //         children = const <Widget>[
            //           const Icon(
            //             Icons.error_outline,
            //             color: Colors.red,
            //             size: 60,
            //           ),
            //           Padding(
            //             padding: EdgeInsets.only(top: 16),
            //             child: Text('Awaiting result...'),
            //           )
            //         ];
            //       }
            //       else {
            //         print('else');
            //         children = const <Widget>[
            //           SizedBox(
            //             child: CircularProgressIndicator(),
            //             width: 60,
            //             height: 60,
            //           ),
            //           Padding(
            //             padding: EdgeInsets.only(top: 16),
            //             child: Text('Awaiting result...'),
            //           )
            //         ];
            //       }
            //       return Expanded(
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: children,
            //         ),
            //       );
            //     },
            // ),
          ],
        ),
      ),
    );
  }
}