import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard/Models/Comment.dart';
import 'package:dashboard/Models/RoundContainer.dart';
import 'package:dashboard/Models/Service.dart';
import 'package:dashboard/Models/User.dart';
import 'package:dashboard/widgets/RatingBar.dart';
import 'package:dashboard/widgets/SizedBoxWidget.dart';
import 'package:dashboard/widgets/Texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../../helpers.dart';
import 'package:http/http.dart' as http;

class OrganizerDetail extends StatefulWidget {
  User org;
  OrganizerDetail(this.org);
  @override
  State<OrganizerDetail> createState() => _OrganizerDetailState();
}

class _OrganizerDetailState extends State<OrganizerDetail>  with SingleTickerProviderStateMixin{
  TabController _tabController;

  @override
  void initState() {

    super.initState();

  }
  List<Service> services = [];
  List<Comment> comments = [];
  getOrgServices() async {
    final url = "$baseUrl/dashboard/get-org-services";
    final body = {
      'id':widget.org.id.toString()
    };
    final response = await http.post(Uri.parse(url),body: body);
    print(response.body);
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      data['services'].forEach((element) {
        services.add(Service.fromJson(element));
      });
      data['comments'].forEach((element) {
        print(element);
        comments.add(Comment.fromJson(element));
      });
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_tabController == null) {
      _tabController =
          TabController(length: 3, initialIndex: 0, vsync: this);
      getOrgServices();
    }
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Texts(
              title: widget.org.fullName,
              fSize: 40,
              color: Colors.black,
              weight: FontWeight.w500,
            ),
          ),
           Container(
             height: 70,
             width: 800,
             alignment: Alignment.topCenter,
             child: TabBar(
              onTap: (index){
                setState(() {

                });
              },
              labelColor: Colors.black,
              controller: _tabController,
              indicatorColor: mainColor,
              tabs: <Widget>[
                new Tab(
                  text:'التفاصيل',
                ),
                new Tab(
                  text:'المراجعات',
                ),
                new Tab(
                  text: "الطلعات",
                ),
              ],
          ),
           ),
          SizedBox(height: 70,),
          if(_tabController.index==0)  Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(filesUrl+widget.org.profileImage,height: 200,width: 300,fit: BoxFit.cover,
                ),
                SizedBox(width: 50,),
                Row(
                  children: [
                    Column(
                      children: [
                        textItem("الاسم", mainColor),
                        textItem("نبذة مختصرة", mainColor),
                        textItem("اسم المستخدم ", mainColor),
                        textItem("البريد الالكتروني ", mainColor),
                        textItem("رقم الهاتف", mainColor),
                        textItem("رقم الايبان", mainColor),
                        textItem("اسم البنك ", mainColor),
                        textItem("الدولة", mainColor),
                        textItem("المدينة", mainColor),
                      ],
                    ),
                    SizedBox(width: 50,),
                    Column(
                      children: [
                        textItem(widget.org.fullName, Colors.black),
                        textItem(widget.org.aboutText, Colors.black),
                        textItem(widget.org.username, Colors.black),
                        textItem(widget.org.email, Colors.black),
                        textItem(widget.org.phone, Colors.black),
                        textItem(widget.org.IbanNumber, Colors.black),
                        textItem(widget.org.bank, Colors.black),
                        textItem(widget.org.country, Colors.black),
                        textItem(widget.org.city, Colors.black),
                      ],
                    ),

                  ],
                )
              ],
            ),
          ),
          if(_tabController.index==1)  Container(
              height: 400,
              child: CommentList(comments: comments,),
              color:Colors.green),
          if(_tabController.index==2)  Expanded(
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
                      Expanded(
                          child: Texts(
                            title: "إجراء",
                            fSize: 17,
                            align: TextAlign.start,

                            weight: FontWeight.bold,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount:services.length,
                      shrinkWrap: true,
                      itemBuilder: (ctx, i) {
                        return buildTableRow(i);
                      }),
                ),
                Box(50),
              ],
            ),
          ),

        ],
      ),
    );
  }



 textItem(title,color){
    return Column(
      children: [
        Container(
          width: 250,
          child: Texts(
            title: title ?? "",
            fSize: 16,
            color: color,
          ),
        ),
        SizedBox(height: 10,)
      ],
    );
 }
  buildTableRow(int i) {
    Service service = services[i];
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
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.remove_red_eye),
                iconSize: 30,
                color: Colors.blue,
                onPressed: () {
                  changeTo.value = OrganizerDetail(user);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

}


class CommentList extends StatelessWidget {
  final scrollDirection;
  List<Comment> comments ;
  CommentList({this.scrollDirection = Axis.horizontal,this.comments});
  @override
  Widget build(BuildContext context) {
    return comments.isEmpty? Texts(title:"لاتوجد مراجعات",fSize: 15,):Container(
      height: 700,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount:comments.length,
        padding:  EdgeInsets.only(left: 13, right: 13,bottom:(scrollDirection == Axis.vertical)? 150:0),
        scrollDirection: scrollDirection,
        itemBuilder: (context, index) {
          final comment = comments[index];
          return Container(
            height: 210,
            width: screenWidth / 1.1,
            child: RoundContainer(
              hMargin: 10,
              vMargin: 10,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Texts(
                            title: comment.userName,
                            fSize: 12,
                            color: mainColor,
                            weight: FontWeight.bold,
                          ),
                          Box(20),
                          // Texts(
                          //   title: comment.serviceName,
                          //   fSize: 18,
                          //   weight: FontWeight.bold,
                          //   color: Colors.black54,
                          // ),
                        ],
                      ),
                      Texts(
                        title: comment.createdAt,
                        fSize: 12,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  Box(23),
                  Texts(
                    title:comment.comment,
                    fSize: 14,
                    lines: 4,
                    weight: FontWeight.w300,
                    color: Colors.grey,
                  ),
                  Box(10),
                  RatingBarWidget(fillColor: Colors.orangeAccent,ignorGesture: true,ratingValue: comment.rate.toDouble(),itemSize: 15,emptColor: Colors.grey,)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


// https://portal.hostgator.com/hosting/shared/4196564/dashboard

// 34243310
