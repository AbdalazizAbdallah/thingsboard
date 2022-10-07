import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:things_board_app/utils/services/local_storage.dart';
import 'package:things_board_app/core/context/tb_context.dart';


class ThemeColorController extends GetxController {
  static ThemeColorController get to => Get.find();

  void changeTheme(Color color, BuildContext context, TbContext tbContext) {
    ///   themeColor = color;
    HiveController().setTheme(color.value);
    HiveController().getColor;
    update();
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        scrollable: true,
        contentPadding: EdgeInsets.fromLTRB(8, 5, 8, 5),
        insetPadding: EdgeInsets.all(15),
        backgroundColor: Colors.white.withOpacity(.85),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Column(
          children: [
            Text(
              'Attention'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 1.2,
              margin: EdgeInsets.only(top: 5),
              width: double.infinity,
              color: Colors.black,
            )
          ],
        ),
        content: Container(
          width: MediaQuery.of(context).size.width - 55,
          margin: EdgeInsets.only(top: 25, bottom: 15),
          child: InkWell(
            onTap: () {
              // tbContext. navigateTo('/home',
              //   replace: true,
              //   clearStack: true,
              //   transition: TransitionType.fadeIn,
              //   restoreDashboard: true,
              //
              //   closeDashboard: true,
              //   transitionDuration: Duration(milliseconds: 750));
              ///  Phoenix.rebirth(context);

              //     Navigator.push(context, MaterialPageRoute(builder: (context) =>  ThingsboardInitApp(tbContext)));

              Get.back();
              Get.back();
            },
            child: Text(
              "Do you want to restart the application".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
    print('changeTheme color value==> ${color.value}');
    print('changeTheme color ==> $color');

    print('changeTheme themeColor ==> ${HiveController().getColor}');
    //   Get.back();
    update();
  }
}

// Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     InkWell(
//     onTap: () async{
//       WidgetsFlutterBinding.ensureInitialized();
//       await HiveController().initHive();
//       if (UniversalPlatform.isAndroid) {
//         await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
//       }
//       runApp(ThingsboardApp());
//     },
//       child: Container(
//         width: 120,
//         height: 55,
//         margin: EdgeInsets.all(20),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//             border: Border.all(color: Colors.blueAccent),
//             borderRadius: BorderRadius.circular(7)),
//         child: Text(
//           "Yes".tr,
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 17,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     ),
//     InkWell(
//       onTap: () => Get.back(),
//       child: Container(
//         width: 120,
//         height: 55,
//         alignment: Alignment.center,
//         margin: EdgeInsets.all(20),
//         decoration: BoxDecoration(
//             border: Border.all(color: Colors.red),
//             borderRadius: BorderRadius.circular(7)),
//         child: Text(
//           "No".tr,
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 17,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     ),
//   ],
// )
