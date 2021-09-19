import 'package:flutter/material.dart';

Widget defaultButton(
    {
      double width = double.infinity,
      Color background = Colors.blue,
      required  String text,
      required Function function,
      double radius=6.0,
      bool isUpperCase = true,
    }
    ) =>Container(
  width:width,
  height: 50.0,
  child: MaterialButton(
    onPressed:(){
      function();
    },
    child:Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(
      radius,
    ),
    color: background,
  ),
);
Widget defaultTextButton(
    {
      required Function function,
      required String text,
    }
    )=>TextButton(onPressed:(){
  function();
},
    child:Text(text.toUpperCase())
);
Widget defaultFormField(
    {
      required controller,
      required  type,
      onSubmitt,
      onChange,
      onTap,
      bool isclickable= true,
      bool isPassword=false,
      required validate,
      required label,
      required prefix,
      suffix,
      suffixpressed,

    }
    )=>TextFormField(
  keyboardType:type,
  controller: controller,
  onFieldSubmitted: onSubmitt,
  obscureText: isPassword,
  onChanged: onChange
  ,validator:validate,
  onTap: onTap,
  enabled: isclickable,
  decoration: InputDecoration(
    labelText:label,
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: suffix!=null?IconButton(
        onPressed: suffixpressed ,
        icon: Icon(suffix)):null,
    border: OutlineInputBorder(),
  ),
);