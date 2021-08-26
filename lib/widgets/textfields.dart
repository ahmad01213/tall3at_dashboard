import 'package:dashboard/style.dart';
import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  final lable;
  final width;
  final int height;
  final int radius;
  final String initialValue;
  final int maxLines;
  final keyboard;
  final int horizontalMargin;
  final bgColor;
  final expands;
  Function validator;
  Function onChange;
  FocusNode _focus = new FocusNode();
  TextEditingController _textEditingController;
  final suffIcon;
  final icon;
  final bool isHidden;
  final formator;

  TextFields(
      {this.lable,
      this.keyboard,
        this.expands=true,
      this.maxLines = 1,
      this.initialValue,
      this.onChange,
      this.horizontalMargin = 35,
      this.bgColor = Colors.white,
      this.suffIcon,
      this.radius = 5,
      this.height = 80,
      this.isHidden = false,
      this.icon,
      this.validator,
      this.width,this.formator});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin.toDouble()),
      height: height.toDouble(),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(radius.toDouble())),
      child: Theme(
        data: Theme.of(context).copyWith(
          accentColor: mainColor,
        ),
        child: TextFormField(
          // focusNode: _focus,
          maxLines: maxLines,
          onChanged: onChange,

          initialValue: initialValue,
          validator: (v) {
           if(validator!=null) validator(v);
            if (v.toString().isEmpty) {
              return "";
            }
            return null;
          },
          // controller: TextEditingController(),
          keyboardType: keyboard,
          style: TextStyle(color: Colors.black),
          obscureText: isHidden,
          inputFormatters:formator,
          decoration: new InputDecoration(
            border: new OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(radius.toDouble()),
                ),
                borderSide: BorderSide(color: greyColor, width: 0.2)),
            enabledBorder: new OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(radius.toDouble())),
                borderSide: BorderSide(color: Color(0xFF8A8D90), width: 0.2)),
            errorBorder: new OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(radius.toDouble())),
                borderSide: BorderSide(color: Colors.red, width: 0.8)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(radius.toDouble())),
                borderSide: BorderSide(color: Colors.red, width: 0.8)),
            focusedBorder: new OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(radius.toDouble()),
                ),
                borderSide: BorderSide(color: mainColor, width: 0.8)),
            hintStyle: new TextStyle(color: Color(0xFF8A8D90), fontSize: 14),
            hintText: lable,
            errorStyle: TextStyle(fontSize: 1),
            prefixIcon: icon != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      icon,
                      size: 16,
                    ),
                  )
                : null,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                suffIcon,
                size: 25,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
