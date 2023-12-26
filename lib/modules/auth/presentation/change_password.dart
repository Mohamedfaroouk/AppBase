import 'package:easy_localization/easy_localization.dart';
import 'package:appbase/modules/auth/cubit/cubit.dart';
import 'package:appbase/shared/widgets/textfield.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/validations.dart';
import '../../../shared/widgets/applogo.dart';
import '../../../shared/widgets/buttons.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController token = TextEditingController();

  final TextEditingController pass = TextEditingController();

  final TextEditingController passComfirm = TextEditingController();

  @override
  void dispose() {
    token.dispose();
    pass.dispose();
    passComfirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('changePassword'.tr()),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                const AppLogo(),
                const SizedBox(height: 40),
                DefaultTextField(
                  flex: 1,
                  controller: token,
                  keyboardType: TextInputType.emailAddress,
                  showLabel: true,
                  hintText: "codeSentOnMail".tr(),
                  label: "codeSentOnMail".tr(),
                  validate: Validation.defaultValidation,
                ),
                const SizedBox(height: 10),
                DefaultTextField(
                    flex: 1,
                    controller: pass,
                    keyboardType: TextInputType.visiblePassword,
                    showLabel: true,
                    hintText: "password".tr(),
                    label: "password".tr(),
                    validate: Validation.passwordValidation),
                const SizedBox(
                  height: 10,
                ),
                DefaultTextField(
                    flex: 1,
                    controller: passComfirm,
                    keyboardType: TextInputType.visiblePassword,
                    showLabel: true,
                    hintText: "confirmPassword".tr(),
                    label: "confirmPassword".tr(),
                    validate: (value) {
                      if (value!.isEmpty || value.length < 8) {
                        return ('smallPass'.tr());
                      } else if (pass.text != value) {
                        return ('passwordNotMatch'.tr());
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                DefaultButton(
                    text: "send".tr(),
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        AuthCubit.get(context).forgetPasswordRequest.token =
                            token.text;
                        AuthCubit.get(context).forgetPasswordRequest.password =
                            pass.text;
                        AuthCubit.get(context)
                            .forgetPasswordRequest
                            .passwordConfirmation = passComfirm.text;

                        AuthCubit.get(context).resetPassword();
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
