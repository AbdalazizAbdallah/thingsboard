import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:things_board_app/lang/ar.dart';
import 'package:things_board_app/lang/en.dart';
import '../utils/services/local_storage.dart';

class AppLocale extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'en': en, 'ar': ar};

  static void changeLang() {
    String newLanguageCode =
        HiveController().languageCode == 'en' ? 'ar' : 'en';
    Get.updateLocale(Locale(newLanguageCode));
    HiveController().setLanguage(newLanguageCode);
  }
}
