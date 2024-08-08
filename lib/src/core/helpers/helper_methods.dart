import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';

/// Debug Print Utility
///
/// ## Usage
/// To log debug information, call `kPrint(data)` with the desired [data] to print.
/// The information will be displayed in the console during debugging sessions.
///
/// Example:
/// ```dart
/// kPrint("Debug information");
/// ```
void kPrint(dynamic data) {
  if (kDebugMode) {
    print(data);
  }
}


/// To share any thing by third party app
void kShareData({
  required String title,
  String? subTitle,
  String? subject,
}) {
  Share.share(
    '$title ${subTitle ?? ''}',
    subject: subject ?? '',
  );
}
