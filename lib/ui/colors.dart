import 'package:flutter/material.dart';

/*const kPrimaryColor = const Color(0xFF81c784);
const kPrimaryLight = const Color(0xFFb2fab4);
const kPrimaryDark = const Color(0xFF519657);
const kSecondaryColor = const Color(0xFF4dd0e1);
const kSecondaryLight = const Color(0xFF88ffff);
const kSecondaryDark = const Color(0xFF009faf);*/

const String primaryOrange = "#f66669";
const String primaryBlack = "#101017";
const String primaryLightGrey = "#fcfcfc";
const String primaryGrey = "#efeded";
const String primaryDarkGrey = "#4A4A4A";
const String primaryBlue = "#a3d4e7";
//  background colour
const String primaryWhiteGrey = "#f2f3f3";

Color gradientStart = Color(getColourHexFromString("#FCFCFC"));
Color gradientEnd = Color(getColourHexFromString(primaryBlue));

int getColourHexFromString(String colourString)
{
  colourString = "FF" + colourString;
  colourString = colourString.replaceAll('#', "");
  int val = 0;
  int len = colourString.length;

  for(int i =0; i < len; i++)
  {
    int hexDigit = colourString.codeUnitAt(i);
    if(hexDigit >= 48 && hexDigit <= 57)
    {
      val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
    }else if(hexDigit >= 65 && hexDigit <= 70){
      val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
    }else if(hexDigit >= 97 && hexDigit <= 102){
      val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
    }else{
      throw new FormatException("An error  occured when converting  a color");
    }
  }
  return val;
}