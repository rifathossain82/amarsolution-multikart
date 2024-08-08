import 'package:flutter/material.dart';

class AccountGridItemModel {
  final String title;
  final String svgIcon;
  final VoidCallback onTap;

  const AccountGridItemModel({
    required this.title,
    required this.svgIcon,
    required this.onTap,
  });
}
