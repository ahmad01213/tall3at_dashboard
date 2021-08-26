import 'package:another_flushbar/flushbar.dart';
import 'package:dashboard/Models/User.dart';
import 'package:dashboard/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

pushPage({context, page}) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}

var scaffoldKey = GlobalKey<ScaffoldState>();


User user = User();
final count =
ValueNotifier<int>(0);
String token;
String isFirstLaunch;

saveToken() {
  final storage = new FlutterSecureStorage();
  storage.write(key: 'token', value: token);
}

saveValue(key, value) {
  final storage = new FlutterSecureStorage();
  storage.write(key: key, value: value);
}

isRegistered() {
  return token != null;
}

showMessage({context, msg, color=Colors.green})=> Flushbar(
  flushbarPosition: FlushbarPosition.TOP,
  message: msg,
  backgroundColor:color ,
  duration: Duration(seconds: 3),
).show(context);


signOut({ctx, page}) async {
  final storage = new FlutterSecureStorage();
  token = null;
  await storage.delete(key: "token");
  replacePage(context: ctx, page: page);
}

isFirst() {
  return isFirstLaunch == null;
}
readToken() async {
  final storage = new FlutterSecureStorage();
  token = await storage.read(key: "token");
  isFirstLaunch = await storage.read(key: "first");
  print("token : $token");
}

replacePage({context, page}) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => page));
}

final defaultShadow = BoxShadow(
  color: Colors.black.withOpacity(0.1),
  spreadRadius: 1,
  blurRadius: 1,
  offset: Offset(0, 1), // changes position of shadow
);

pop(context) {
  Navigator.of(context).pop();
}

final loginbaseUrl = "appwe";
final baseUrl = "https://appweb.website/opendayapi/public/api";
final filesUrl = "https://appweb.website/opendayapi/public/uploads/";
final changeTo = ValueNotifier<Widget>(Home());
String userRole = 'user';
double screenWidth;
double screenHight;

bool isTablet() {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  return data.size.shortestSide > 600;
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

const Color mainColor = Color(0xFF00B5B8);
const secondColor = Color(0xFFFCDA00);
const textColor = Color(0xFF343A40);
const greyColor =  Color(0x1A959292);





