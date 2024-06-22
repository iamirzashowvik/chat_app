import 'package:flutter/material.dart';

// INIT
double large = 32;
double regular = 14;
double small = 12;

double titleSize = 16;

// LARGE SIZE
final lgBold = TextStyle(
  fontSize: large,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);
final lgBook = TextStyle(
  fontSize: large,
  color: Colors.white,
);

// REGULAR SIZE
final rgBold = TextStyle(
    fontSize: regular, fontWeight: FontWeight.bold, color: Colors.white);
final rgBook = TextStyle(fontSize: regular, color: Colors.white);
final rgMed = TextStyle(fontSize: regular, color: Colors.white);

// SMALL SIZE
final smBold = TextStyle(
    fontSize: small, fontWeight: FontWeight.bold, color: Colors.white);
final smBook = TextStyle(fontSize: small, color: Colors.white);
final smMed = TextStyle(fontSize: small, color: Colors.white);

// PADDING
double rgPadding = regular;
double lgPadding = rgPadding * 2;
double smPadding = rgPadding / 2;
double miniPadding = smPadding / 1.5;

double screenPadding = regular / 1.25;

const kPrimaryColor = Colors.teal;
