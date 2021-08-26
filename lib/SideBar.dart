import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(child: Container(
      width: 300,
      color: Colors.red,
    ),);
  }
}
