import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightmode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
      primary:  HexColor("000000"),
      secondary: HexColor("9e9e9e"),
      surface:  HexColor("D9D9D9") ,
    surfaceContainerHighest: Colors.white, //cards bg
    onPrimary: Color(0xffffffff),
    onSecondary:Color(0xffD0CFFF) ,// Ensure surface is red
  ),
);

ThemeData darkmode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary:  HexColor("ffffff"),
    secondary: HexColor("11112A"),
    surface:  HexColor("0C0C21"),
    surfaceContainerHighest: Colors.black,
    onPrimary: Color(0xff0c0c21),
    onSecondary: Color(0xff020550),

  ),



);
