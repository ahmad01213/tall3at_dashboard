import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard/Models/Service.dart';
import 'package:dashboard/pages/services.dart';
import 'package:dashboard/pages/users.dart';
import 'package:dashboard/widgets/SizedBoxWidget.dart';
import 'package:dashboard/widgets/Texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../DataProvider.dart';
import '../helpers.dart';
import 'Organizers/organizers.dart';
import 'categories.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];

  DataProvider dataProvider;

  @override
  Widget build(BuildContext context) {
    if (dataProvider == null) {
      dataProvider = Provider.of(context);
      dataProvider.getHomeData();
    }
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Texts(
            title: "الرئيسية",
            fSize: 40,
            color: Colors.black,
            weight: FontWeight.w500,
          ),
        ),
        Box(10),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  changeTo.value = Categories();

                },
                child: Container(
                  color: Color(0xFF00cec9),
                  height: 150,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.category_outlined,
                        size: 100,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Texts(
                            title: dataProvider.homeCounts['categoryCount'],
                            fSize: 33,
                            color: Colors.white,
                            align: TextAlign.center,
                            weight: FontWeight.bold,
                          ),
                          Box(5),
                          Texts(
                            title: "الفئات",
                            align: TextAlign.center,
                            fSize: 25,
                            color: Colors.white,
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  changeTo.value = Services()
                  ;
                },
                child: Container(
                  color: Color(0xFFd63031),
                  height: 150,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.timelapse_rounded,
                        size: 100,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Texts(
                            title: dataProvider.homeCounts['serviceCount'],
                            fSize: 27,
                            color: Colors.white,
                            align: TextAlign.center,
                            weight: FontWeight.bold,
                          ),
                          Box(5),
                          Texts(
                            title: "الطلعات",
                            align: TextAlign.center,
                            fSize: 25,
                            color: Colors.white,
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  changeTo.value = Organizers();
                },
                child: Container(
                  color: Color(0xFF00b894),
                  height: 150,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.business_center,
                        size: 100,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Texts(
                            title: dataProvider.homeCounts['orgCount'],
                            fSize: 33,
                            color: Colors.white,
                            align: TextAlign.center,
                            weight: FontWeight.bold,
                          ),
                          Box(4),
                          Texts(
                            title: "المنسقين",
                            align: TextAlign.center,
                            fSize: 25,
                            color: Colors.white,
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  changeTo.value = Users();
                },
                child: Container(
                  color: Color(0xFFf7b731),
                  height: 150,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.people_alt_rounded,
                        size: 100,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Texts(
                            title: dataProvider.homeCounts['userCount'],
                            fSize: 33,
                            color: Colors.white,
                            align: TextAlign.center,
                            weight: FontWeight.bold,
                          ),
                          Box(5),
                          Texts(
                            title: "الأعضاء",
                            align: TextAlign.center,
                            fSize: 25,
                            color: Colors.white,
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        Box(20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                height: 500,
                child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    // Chart title
                    title: ChartTitle(text: ''),

                    // Enable legend
                    legend: Legend(isVisible: false),
                    // Enable tooltip
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ChartSeries<_SalesData, String>>[
                      ColumnSeries<_SalesData, String>(
                          color: Color(0xFF016FE6),
                          dataSource: data,
                          xValueMapper: (_SalesData sales, _) => sales.year,
                          yValueMapper: (_SalesData sales, _) => sales.sales,
                          name: 'Sales',
                          // Enable data label
                          dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                          ))
                    ]),
              ),
            ),
            Expanded(
                child: Card(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    color: greyColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Texts(
                          title: "صورة",
                          fSize: 17,
                          align: TextAlign.start,
                          weight: FontWeight.bold,
                          color: Colors.black,
                        )),
                        Expanded(
                            child: Texts(
                          title: "اسم",
                          align: TextAlign.start,
                          fSize: 17,
                          color: Colors.black,
                          weight: FontWeight.bold,
                        )),
                        Expanded(
                            child: Texts(
                          title: "السعر",
                          fSize: 17,
                          align: TextAlign.start,
                          weight: FontWeight.bold,
                          color: Colors.black,
                        )),
                        Expanded(
                            child: Texts(
                          title: "التاريخ",
                          fSize: 17,
                          align: TextAlign.start,
                          weight: FontWeight.bold,
                          color: Colors.black,
                        )),
                        // Expanded(
                        //     child: Texts(
                        //       title: "إجراء",
                        //       fSize: 17,
                        //       align: TextAlign.start,
                        //
                        //       weight: FontWeight.bold,
                        //       color: Colors.black,
                        //     )),
                      ],
                    ),
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: dataProvider.homeServices.length,
                      shrinkWrap: true,
                      itemBuilder: (ctx, i) {
                        return buildTableRow(i);
                      })
                ],
              ),
            )),
          ],
        )
      ],
    );
  }

  buildTableRow(int i) {
    Service service = dataProvider.homeServices[i];
    return Container(
      padding: EdgeInsets.all(10),
      color: isOdd(i) ? greyColor : Colors.white,
      child: Row(
        children: [
          Expanded(
              child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: filesUrl + service.image,
                  height: 40,
                  width: 40,
                  fit: BoxFit.fill,
                ),
              )
            ],
          )),
          Expanded(
              child: Texts(
            title: service.name,
            align: TextAlign.start,
            fSize: 17,
            color: Colors.black,
          )),
          Expanded(
              child: Texts(
            align: TextAlign.start,
            title: service.cost.toString() + " ريال",
            fSize: 17,
            color: Colors.black,
          )),
          Expanded(
              child: Texts(
            align: TextAlign.start,
            title: service.eventDate,
            fSize: 17,
            color: Colors.black,
          )),
          // Expanded(
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         Icon(
          //           Icons.edit_outlined,
          //           color: Colors.blue,
          //           size: 20,
          //         ),
          //         SizedBox(
          //           width: 20,
          //         ),
          //         Icon(
          //           Icons.delete_outline,
          //           color: Colors.red,
          //           size: 20,
          //         ),
          //       ],
          //     )),
        ],
      ),
    );
  }

  bool isOdd(int num) {
    int i = 0;
    bool odd = false;

    while (i != num) {
      odd = !odd;
      i = i + 1;
    }

    return odd;
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
