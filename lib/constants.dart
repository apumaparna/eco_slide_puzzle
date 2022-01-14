import 'package:flutter/material.dart';

const darkestBlue = Color.fromARGB(255, 23, 74, 77);
const secondary = Color.fromARGB(255, 38, 118, 125);
const primary = Color.fromARGB(255, 100, 151, 131);
const tertiary = Color.fromARGB(255, 148, 179, 150);
const quarternary = Color.fromARGB(255, 234, 239, 231);
const brightYellow = Color.fromARGB(255, 247, 193, 98);
const brightPink = Color.fromARGB(255, 252, 117, 149);
const darkestPink = Color.fromARGB(255, 215, 47, 93);
const pureWhite = Color.fromARGB(255, 255, 255, 255);
const pureBlack = Color.fromARGB(255, 0, 0, 0);
const primaryGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [quarternary, tertiary, primary, secondary],
);

const kTextColor = pureBlack;
const mTextColor = pureWhite;

const kAnimationDuration = Duration(milliseconds: 200);
