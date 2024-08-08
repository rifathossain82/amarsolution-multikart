import 'package:amarsolution_multikart/src/core/helpers/logger.dart';
import 'package:amarsolution_multikart/src/core/services/snack_bar_services.dart';
import 'package:amarsolution_multikart/src/core/utils/color.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherServices {
  static void sendWhatsappMessage({
    required String phoneNumber,
    required String message,
  }) async {
    Uri uri = Uri.parse(
      "whatsapp://send?phone=+88$phoneNumber&text=${Uri.encodeFull(message)}",
    );

    _launchUri(uri);
  }

  static void sendEmail({
    required String email,
    required String message,
  }) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Invoice%20&body=${Uri.encodeFull(message)}%20',
    );

    _launchUri(params);
  }

  static void openURL({
    required String url,
    LaunchMode launchMode = LaunchMode.platformDefault,
  }) async {
    try {
      Uri uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: '$e',
        bgColor: failedColor,
      );
    }
  }

  static void _launchUri(Uri uri) async {
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: '$e',
        bgColor: failedColor,
      );
    }
  }
}
