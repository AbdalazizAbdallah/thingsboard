import 'package:hive_flutter/hive_flutter.dart';

class HiveController {
  static HiveController instance = HiveController._();

  HiveController._();

  factory HiveController() {
    return instance;
  }

    var settingsBox;

  Future<void> initHive() async {
    await Hive.initFlutter();
    settingsBox =
    await Hive.openBox('settings');
  }

  // setting
  void setLanguage(String languageCode) async {
    return settingsBox.put('language_code', languageCode);
  }
  String get languageCode => settingsBox.get('language_code', defaultValue: 'ar');

  void setWebViewLinux(String WebViewLinux) async {
    return settingsBox.put('web_view_linux', WebViewLinux);
  }
  String get getWebViewLinux => settingsBox.get('web_view_linux', defaultValue: 'no');

  void setTheme(int color) async {
    return settingsBox.put('themeColor', color);
  }
  int get getColor => settingsBox.get('themeColor', defaultValue: 0xFF305680);



  Future<int> logout() async {
    return await settingsBox.clear();
  }
}
