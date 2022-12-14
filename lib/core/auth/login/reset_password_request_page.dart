import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:things_board_app/core/auth/login/login_page_background.dart';
import 'package:things_board_app/core/context/tb_context.dart';
import 'package:things_board_app/core/context/tb_context_widget.dart';
import 'package:things_board_app/widgets/tb_app_bar.dart';
import 'package:things_board_app/widgets/tb_progress_indicator.dart';

class ResetPasswordRequestPage extends TbPageWidget {
  ResetPasswordRequestPage(TbContext tbContext) : super(tbContext);

  @override
  _ResetPasswordRequestPageState createState() =>
      _ResetPasswordRequestPageState();
}

class _ResetPasswordRequestPageState
    extends TbPageState<ResetPasswordRequestPage> {
  final _isLoadingNotifier = ValueNotifier<bool>(false);

  final _resetPasswordFormKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      LoginPageBackground(),
      SizedBox.expand(
          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: TbAppBar(
                tbContext,
                title: Text('passwordReset'.tr),
              ),
              body: Stack(children: [
                SizedBox.expand(
                    child: Padding(
                        padding: EdgeInsets.all(24),
                        child: FormBuilder(
                            key: _resetPasswordFormKey,
                            autovalidateMode: AutovalidateMode.disabled,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(height: 16),
                                  Text(
                                    'passwordResetText'.tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xFFAFAFAF),
                                        fontSize: 14,
                                        height: 24 / 14),
                                  ),
                                  SizedBox(height: 61),
                                  FormBuilderTextField(
                                    name: 'email',
                                    autofocus: true,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                          errorText:
                                              'emailRequireText'.tr),
                                      FormBuilderValidators.email(
                                          errorText:
                                              'emailInvalidText'.tr)
                                    ]),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'email *'.tr),
                                  ),
                                  Spacer(),
                                  ElevatedButton(
                                    child: Text(
                                        'requestPasswordReset'.tr),
                                    style: ElevatedButton.styleFrom(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 16)),
                                    onPressed: () {
                                      _requestPasswordReset();
                                    },
                                  )
                                ])))),
                ValueListenableBuilder<bool>(
                    valueListenable: _isLoadingNotifier,
                    builder: (BuildContext context, bool loading, child) {
                      if (loading) {
                        return SizedBox.expand(
                            child: Container(
                          color: Color(0x99FFFFFF),
                          child: Center(child: TbProgressIndicator(size: 50.0)),
                        ));
                      } else {
                        return SizedBox.shrink();
                      }
                    })
              ])))
    ]));
  }

  void _requestPasswordReset() async {
    FocusScope.of(context).unfocus();
    if (_resetPasswordFormKey.currentState?.saveAndValidate() ?? false) {
      var formValue = _resetPasswordFormKey.currentState!.value;
      String email = formValue['email'];
      _isLoadingNotifier.value = true;
      try {
        await Future.delayed(Duration(milliseconds: 300));
        await tbClient.sendResetPasswordLink(email);
        _isLoadingNotifier.value = false;
        showSuccessNotification(
            'passwordResetLinkSuccessfullySentNotification'.tr);
      } catch (e) {
        _isLoadingNotifier.value = false;
      }
    }
  }
}
