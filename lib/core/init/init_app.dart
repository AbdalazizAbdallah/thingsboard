import 'package:flutter/material.dart';
import 'package:things_board_app/core/context/tb_context.dart';
import 'package:things_board_app/core/context/tb_context_widget.dart';
import 'package:things_board_app/widgets/tb_progress_indicator.dart';

import '../../utils/services/local_storage.dart';

class ThingsboardInitApp extends TbPageWidget {
  ThingsboardInitApp(TbContext tbContext, {Key? key})
      : super(tbContext, key: key);

  @override
  _ThingsboardInitAppState createState() => _ThingsboardInitAppState();
}

class _ThingsboardInitAppState extends TbPageState<ThingsboardInitApp> {
  @override
  void initState() {
    super.initState();
    initTbContext();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child:  HiveController().getWebViewLinux == 'no'?TbProgressIndicator(size: 50.0):Container(),
    );
  }
}
