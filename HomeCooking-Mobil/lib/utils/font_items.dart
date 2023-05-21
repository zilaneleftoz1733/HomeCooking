import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectmanagement/utils/color_items.dart';

class FontItems {
  static TextStyle normalTextInter18 = GoogleFonts.inter(
    fontSize: 18,
    color: Colors.white,
  );

  static TextStyle newsTextInterBlack20 = GoogleFonts.inter(fontSize: 20, color: Colors.black);

  static TextStyle normalTextInter14 = GoogleFonts.inter(
    fontSize: 18,
    color: Colors.black,
  );

  static TextStyle boldTextInter20 = GoogleFonts.inter(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);
  static TextStyle boldTextInter16 = GoogleFonts.inter(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold);
  static TextStyle boldTextInter16Yellow =
      GoogleFonts.inter(fontSize: 16, color: Colors.yellow, fontWeight: FontWeight.bold);
  static TextStyle boldTextInter20White =
      GoogleFonts.inter(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);

  static TextStyle normalTextWorkSans16 = GoogleFonts.workSans(fontSize: 16, color: Colors.white);
  static TextStyle boldTextWorkSans20 =
      GoogleFonts.workSans(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);
  static TextStyle boldTextInter24 = GoogleFonts.inter(fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold);
  static TextStyle boldTextInter24White =
      GoogleFonts.inter(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold);

  static TextStyle boldTextInter24Turquase(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fontSize = size.width * 0.03;

    return GoogleFonts.inter(fontSize: 24, color: ColorItems.generalTurquaseColor, fontWeight: FontWeight.bold);
  }

  static TextStyle boldTextInter24Red = GoogleFonts.inter(fontSize: 24, color: Colors.red, fontWeight: FontWeight.bold);

  static TextStyle boldTextInter20Turquase =
      GoogleFonts.inter(fontSize: 20, color: ColorItems.generalTurquaseColor, fontWeight: FontWeight.bold);

  static TextStyle normalTextStyle16 = const TextStyle(fontSize: 16, color: Colors.white);
  static TextStyle normalTextStyle20 = const TextStyle(fontSize: 20, color: Colors.white);
  static TextStyle normalTextStyle14 = const TextStyle(fontSize: 14, color: Colors.white);
}
