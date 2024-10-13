import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media_app/wedgits/text_field_border.dart';
import '../constant/colorclass.dart';

 inputDecorationWidget({required String text,Color? bdcolor,Icon? prefixIcon}) {
  return InputDecoration(
      fillColor: bdcolor??null,
      filled: true,
      hintText:text,
      prefixIcon: prefixIcon??null, 
      border:         borderWidget ,
      enabledBorder:  borderWidget ,
      focusedBorder:  borderWidget ,
      hintStyle: GoogleFonts.poppins(
          fontSize:15,
          color: MyColors.hintInput
      )
  );
}
