import 'package:flutter/material.dart';

class LoadingOverlay {
  static show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Material(
          type: MaterialType.transparency,
          child: Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.5),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text("Loading...", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static hide(BuildContext context) {
    Navigator.of(context).pop();
  }

  static Future<void> runAsyncTask(
    BuildContext context,
    Future<void> Function() task,
  ) async {
    try {
      show(context);
      await task();
    } finally {
      hide(context);
    }
  }
}
