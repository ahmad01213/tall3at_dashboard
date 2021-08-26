import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard/Models/Service.dart';

import 'package:dashboard/widgets/SizedBoxWidget.dart';
import 'package:dashboard/widgets/Texts.dart';
import 'package:dashboard/widgets/pagination.dart';
import 'package:dashboard/widgets/textfields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../DataProvider.dart';
import '../helpers.dart';

class Services extends StatefulWidget {

  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  DataProvider dataProvider;
  @override
  Widget build(BuildContext context) {
    if (dataProvider == null) {
      dataProvider = Provider.of(context);
      dataProvider.getServices(number: 1,size: 10);
    }
    return ListView(
      shrinkWrap: true,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Texts(
                title: "الطلعات",
                fSize: 40,
                color: Colors.black,
                weight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                Box(10),
                SizedBox(
                  width: 100,
                ),
                Container(
                    width: 400,
                    height: 60,
                    child: TextFields(
                      lable: "بحث",
                    ))
              ],
            )
          ],
        ),
        Box(40),
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
            itemCount: dataProvider.services.length,
            shrinkWrap: true,
            itemBuilder: (ctx, i) {
              return buildTableRow(i);
            }),
        Box(50),
      if(dataProvider.serviceCount>1)  Pagination(count:dataProvider.serviceCount ,onTap: (index){
          dataProvider.getServices(number: index,size: 10);
        },)
      ],
    );
  }

  buildTableRow(int i) {
    Service service = dataProvider.services[i];
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

class Check extends StatefulWidget {
  bool status;
  Function update;
  String id;

  Check({this.status, this.id,this.update});

  @override
  _CheckState createState() => _CheckState();
}
class _CheckState extends State<Check> {
  bool load = false;
  @override
  Widget build(BuildContext context) {
    return    Expanded(
      child: load
          ? Center(
        child: SpinKitRing(
          size: 30,
          color: mainColor,
          lineWidth: 5,
          duration: Duration(milliseconds: 700),
        ),
      )
          :  CupertinoSwitch(
        value: widget.status,

        onChanged: (bool value) async {
          print('welcome');
          setState(() {
            widget.status =!widget.status ;
            load = true;
          });
          widget.update(widget.status);
          load  = false;

        },
      ),);
  }
}

