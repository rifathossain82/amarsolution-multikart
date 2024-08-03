import 'package:flutter/cupertino.dart';

class BottomAppBarItemModel {
  final String selectedIconPath;
  final String unselectedIconPath;
  final int index;

  BottomAppBarItemModel({
    required this.selectedIconPath,
    required this.unselectedIconPath,
    required this.index,
  });
}
