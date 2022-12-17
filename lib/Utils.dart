import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:path/path.dart';

class constants
{
  //colors
  static const kPrimaryColor = Color(0xFFFFFFFF);
  static const kGreyColor = Color(0xFFEEEEEE);
  static const kBlackColor = Color(0xFF111111);
  static const hinttext = Color(0xF4AFAEAE);
  static const Grey = Color(0xff3b434c);
  static const Tertiary = Color(0xEEFC8621);
  static const redAccent = Colors.redAccent;
  static const green = Colors.green;
  static const  appbackgroundcolor= Color(0xEEEEEEEE);
  static const  backgroundcolor= Color(0xAD242526);


  final List<String> choicesList = ['BAIL', 'SEED', 'LINT', 'COTTON'];
  final List<String> choicesList1 = ['TRUCK', 'LORRY', 'TRACTOR', 'HMV'];

  snackbar(context,string,color){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds:1),
      backgroundColor: color,
      content: Text('$string',textAlign:TextAlign.center,),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      margin: EdgeInsets.only(

          bottom: MediaQuery.of(context).size.height - 100,
          right: 20,
          left: 20),
    ));
  }
}