import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';

extension TextStyleExtension on BuildContext {
  /// Memoization cache
  static final _memoizedTextStyles = HashMap<String, TextStyle?>();

  TextStyle titleLarge({
    FontWeight fontWeight = FontWeight.w700,
    double fontSize = 20,
    Color color = kBlackLight,
  }) {
    final key = 'titleLarge_${fontWeight}_${fontSize}_$color';
    return _memoizedTextStyles.putIfAbsent(key, () {
      return Theme.of(this).textTheme.titleLarge?.copyWith(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ) ?? TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      );
    })!;
  }

  TextStyle titleMedium({
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 16,
    Color color = kBlackLight,
  }) {
    final key = 'titleMedium_${fontWeight}_${fontSize}_$color';
    return _memoizedTextStyles.putIfAbsent(key, () {
      return Theme.of(this).textTheme.titleMedium?.copyWith(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ) ?? TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      );
    })!;
  }

  TextStyle titleSmall({
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = 14,
    Color color = kBlackLight,
  }) {
    final key = 'titleSmall_${fontWeight}_${fontSize}_$color';
    return _memoizedTextStyles.putIfAbsent(key, () {
      return Theme.of(this).textTheme.titleSmall?.copyWith(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ) ?? TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      );
    })!;
  }

  TextStyle bodyLarge({
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = 14,
    Color color = kGreyTextColor,
  }) {
    final key = 'bodyLarge_${fontWeight}_${fontSize}_$color';
    return _memoizedTextStyles.putIfAbsent(key, () {
      return Theme.of(this).textTheme.bodyLarge?.copyWith(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ) ?? TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      );
    })!;
  }

  TextStyle bodyMedium({
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = 12,
    Color color = kGreyTextColor,
  }) {
    final key = 'bodyMedium_${fontWeight}_${fontSize}_$color';
    return _memoizedTextStyles.putIfAbsent(key, () {
      return Theme.of(this).textTheme.bodyMedium?.copyWith(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ) ?? TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      );
    })!;
  }

  TextStyle bodySmall({
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = 10,
    Color color = kGreyTextColor,
  }) {
    final key = 'bodySmall_${fontWeight}_${fontSize}_$color';
    return _memoizedTextStyles.putIfAbsent(key, () {
      return Theme.of(this).textTheme.bodySmall?.copyWith(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ) ?? TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      );
    })!;
  }

  TextStyle buttonTextStyle({
    FontWeight fontWeight = FontWeight.w700,
    double fontSize = 12,
    Color color = kWhite,
  }) {
    final key = 'buttonTextStyle_${fontWeight}_${fontSize}_$color';
    return _memoizedTextStyles.putIfAbsent(key, () {
      return Theme.of(this).textTheme.titleSmall?.copyWith(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ) ?? TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      );
    })!;
  }

  TextStyle outlinedButtonTextStyle({
    FontWeight fontWeight = FontWeight.w700,
    double fontSize = 12,
    Color color = kPrimaryColor,
  }) {
    final key = 'outlinedButtonTextStyle_${fontWeight}_${fontSize}_$color';
    return _memoizedTextStyles.putIfAbsent(key, () {
      return Theme.of(this).textTheme.titleSmall?.copyWith(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ) ?? TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      );
    })!;
  }
}
