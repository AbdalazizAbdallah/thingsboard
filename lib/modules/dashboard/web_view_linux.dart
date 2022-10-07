

import 'dart:io';

import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../utils/services/local_storage.dart';


bool webViewLoading = true;
Future webViewLinux(String controller)async{
    WebviewWindow.isWebviewAvailable().then((value) {
      webViewLoading = value;

  });

  final webview = await WebviewWindow.create(
    configuration: CreateConfiguration(
      userDataFolderWindows: await _getWebViewPath(),
      titleBarTopPadding: Platform.isMacOS ? 0 : 0,
    ),
  );
  webview
    ..setBrightness(Brightness.light)
    ..setApplicationNameForUserAgent("WebviewExample/1.0.0")
    ..launch(controller)
    ..addOnUrlRequestCallback((url) {

      debugPrint('url: $url');
      final uri = Uri.parse(url);
      if (uri.path == '/login_success') {
        debugPrint('login success. token: ${uri.queryParameters['token']}');
        webview.close();

      }
    })
    ..onClose.whenComplete(() {
      webViewLoading = false;
      HiveController().setWebViewLinux('no');
      debugPrint("on close");
    });
  await Future.delayed(const Duration(seconds: 2));
  for (final javaScript in _javaScriptToEval) {
    try {
      final ret = await webview.evaluateJavaScript(javaScript);
      debugPrint('evaluateJavaScript: $ret');
    } catch (e) {
      HiveController().setWebViewLinux('no');
      debugPrint('evaluateJavaScript error: $e \n $javaScript');
    }
  }
 }

const _javaScriptToEval = [
  """
  function test() {
    return;
  }
  test();
  """,
  'eval({"name": "test", "user_agent": navigator.userAgent})',
  '1 + 1',
  'undefined',
  '1.0 + 1.0',
  '"test"',
];

Future<String> _getWebViewPath() async {
  final document = await getApplicationDocumentsDirectory();
  return p.join(
    document.path,
    'desktop_webview_window',
  );
}