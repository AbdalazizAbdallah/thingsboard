

import 'package:get/get.dart';

import '../../controller/theme_color.dart';

class Binding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(()=>ThemeColorController());

  }
}
