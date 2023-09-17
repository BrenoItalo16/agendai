import 'package:flutter/material.dart';

class AppTheme {
  final primary = const Color(0xff876AFF);
  final secondary = const Color(0xff07CBAD);
  final red = const Color(0xffFF4466);
  final green = const Color(0xff00FF88);
  final white = const Color(0xffFAFAFA);
  final grey = const Color(0xffB6C5D1);
  final lightGrey = const Color(0xffF0F3F6);
  final black = const Color(0xff262633);
  final grey700 = const Color(0xffDDDDDD);
  final shadow = const Color(0xff0D3F67);
  final txtColor = const Color(0xff0D3F67);

  // Body and title
  late final title16 = TextStyle(
    fontSize: 16,
    color: txtColor,
  );

  late final title16Bold = TextStyle(
    fontSize: 16,
    color: txtColor,
    fontWeight: FontWeight.bold,
  );

  // Body and title
  late final body16 = TextStyle(
    fontSize: 16,
    color: txtColor,
  );

  late final body16Bold = TextStyle(
    fontSize: 16,
    color: txtColor,
    fontWeight: FontWeight.bold,
  );

  late final heading36 = TextStyle(
    fontSize: 36,
    color: txtColor,
  );

  late final heading36Bold = TextStyle(
    fontSize: 36,
    color: txtColor,
    fontWeight: FontWeight.bold,
  );

  late final label12Bold = TextStyle(
    fontSize: 12,
    color: txtColor,
    fontWeight: FontWeight.bold,
  );

  late final label12 = TextStyle(
    fontSize: 12,
    color: txtColor,
  );
}
