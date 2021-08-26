import 'dart:html';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard/Models/Category.dart';
import 'package:dashboard/widgets/Buttons.dart';
import 'package:dashboard/widgets/SizedBoxWidget.dart';
import 'package:dashboard/widgets/Texts.dart';
import 'package:dashboard/widgets/pagination.dart';
import 'package:dashboard/widgets/textfields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:provider/provider.dart';
import '../DataProvider.dart';
import '../helpers.dart';
class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
//   html.File pickedImage;
//
String name = '';
Uint8List imageBytes ;
  getImage() async {
    Uint8List bytesFromPicker =
    await ImagePickerWeb.getImage(outputType: ImageType.bytes);

    setState(() {
      imageBytes = bytesFromPicker;

    });

  }



  DataProvider dataProvider;
  @override
  Widget build(BuildContext context) {
    if (dataProvider == null) {
      dataProvider = Provider.of(context);
      dataProvider.getCategories(number: 1, size: 10);
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
                title: "الفئات",
                fSize: 40,
                color: Colors.black,
                weight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                Buttons(
                  title: "+ إضافة",
                  bgColor: mainColor,
                  onPressed: () {
                    // pushPage(context: context,page: SamplePage());
                    showGeneralDialog(
                        barrierColor: Colors.black.withOpacity(0.5),
                        transitionBuilder: (context, a1, a2, widget) {
                          final curvedValue =
                              Curves.easeIn.transform(a1.value) - 1.0;
                          return Transform(
                            transform: Matrix4.translationValues(
                                0.0, curvedValue * 500, 0.0),
                            child: Opacity(
                              opacity: a1.value,
                              child: StatefulBuilder(
                                builder:(ctx,setState)=> AlertDialog(
                                  shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0)),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('إضافة فئة'),
                                      IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            size: 33,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {
                                            pop(context);
                                          })
                                    ],
                                  ),
                                  content: Container(
                                    width: 600,
                                    height: 300,
                                    child: Card(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: TextFields(
                                              horizontalMargin: 20,
                                              onChange: (v){
                                                name = v.toString();
                                              },
                                              lable: "اسم الفئة",
                                            ),
                                          ),
                                          Container(
                                            height: 100,
                                            margin: EdgeInsets.symmetric(horizontal: 40),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Texts(
                                                      title: "اختر صورة",
                                                      fSize: 18,
                                                      weight: FontWeight.bold,
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                       await getImage();
                                                       setState((){});

                                                      },
                                                      child: imageBytes != null
                                                          ? Center(
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child: Image.memory(
                                                                  imageBytes,
                                                                  height: 130,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              ),
                                                            )
                                                          : Container(
                                                              height: 100,
                                                              width: 100,
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      20),
                                                              decoration:
                                                                  BoxDecoration(
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        width:
                                                                            0.5,
                                                                        color:
                                                                            mainColor,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              100)),
                                                              child: Image.asset(
                                                                "assets/images/file-upload.png",
                                                                height: 45,
                                                                width: 53,
                                                              ),
                                                            ),
                                                    ),
                                                  ],
                                                ),
                                                Buttons(
                                                  title: "حفظ",
                                                  radius: 10,
                                                  fSize: 18,
                                                  width: 130,
                                                  onPressed: (){
                                                    dataProvider.addCategory(name: name
                                                        ,context: context,image: imageBytes);
                                                  },
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        transitionDuration: Duration(milliseconds: 300),
                        barrierDismissible: true,
                        barrierLabel: '',
                        context: context,
                        pageBuilder: (context, animation1, animation2) {});
                  },
                  width: 200,
                  radius: 10,
                  fSize: 20,
                ),
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
                title: "إجراء",
                fSize: 17,
                weight: FontWeight.bold,
                color: Colors.black,
              )),
            ],
          ),
        ),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: dataProvider.categories.length,
            shrinkWrap: true,
            itemBuilder: (ctx, i) {
              return buildTableRow(dataProvider.categories[i], i);
            }),
        Box(50),
        Pagination(
          count: dataProvider.categoryCount,
          onTap: (index) {
            dataProvider.getCategories(number: index, size: 10);
          },
        )
      ],
    );
  }

  buildTableRow(Category category, index) => Container(
        padding: EdgeInsets.all(10),
        color: isOdd(index) ? greyColor : Colors.white,
        child: Row(
          children: [
            Expanded(
                child: Texts(
              title: category.id.toString(),
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
                    imageUrl: filesUrl + category.image,
                    height: 40,
                    width: 40,
                    fit: BoxFit.fill,
                  ),
                )
              ],
            )),
            Expanded(
                child: Texts(
              title: category.name,
              fSize: 17,
              color: Colors.black,
            )),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.edit_outlined,
                    color: Colors.blue,
                    size: 20,
                  ),
                  onPressed: (){
                    imageBytes=null;
                    name=null;
                    showGeneralDialog(
                        barrierColor: Colors.black.withOpacity(0.5),
                        transitionBuilder: (context, a1, a2, widget) {
                          final curvedValue =
                              Curves.easeIn.transform(a1.value) - 1.0;
                          return Transform(
                            transform: Matrix4.translationValues(
                                0.0, curvedValue * 500, 0.0),
                            child: Opacity(
                              opacity: a1.value,
                              child: StatefulBuilder(
                                builder:(ctx,setState)=> AlertDialog(
                                  shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0)),
                                  title: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('إضافة فئة'),
                                      IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            size: 33,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {
                                            pop(context);
                                          })
                                    ],
                                  ),
                                  content: Container(
                                    width: 600,
                                    height: 300,
                                    child: Card(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: TextFields(
                                              horizontalMargin: 20,
                                              initialValue: category.name,
                                              onChange: (v){
                                                name = v.toString();
                                              },
                                              lable: "اسم الفئة",
                                            ),
                                          ),
                                          Container(
                                            height: 100,
                                            margin: EdgeInsets.symmetric(horizontal: 40),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Texts(
                                                      title: "اختر صورة",
                                                      fSize: 18,
                                                      weight: FontWeight.bold,
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        await getImage();
                                                        setState((){});

                                                      },
                                                      child: imageBytes != null
                                                          ? Center(
                                                        child: ClipRRect(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              10),
                                                          child: Image.memory(
                                                            imageBytes,
                                                            height: 130,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      )
                                                          : Center(
                                                        child: ClipRRect(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              10),
                                                          child: Image.network(
                                                            filesUrl+category.image,
                                                            height: 130,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Buttons(
                                                  title: "حفظ",
                                                  radius: 10,
                                                  fSize: 18,
                                                  width: 130,
                                                  onPressed: (){
                                                    dataProvider.editCategory(category.id.toString(),name: name
                                                        ,context: context,image: imageBytes);
                                                  },
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        transitionDuration: Duration(milliseconds: 300),
                        barrierDismissible: true,
                        barrierLabel: '',
                        context: context,
                        pageBuilder: (context, animation1, animation2) {});
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 20,
                ),
              ],
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

  Check({this.status, this.id, this.update});

  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {
  bool load = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: load
          ? Center(
              child: SpinKitRing(
                size: 30,
                color: mainColor,
                lineWidth: 5,
                duration: Duration(milliseconds: 700),
              ),
            )
          : CupertinoSwitch(
              value: widget.status,
              onChanged: (bool value) async {
                print('welcome');
                setState(() {
                  widget.status = !widget.status;
                  load = true;
                });
                widget.update(widget.status);
                load = false;
              },
            ),
    );
  }
}
