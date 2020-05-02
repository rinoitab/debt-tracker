library constant;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color orange = Color(0xFFFCC78E);
const Color peach = Color(0xFFFFAA91);
const Color pink = Color(0xFFFF8B89);
const Color mint = Color(0xFFDDEADD);
const Color green = Color(0xFF9CE0DF);
const Color torquiose = Color(0xFF54B3BF);
const Color bluegreen = Color(0xFF2A5467);
const Color gray = Color(0xFFCFCFCF);

TextStyle subtitle = GoogleFonts.getFont('Hind');

InputDecoration form = InputDecoration(
  isDense: true,
  labelStyle: subtitle.copyWith(
    color: Colors.grey.shade600
  ),
  errorStyle: TextStyle(height: 0),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: torquiose
      ),
    borderRadius: BorderRadius.circular(24.0)),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: green
      ),
      borderRadius: BorderRadius.circular(24.0)),
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24.0)),
);