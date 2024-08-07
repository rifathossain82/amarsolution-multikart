import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:flutter/material.dart';

class KBoxShadow {
  static BoxShadow itemShadow() {
    return const BoxShadow(
      offset: Offset(0.0, 2.0),
      blurRadius: 4,
      spreadRadius: 0,
      color: kGrey,
    );
  }
}
