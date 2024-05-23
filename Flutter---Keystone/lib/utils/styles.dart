import 'package:flutter/material.dart';

class CustomTextStyles {
  static TextStyle get screenTitle => const TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 32,
      fontWeight: FontWeight.w500
  );

  static TextStyle w400White(double fontSize) => TextStyle(
    color: const Color(0xFFFFFFFF),
    fontSize: fontSize,
    fontWeight: FontWeight.w400
  );

  static TextStyle w600White(double fontSize) => TextStyle(
    color: const Color(0xFFFFFFFF),
    fontSize: fontSize,
    fontWeight: FontWeight.w600
  );

  static TextStyle w900White(double fontSize) => TextStyle(
      color: const Color(0xFFFFFFFF),
      fontSize: fontSize,
      fontWeight: FontWeight.w900
  );

  static TextStyle get alternateLargeButton => const TextStyle(
      color: Color(0xFFF58428),
      fontSize: 20,
      fontWeight: FontWeight.w600
  );

  static TextStyle get textButton => const TextStyle(
      color: Color(0xFFF58428),
      fontSize: 12,
      fontWeight: FontWeight.w900
  );

  static TextStyle get hint =>  const TextStyle(
      color: Color(0xFF9D9D9D),
      fontSize: 14,
      fontWeight: FontWeight.w400
  );
}