import 'package:dashboard/helpers.dart';
import 'package:dashboard/pages/categories.dart';
import 'package:dashboard/pages/home.dart';
import 'package:dashboard/pages/Organizers/organizers.dart';
import 'package:dashboard/pages/services.dart';
import 'package:dashboard/pages/users.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        automaticallyImplyLeading: false,
        elevation: 2,
      ),
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Container(
            width: 300,
            margin: EdgeInsets.all(0),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
                color: mainColor, borderRadius: BorderRadius.circular(0)),
            child: Column(
              children: [
                SizedBox(height: 30,),
                buildSideItem("الرئيسية", 0,Icons.home_filled,(){
                  changeTo.value = Home();
                }),
              // final pages = [Home(updatePage), Organizers(), Users(), Categories(), Services()];

          buildSideItem("منسقي الطلعات", 1,Icons.business_center,
                  (){
                changeTo.value = Organizers();
              }
          ),
                buildSideItem("المستخدمين", 2,Icons.supervised_user_circle_outlined,(){
                  changeTo.value = Users();
                }),
                buildSideItem("الفئات", 3,Icons.category_outlined,(){
                  changeTo.value = Categories();
                }),
                buildSideItem("الطلعات", 4,Icons.place_outlined,(){
                  changeTo.value = Services();
                }),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width-400,
            margin: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(

                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child:
            ValueListenableBuilder(
              valueListenable: changeTo,
              builder: (context, child, widget) {
                return child;
              },
            ),


          )

        ],
      ),
    );
  }




  int selectedIndex = 0;


  buildSideItem(title, index,icon,onPress) => MaterialButton(
    onPressed: (){
      onPress();
    },
    child: Container(
          decoration: BoxDecoration(
              color:selectedIndex==index? Colors.white.withOpacity(0.3):Colors.transparent, borderRadius: BorderRadius.circular(10)),
          height: 50,
          width: 260,
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
          child: Row(
            children: [
              Icon(icon,size: 20,color: Colors.white,),
              SizedBox(width: 10,),
              Text(
                title,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
  );
}
