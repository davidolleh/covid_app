import 'package:covid_app/controller/main_page.dart';
import 'package:covid_app/model/entity/country.dart';
import 'package:covid_app/model/entity/covid_stats.dart';
import 'package:flutter/material.dart';

import 'package:covid_app/view/covid_data_page.dart';
import 'package:covid_app/view/my_painter.dart';
// 필요한 데이터 countries
// TODO:: Loading 페이지 예시를 토대로 재구성 해보기
class MainPageView extends StatefulWidget {
  MainPageView({
    required this.countries,
    required this.dailyCovidStats,
    required this.order,
    required this.selectedCountry,
    required this.maxConfirmed,
    required this.controller,
    Key? key}) : super(key: key);

  List<Country> countries;
  List<CovidStats> dailyCovidStats;
  String order;
  Country selectedCountry;
  int maxConfirmed;
  final MainPageController controller;

  @override
  _MainPageViewState createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  // late CovidModel model;

  @override
  void initState() {
    super.initState();
    // model = widget.model;
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
                  value: widget.selectedCountry.country,
                  isExpanded: true,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20.0
                  ),
                  onChanged: (String? newValue) {
                    widget.controller.onChangeSelectCountry(newValue!);
                    // widget.controller.onFecthCovidStats();
                  },
                  // TODO:: Model에 맞게 items 값 수정함.
                  items: widget.countries.map((country) =>
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
                    value: widget.order,
                    isExpanded: true,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15.0
                    ),
                    onChanged: (String? newValue) {
                      widget.controller.onChangeSelectOrder(newValue!);
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
                itemCount: widget.dailyCovidStats.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return DataPageDialog(date: widget.dailyCovidStats[index].date, deaths: widget.dailyCovidStats[index].deaths, confirmed: widget.dailyCovidStats[index].confirmed, recovered: widget.dailyCovidStats[index].recovered);
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
                              child: Text(widget.dailyCovidStats[index].date,
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
                              size: Size(250 * widget.dailyCovidStats[index].confirmed / widget.maxConfirmed.toDouble(), 0),
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