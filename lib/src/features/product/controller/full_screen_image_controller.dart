import 'package:get/get.dart';

class FullScreenImageController{
  var currentIndex = 0.obs;

  void updateIndex(int index){
    currentIndex.value = index;
  }
}