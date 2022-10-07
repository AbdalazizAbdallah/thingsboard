import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:things_board_app/controller/theme_color.dart';
import 'package:things_board_app/core/context/tb_context.dart';
import 'package:things_board_app/core/context/tb_context_widget.dart';
import 'package:thingsboard_client/thingsboard_client.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../../utils/services/local_storage.dart';

class MorePage extends TbContextWidget {
  MorePage(TbContext tbContext) : super(tbContext);

  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends TbContextState<MorePage> {


  Color pickerColor = Color(HiveController().getColor);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }
  final NetworkInfo _networkInfo = NetworkInfo();



  @override
  void initState() {
    if (UniversalPlatform.isLinux)
      _initNetworkInfo();
    super.initState();
  }
  var wifiIP;
  Future<void> _initNetworkInfo() async {

    wifiIP = await _networkInfo.getWifiIP();
    print('object wifiIP : $wifiIP');
    setState(() {
      this.wifiIP = wifiIP;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Directionality(
          textDirection: HiveController().languageCode == 'ar'
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16, 40, 16, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.account_circle,
                        size: 48, color: Color(0xFFAFAFAF)),
                    Spacer(),
                    IconButton(
                        icon: Icon(Icons.settings, color: Color(0xFFAFAFAF)),
                        onPressed: () async {
                          await navigateTo('/profile');
                          setState(() {});
                        })
                  ],
                ),
                SizedBox(height: 22),
                Text(_getUserDisplayName(),
                    style: TextStyle(
                        color: Color(0xFF282828),
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        height: 23 / 20)),
                SizedBox(height: 2),
                Text(_getAuthorityName(context),
                    style: TextStyle(
                        color: Color(0xFFAFAFAF),
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        height: 16 / 14)),
                SizedBox(height: 24),
                Divider(color: Color(0xFFEDEDED)),
                if (UniversalPlatform.isLinux)
                  Column(
                    children: [
                      SizedBox(height: 24),
                      Row(
                        children: [
                          Text("IP address".tr + ": ",
                              style: TextStyle(
                                  color: Color(0xFF282828),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  height: 23 / 20)),
                          Text("$wifiIP",
                              style: TextStyle(
                                  color: Color(0xFF282828),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  height: 23 / 20)),
                        ],
                      ),
                      SizedBox(height: 24),
                      Divider(color: Color(0xFFEDEDED)),
                    ],
                  ),
                SizedBox(height: 8),
                buildMoreMenuItems(context),
                SizedBox(height: 8),
                Divider(color: Color(0xFFEDEDED)),
                SizedBox(height: 8),
                GestureDetector(
                  /// behavior: HitTestBehavior.opaque,
                    child: Container(
                        height: 48,
                        child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 18),
                            child: Row(mainAxisSize: MainAxisSize.max, children: [
                              Image.asset('assets/images/colour.png',fit: BoxFit.contain,width: 25  ,),

                              SizedBox(width: 34),
                              Text("Change Color".tr,
                                  style: TextStyle(
                                      color: Color(0xFF282828),
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      height: 20 / 14))
                            ]))),
                    onTap: () {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text("Change Color".tr),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                hexInputBar: true,
                                pickerColor: pickerColor,
                                onColorChanged: changeColor,
                              ),
                            ),
                            actions: <Widget>[
                              GetBuilder<ThemeColorController>(
                                init: ThemeColorController(),
                                builder: (logic) => ElevatedButton(
                                  child: Text('ok'.tr),
                                  onPressed: () {
                                    print(
                                        "color pickerColor235 ${pickerColor} ");
                                    logic.changeTheme(
                                        pickerColor, context, tbContext);
                                  },
                                ),
                              ),
                            ],
                          ));
                    }),

                Divider(color: Color(0xFFEDEDED)),
                SizedBox(height: 8),
                GestureDetector(
                  /// behavior: HitTestBehavior.opaque,
                    child: Container(
                        height: 48,
                        child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 18),
                            child: Row(mainAxisSize: MainAxisSize.max, children: [
                              Image.asset('assets/images/google.png',fit: BoxFit.contain,width: 25  ,),
                              SizedBox(width: 34),
                              Text(   HiveController().languageCode == 'ar'
                                  ? "English"
                                  : "اللغة العربية ",
                                  style: TextStyle(
                                      color: Color(0xFF282828),
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      height: 20 / 14))
                            ]))),
                    onTap: () {
                      if (HiveController().languageCode == 'ar') {
                        HiveController().setLanguage('en');
                        Get.updateLocale(Locale('en', ''));
                      } else if (HiveController().languageCode == 'en') {
                        HiveController().setLanguage('ar');
                        Get.updateLocale(Locale('ar', ''));
                      }
                      print(
                          "languageCode HiveController ${HiveController().languageCode}");
                    }),


                Divider(color: Color(0xFFEDEDED)),
                SizedBox(height: 8),
                GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                        height: 48,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 18),
                            child:
                            Row(mainAxisSize: MainAxisSize.max, children: [
                              Icon(Icons.logout, color: Color(0xFFE04B2F)),
                              SizedBox(width: 34),
                              Text('logout'.tr,
                                  style: TextStyle(
                                      color: Color(0xFFE04B2F),
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      height: 20 / 14))
                            ]))),
                    onTap: () {
                      tbClient.logout(
                          requestConfig: RequestConfig(ignoreErrors: true));
                    }),
              ],
            ),
          ),
        ));
  }

  Widget buildMoreMenuItems(BuildContext context) {
    List<Widget> items =
        MoreMenuItem.getItems(tbContext, context).map((menuItem) {
      return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Container(
              height: 48,
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 18),
                  child: Row(mainAxisSize: MainAxisSize.max, children: [
                    Icon(menuItem.icon, color: Color(0xFF282828)),
                    SizedBox(width: 34),
                    Text(menuItem.title,
                        style: TextStyle(
                            color: Color(0xFF282828),
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            height: 20 / 14))
                  ]))),
          onTap: () {
            navigateTo(menuItem.path);
          });
    }).toList();
    return Column(children: items);
  }

  String _getUserDisplayName() {
    var user = tbContext.userDetails;
    var name = '';
    if (user != null) {
      if ((user.firstName != null && user.firstName!.isNotEmpty) ||
          (user.lastName != null && user.lastName!.isNotEmpty)) {
        if (user.firstName != null) {
          name += user.firstName!;
        }
        if (user.lastName != null) {
          if (name.isNotEmpty) {
            name += ' ';
          }
          name += user.lastName!;
        }
      } else {
        name = user.email;
      }
    }
    return name;
  }

  String _getAuthorityName(BuildContext context) {
    var user = tbContext.userDetails;
    var name = '';
    if (user != null) {
      var authority = user.authority;
      switch (authority) {
        case Authority.SYS_ADMIN:
          name = 'systemAdministrator'.tr;
          break;
        case Authority.TENANT_ADMIN:
          name = 'tenantAdministrator'.tr;
          break;
        case Authority.CUSTOMER_USER:
          name = 'customer'.tr;
          break;
        default:
          break;
      }
    }
    return name;
  }
}

class MoreMenuItem {
  final String title;
  final IconData icon;
  final String path;

  MoreMenuItem({required this.title, required this.icon, required this.path});

  static List<MoreMenuItem> getItems(
      TbContext tbContext, BuildContext context) {
    if (tbContext.isAuthenticated) {
      List<MoreMenuItem> items = [];
      switch (tbContext.tbClient.getAuthUser()!.authority) {
        case Authority.SYS_ADMIN:
          break;
        case Authority.TENANT_ADMIN:
          items.addAll([
            MoreMenuItem(
                title: 'customers'.tr,
                icon: Icons.supervisor_account,
                path: '/customers'),
            MoreMenuItem(
                title: 'assets'.tr,
                icon: Icons.domain,
                path: '/assets'),
            MoreMenuItem(
                title: 'auditLogs'.tr,
                icon: Icons.track_changes,
                path: '/auditLogs')
          ]);
          break;
        case Authority.CUSTOMER_USER:
          items.addAll([
            MoreMenuItem(
                title: 'assets'.tr,
                icon: Icons.domain,
                path: '/assets')
          ]);
          break;
        case Authority.REFRESH_TOKEN:
          break;
        case Authority.ANONYMOUS:
          break;
        // case Authority.PRE_VERIFICATION_TOKEN:
        //   break;
        case Authority.PRE_VERIFICATION_TOKEN:
          // TODO: Handle this case.
          break;
      }
      return items;
    } else {
      return [];
    }
  }
}
