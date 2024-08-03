import 'dart:async';

import 'package:get/get.dart';

class FlashSalesCountDownController extends GetxController {
  late Timer _timer;
  late final DateTime expireDateTime;

  FlashSalesCountDownController(this.expireDateTime);

  @override
  void onInit() {
    super.onInit();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      update();
    });
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  Duration get difference => expireDateTime.difference(DateTime.now());
}
