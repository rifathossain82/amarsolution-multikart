import 'package:get/get.dart';

class DashboardController extends GetxController {
  final _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;

  void updateCurrentIndex(int index) {
    _currentIndex.value = index;
  }
}
