import 'package:easy_localization/easy_localization.dart';
import 'package:appbase/core/Router/Router.dart';
import 'package:appbase/core/services/navigation_service.dart';
import 'package:appbase/core/utils/Utils.dart';
import 'package:appbase/modules/auth/cubit/cubit.dart';
import 'package:appbase/modules/auth/cubit/states.dart';
import 'package:appbase/shared/widgets/customtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/validations.dart';
import '../../../shared/widgets/applogo.dart';
import '../../../shared/widgets/buttons.dart';
import '../../../shared/widgets/phone_textfield.dart';

class ChangePhoneScreen extends StatefulWidget {
  const ChangePhoneScreen({Key? key}) : super(key: key);

  @override
  _ChangePhoneScreenState createState() => _ChangePhoneScreenState();
}

class _ChangePhoneScreenState extends State<ChangePhoneScreen> {
  final _formKey = GlobalKey<FormState>();
  String? phone;
  String? code;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Text("changePhone".tr()),
              ),
              body: Container(
                padding: const EdgeInsets.only(top: 60),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const AppLogo(),
                        const SizedBox(height: 40),
                        Padding(
                            padding: const EdgeInsets.only(left: 28, right: 28),
                            child: Column(
                              children: [
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
                                  height: 20,
                                ),
                                DefaultButton(
                                    text: "send".tr(),
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        context.pop({
                                          "phone": phone.removeZero,
                                          "countryCode": code
                                        });
                                      }
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  onPressed: () {
                                    NavigationService.goNamed(
                                        Routes.loginRoute);
                                  },
                                  child: CustomText(
                                    "backToLogin".tr(),
                                  ),
                                )
                              ],
                            )),
                        const SizedBox(
                          height: 28,
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}
