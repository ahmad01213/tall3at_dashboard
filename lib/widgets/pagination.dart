import 'package:dashboard/helpers.dart';
import 'package:dashboard/widgets/Texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Pagination extends StatefulWidget {
  int count;
   Function onTap;
  Pagination({this.count,this.onTap});

  @override
  _PaginationState createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  int currentIndex = 1;

  int pages = 0;
  @override
  void initState() {
    pages = (widget.count / 10).ceil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      child: ListView.builder(
          itemCount: pages>1?pages:0,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (ctx, i) {
            return InkWell(
              onTap: () {
                setState(() {
                  currentIndex = i + 1;
                });
                widget.onTap(currentIndex);

              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color:currentIndex ==i+1?mainColor: Colors.white,
                  ),
                  child: Center(
                      child: Texts(
                        fSize: 14,
                    title: (i + 1).toString(),
                        color: currentIndex ==i+1?Colors.white:Colors.black,
                  )),
                ),
              ),
            );
          }),
    );
  }
}
