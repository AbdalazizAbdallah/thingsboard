import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:things_board_app/config/routes/router.dart';
import 'package:things_board_app/core/context/tb_context.dart';
import 'package:things_board_app/utils/ui/qr_code_scanner.dart';

class UiUtilsRoutes extends TbRoutes {
  late var qrCodeScannerHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return QrCodeScannerPage(tbContext);
  });

  UiUtilsRoutes(TbContext tbContext) : super(tbContext);

  @override
  void doRegisterRoutes(router) {
    router.define("/qrCodeScan", handler: qrCodeScannerHandler);
  }
}
