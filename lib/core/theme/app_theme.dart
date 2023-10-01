import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class AppTheme {
  static lightTheme() {
    return ThemeData.light().copyWith(
      useMaterial3: true,
      scaffoldBackgroundColor: MyColors.myDark,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateColor.resolveWith(
            (states) => MyColors.myDark,
          ),
          backgroundColor: MaterialStateColor.resolveWith(
            (states) => MyColors.myYellow,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          textStyle: MaterialStatePropertyAll(
            GoogleFonts.anekBangla(
              textStyle: const TextStyle(
                fontSize: 15,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(MyColors.myYellow),
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.alegreya(
          textStyle: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
            letterSpacing: 3,
            color: MyColors.myWhite,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        headlineMedium: GoogleFonts.anekBangla(
          textStyle: const TextStyle(
            fontSize: 20,
            letterSpacing: 3,
            color: MyColors.myWhite,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        bodyLarge: GoogleFonts.anekBangla(
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 3,
            color: Colors.white,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        bodyMedium: GoogleFonts.anekBangla(
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 1.5,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: MyColors.myGrey.withOpacity(.1),
        iconTheme: const IconThemeData(color: MyColors.myWhite),
        titleTextStyle: GoogleFonts.anekBangla(
          color: MyColors.myWhite,
          fontWeight: FontWeight.w700,
          letterSpacing: 3,
          fontSize: 24,
        ),
      ),
      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
          iconColor: MaterialStatePropertyAll(MyColors.myYellow),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: MyColors.myYellow,
        foregroundColor: MyColors.myWhite,
      ),
      listTileTheme: ListTileThemeData(
        tileColor: MyColors.myGrey.withOpacity(.1),
        contentPadding: const EdgeInsets.all(10),
        titleTextStyle: GoogleFonts.anekBangla(
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        leadingAndTrailingTextStyle: GoogleFonts.anekBangla(
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 1.5,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
