import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class KHTMLToWidget extends StatelessWidget {
  final String data;

  const KHTMLToWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      data,
    );
  }
}
