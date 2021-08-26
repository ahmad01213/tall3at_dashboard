import 'dart:convert';
import 'dart:typed_data';
import 'package:dashboard/Models/Category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

import 'package:universal_io/io.dart';
import 'Models/Service.dart';
import 'Models/User.dart';
import 'helpers.dart';
class DataProvider extends ChangeNotifier{
  bool loading = false;
  login({params ,context}) async {
    loading = true;
    var jsoMap = Map();

    notifyListeners();
    final url = "$baseUrl/auth/login";
    final response = await http.post(Uri.parse(url), body: params);
    print(response.body);
    if (response.statusCode == 200) {
      showMessage(context: context,msg: "البريد الالكتروني او كلمة المرور غير صحيحة",color: Colors.red);
      checkAuthintication(response, context);
    } else {
      showMessage(context: context,msg: "البريد الالكتروني او كلمة المرور غير صحيحة",color: Colors.red);
    }
    loading = false;
    notifyListeners();
  }

  checkAuthintication(response, context) async {
    final data = jsonDecode(response.body);
    token = "Bearer " + data["token"];
    user = User.fromJson(data["user_data"]);
    print(user.Role);
    // await saveToken();
    if (user.Role == 'admin') {
      Navigator.of(context).pushNamed('/home');
    } else {
      showMessage(context: context,msg: "ليس لديك صلاحية للدخول",color: Colors.red);
    }
  }


  Map<String,String> homeCounts = {
    "categoryCount":"",
    "serviceCount":"",
    "userCount":"",
    "orgCount": "",
  };
  List<Service> homeServices = [];
  getHomeData() async {
    final url = "$baseUrl/dashboard/get-home";
    final response = await http.post(Uri.parse(url));
    print(response.body);
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      homeServices = [];
      homeCounts = {
        "categoryCount": data["categoryCount"].toString(),
        "serviceCount":data["serviceCount"].toString(),
        "userCount": data["userCount"].toString(),
        "orgCount": data["orgCount"].toString(),
      };
      data['services'].forEach((element) {
        homeServices.add(Service.fromJson(element));
      });
    }
    notifyListeners();
  }

  List<User> organizers = [];
  int orgCount = 0;
  getOrganizers({number,size}) async {
    var params = {
      'number':number.toString(),
      'size':size.toString(),
    };
    final url = "$baseUrl/dashboard/get-organizers";
    final response = await http.post(Uri.parse(url), body: params);
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      organizers = [];
      data['data'].forEach((element) {
        organizers.add(User.fromJson(element));
      });
      orgCount = data['size'];
      print(orgCount);
    } else {
    }
    notifyListeners();
  }

  List<User> users = [];
  int userCount = 0;
  getUsers({number,size}) async {
    var params = {
      'number':number.toString(),
      'size':size.toString(),
    };
    final url = "$baseUrl/dashboard/get-users";
    final response = await http.post(Uri.parse(url), body: params);
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      users = [];
      data['data'].forEach((element) {
        users.add(User.fromJson(element));
      });
      userCount = data['size'];
    } else {
    }
    notifyListeners();
  }

  List<Service> services = [];
  int serviceCount = 0;
  getServices({number,size}) async {
    var params = {
      'number':number.toString(),
      'size':size.toString(),
    };
    final url = "$baseUrl/dashboard/get-services";
    final response = await http.post(Uri.parse(url), body: params);
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      services = [];
      data['data'].forEach((element) {
        services.add(Service.fromJson(element));
      });
      serviceCount  = data['size'];
    } else {
    }
    notifyListeners();
  }

  List<Category> categories = [];
  int categoryCount = 0;
  getCategories({number=1,size=10}) async {
    var params = {
      'number':number.toString(),
      'size':size.toString(),
    };
    final url = "$baseUrl/dashboard/get-categories";
    final response = await http.post(Uri.parse(url), body: params);
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      categories = [];
      data['data'].forEach((element) {
        categories.add(Category.fromJson(element));
      });
      serviceCount  = data['size'];
    } else {
    }
    notifyListeners();
  }

  updateOrganizer({id,status,context}) async {
    var params = {
      'status':status.toString(),
      'id':id.toString(),
    };
    final url = "$baseUrl/dashboard/update-organizer";
    final response = await http.post(Uri.parse(url), body: params);
    if (response.statusCode == 200) {
      showMessage(context: context,msg: "تم التحديث بنجاح",color: Colors.green);
    } else {
    }
  }

  bool addCatLoad = false;
  addCategory({String name, context, Uint8List image}) async {
    addCatLoad = true;
    notifyListeners();
    final url = "$baseUrl/dashboard/add-category";
    var request = http.MultipartRequest(
        "POST", Uri.parse(url));
    if (image != null) {
      var multipartFile = await http.MultipartFile.fromBytes(
        "image", image,filename: 'abc.png'
      );
      request.files.add(multipartFile);
    }
    request.fields.addAll({'name':name});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      pop(context);
      getCategories();
      showMessage(context: context,msg: "تم بنجاح");
    } else {
    }
    addCatLoad = false;
    notifyListeners();
  }

  editCategory(id,{String name, context, Uint8List image}) async {
    print(name+"  "+image.toString().substring(0,2));
    addCatLoad = true;
    notifyListeners();
    final url = "$baseUrl/edit-category";
    var request = http.MultipartRequest(
        "POST", Uri.parse(url));
    if (image != null) {
      var multipartFile = await http.MultipartFile.fromBytes(
          "image", image,filename: 'abc.png'
      );
      request.files.add(multipartFile);
    }
   if(name!=null&&name.isNotEmpty) request.fields.addAll({'name':name});
    request.fields.addAll({'id':id});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      pop(context);
      getCategories();
      print(response.toString());
      showMessage(context: context,msg: "تم بنجاح");
    } else {
    }
    addCatLoad = false;
    notifyListeners();
  }

}


