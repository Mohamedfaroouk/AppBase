import 'package:easy_localization/easy_localization.dart';
import 'package:appbase/core/Router/Router.dart';
import 'package:appbase/core/utils/Utils.dart';
import 'package:appbase/modules/auth/cubit/cubit.dart';
import 'package:appbase/shared/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/navigation_service.dart';
import '../../../core/theme/dynamic_theme/colors.dart';
import '../../../core/utils/validations.dart';
import '../../../shared/widgets/applogo.dart';
import '../../../shared/widgets/buttons.dart';
import '../../../shared/widgets/customtext.dart';
import '../../../shared/widgets/phone_textfield.dart';
import '../../../shared/widgets/toggle_widget.dart';
import '../cubit/states.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? phone;
  String? code;
  bool isEmail = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text("restPassword".tr()),
        ),
        body: BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
          if (state is AuthForgetPasswordSuccess) {
            NavigationService.pushNamed(Routes.changePassword);
          }
        }, builder: (context, state) {
          return Container(
            constraints: const BoxConstraints.expand(),
            padding: const EdgeInsets.only(top: 60),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const AppLogo(),
                    const SizedBox(height: 40),
                    ToggleWidget(
                        selectedType: isEmail,
                        onChange: (s) {
                          setState(() {
                            isEmail = s;
                          });
                          if (isEmail) {
                            code = null;
                            phone = null;
                          } else {
                            email = null;
                          }
                        },
                        secondTitle: "phone".tr(),
                        firstTitle: "emailHint".tr()),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 28, right: 28, top: 20),
                      child: Builder(
                        builder: (context) {
                          return Column(
                            children: [
                              if (isEmail)
                                DefaultTextField(
                                    flex: 1,
                                    keyboardType: TextInputType.emailAddress,
                                    hintText: 'emailHint'.tr(),
                                    showLabel: true,
                                    onSave: (p0) {
                                      email = p0;
                                    },
                                    label: 'emailHint'.tr(),
                                    validate: Validation.emailValidation)
                              else
                                PhoneNumberField(
                                  validate: Validation.defaultValidation,
                                  numberChange: (s) {
                                    phone = s;
                                  },
                                  codeChange: (s) {
                                    code = s;
                                  },
                                ),
                              const SizedBox(
                                height: 10,
                              ),
                              DefaultButton(
                                  text: "send".tr(),
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState?.save();
                                      AuthCubit.get(context).forgetPassword(
                                          email: email,
                                          countryCode: code,
                                          phone: phone.removeZero);
                                    }
                                  }),
                              const SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                  child: CustomText(
                                    "requestHelp".tr(),
                                    color: AppColors.primary,
                                  ),
                                  onPressed: () {
                                    Utils.requestHelp();
                                  })
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
