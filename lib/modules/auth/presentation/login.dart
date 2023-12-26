import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/Router/Router.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/utils/validations.dart';
import '../../../shared/widgets/applogo.dart';
import '../../../shared/widgets/buttons.dart';
import '../../../shared/widgets/customtext.dart';
import '../../../shared/widgets/textfield.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

// form data
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
        if (state is AuthLoginSuccess) {
          NavigationService.goNamed(Routes.home);
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('login'.tr()),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 700,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.16),
                    const AppLogo(),
                    DefaultTextField(
                      flex: 1,
                      label: 'emailHint'.tr(),
                      controller: email,
                      showLabel: true,
                      hintText: "example@gmail.com",
                      keyboardType: TextInputType.emailAddress,
                      validate: Validation.emailValidation,
                    ),
                    DefaultTextField(
                      flex: 1,
                      label: 'password'.tr(),
                      controller: password,
                      showLabel: true,
                      keyboardType: TextInputType.visiblePassword,
                      // validate: Validation.passwordValidation,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DefaultButton(
                        text: 'login'.tr(),
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            AuthCubit.get(context).login(
                                email: email.text, password: password.text);
                          }
                        }),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: (() => NavigationService.pushNamed(
                              Routes.forgotPasswordRoute)),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomText(
                                "forgetPassword".tr(),
                                color: Colors.black,
                                fontSize: 18,
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        NavigationService.goNamed(Routes.registerRoute);
                      },
                      child: CustomText(
                        "newAccount".tr(),
                        weight: FontWeight.bold,
                      ),
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // CustomText(
                    //   "or".tr(),
                    //   color: Colors.black,
                    //   fontSize: 18,
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // SizedBox(
                    //     width: 300,
                    //     child: DefaultButtonOutLined(
                    //         onTap: () {
                    //           Navigator.pushNamed(context, Routes.registerWithPhone);
                    //         },
                    //         text: "guestLogin".tr())),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
