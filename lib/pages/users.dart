import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard/Models/User.dart';
import 'package:dashboard/widgets/Buttons.dart';
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

class Users extends StatefulWidget {

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  DataProvider dataProvider;
  @override
  Widget build(BuildContext context) {
    if (dataProvider == null) {
      dataProvider = Provider.of(context);
      dataProvider.getUsers(number: 1,size: 10);
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
                title: "المستخدمين",
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
          padding: EdgeInsets.all(20),
          color: greyColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Texts(
                    title: "م",
                    fSize: 17,
                    weight: FontWeight.bold,
                    color: Colors.black,
                  )),
              Expanded(
                  child: Texts(
                    title: "صورة",
                    fSize: 17,
                    weight: FontWeight.bold,
                    color: Colors.black,
                  )),
              Expanded(
                  child: Texts(
                    title: "اسم",
                    fSize: 17,
                    color: Colors.black,
                    weight: FontWeight.bold,
                  )),
              Expanded(
                  child: Texts(
                    title: "البريد الالكتروني",
                    fSize: 17,
                    weight: FontWeight.bold,
                    color: Colors.black,
                  )),
              Expanded(
                  child: Texts(
                    title: "الهاتف",
                    fSize: 17,
                    weight: FontWeight.bold,
                    color: Colors.black,
                  )),

            ],
          ),
        ),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: dataProvider.users.length,
            shrinkWrap: true,
            itemBuilder: (ctx, i) {
              return buildTableRow(dataProvider.users[i], i);
            }),
        Box(50),
        Pagination(count:dataProvider.userCount ,onTap: (index){
          dataProvider.getUsers(number: index,size: 10);
        },)
      ],
    );
  }

  buildTableRow(User user, index) => Container(
    padding: EdgeInsets.all(10),
    color: isOdd(index) ? greyColor : Colors.white,
    child: Row(
      children: [
        Expanded(
            child: Texts(
              title: user.id.toString(),
              fSize: 17,
              color: Colors.black,
            )),
        Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: filesUrl + user.profileImage,
                    height: 40,
                    width: 40,
                    fit: BoxFit.fill,
                  ),
                )
              ],
            )),
        Expanded(
            child: Texts(
              title: user.fullName,
              fSize: 17,
              color: Colors.black,
            )),
        Expanded(
            child: Texts(
              title: user.email.toString(),
              fSize: 17,
              color: Colors.black,
            )),
        Expanded(
            child: Texts(
              title: user.phone.toString(),
              fSize: 17,
              color: Colors.black,
            )),



      ],
    ),
  );

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

