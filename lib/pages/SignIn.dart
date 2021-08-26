import 'package:dashboard/DataProvider.dart';
import 'package:dashboard/widgets/SizedBoxWidget.dart';
import 'package:dashboard/widgets/textfields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../helpers.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Map<String,String> formData = {};

  final _formKey = GlobalKey<FormState>();

  DataProvider dataProvider;

  @override
  Widget build(BuildContext context) {
    if(dataProvider == null){
      dataProvider = Provider.of(context);
    }
    return SafeArea(
      child: Scaffold(
        body: Builder(

          builder: (ctx)=>
          Center(
            child: Container(
              width: 500,
              height: 550,
              child: Card(
                child: Container(
                  margin: EdgeInsets.all(50),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/logo.png',height: 60,fit: BoxFit.fill,),
                      SizedBox(
                        height: 30,
                      ),
                      TextFields(
                          lable: 'البريد الإلكتروني',
                          icon: Icons.email_outlined,
                          horizontalMargin: 0,

                          keyboard: TextInputType.phone,
                          onChange: (value) {
                            formData['userName'] = value.toString();
                          },

                          isHidden: false),
                      SizedBox(
                        height: 30,
                      ),
                      TextFields(
                          lable: ' كلمة المرور',
                          horizontalMargin: 0,
                          icon: Icons.remove_red_eye,
                          keyboard: TextInputType.visiblePassword,
                          onChange: (value) {
                            formData['password'] = value.toString();

                          },
                          isHidden: true
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          if(_formKey.currentState.validate()){
                            dataProvider.login(context: ctx,params:formData);
                          }
                        },
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [mainColor, mainColor.withOpacity(0.8)])),
                          child: Center(child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('تسجيل الدخول', style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold,
                                  color: Colors.white),),
                              SizedBox(
                                width: 20,
                              ),

                              dataProvider.loading
                                  ? Center(
                                child: SpinKitRing(
                                  size: 30,
                                  color: Colors.white,
                                  lineWidth: 5,
                                  duration: Duration(milliseconds: 700),
                                ),
                              )
                                  :Box(1)
                            ],
                          )),
                        ),
                      ),
                      SizedBox(height: 20,),

                      SizedBox(height: 20,),


                    ],),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  textFromField({password, hint, icon, inputType, onChange, initialValue}) {
    return Container(
      height: 60.0,
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0.0),
          color: Colors.white,
           // border: Border.all(color: Colors.grey,width: 1)
      ),
      padding: EdgeInsets.only(left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
      child: Theme(
        data: ThemeData(
          hintColor: Colors.transparent,
        ),
        child: TextFormField(
          obscureText: password,
          initialValue: initialValue,
          validator: (v){
            if(v.toString().trim().isEmpty){
              return " ";
            }
            return null;
          },
          onChanged: onChange,
          decoration: InputDecoration(
              // border: InputBorder.none,
              labelText: hint,
              icon: Icon(
                icon,
                color: Colors.black38,
              ),
              labelStyle: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Sans',
                  letterSpacing: 0.3,
                  color: Colors.black38,
                  fontWeight: FontWeight.w600)),
          keyboardType: inputType,
        ),
      ),
    );
  }
}
