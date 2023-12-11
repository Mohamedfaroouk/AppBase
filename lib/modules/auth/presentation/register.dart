import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/Router/Router.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/utils/validations.dart';
import '../../../shared/data/shared_repository.dart';
import '../../../shared/models/city.dart';
import '../../../shared/widgets/applogo.dart';
import '../../../shared/widgets/autocomplate.dart';
import '../../../shared/widgets/buttons.dart';
import '../../../shared/widgets/customtext.dart';
import '../../../shared/widgets/phone_textfield.dart';
import '../../../shared/widgets/textfield.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../domain/request/register_request.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //form
  final formKey = GlobalKey<FormState>();
  final RegisterRequest registerRequest = RegisterRequest();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
        if (state is AuthRegisterSuccess) {
          NavigationService.pushNamed(Routes.otpScreen, extra: {
            "phone": registerRequest.phone,
            "countryCode": registerRequest.countryCode,
            "sendOnStart": true,
            "onVerify": (String phone, String code, String otp) {
              AuthCubit.get(NavigationService.context)
                  .verifyOtp(phone: phone, countryCode: code, otp: otp);
            },
            "onReSend": (
              String phone,
              String code,
            ) {
              AuthCubit.get(NavigationService.context).sendOtp(
                phone: phone,
                countryCode: code,
              );
            },
          });
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('register'.tr()),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 700,
                ),
                child: Wrap(
                  children: [
                    //logo
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05),
                          const AppLogo(),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05),
                        ],
                      ),
                    ),

                    DefaultTextField(
                      label: 'username'.tr(),
                      showLabel: true,
                      flex: 1,
                      keyboardType: TextInputType.name,
                      validate: Validation.defaultValidation,
                      onSave: (s) {
                        registerRequest.name = s;
                      },
                    ),
                    PhoneNumberField(
                      validate: Validation.defaultValidation,
                      numberChange: (s) {
                        registerRequest.phone = s;
                      },
                      codeChange: (s) {
                        print(s);
                        registerRequest.countryCode = s;
                      },
                    ),
                    DefaultTextField(
                      label: 'emailHint'.tr(),
                      showLabel: true,
                      flex: 1,
                      keyboardType: TextInputType.emailAddress,
                      validate: Validation.emailValidation,
                      onSave: (s) {
                        registerRequest.email = s;
                      },
                    ),

                    CustomAutoCompleteTextField<Cites>(
                      lable: "city".tr(),
                      showLabel: true,
                      flex: 2,
                      itemAsString: (Cites s) => s.name ?? "",
                      onChanged: (s) {
                        registerRequest.cityId = s.id.toString();
                      },
                      searchInApi: false,
                      validator: Validation.defaultValidation,
                      function: (s) => SharedRepository.getCities(),
                    ),
                    DefaultTextField(
                      label: 'password'.tr(),
                      showLabel: true,
                      flex: 1,
                      keyboardType: TextInputType.visiblePassword,
                      onChange: (s) {
                        registerRequest.password = s;
                      },
                      onSave: (s) {
                        registerRequest.password = s;
                      },
                      validate: Validation.passwordValidation,
                    ),
                    DefaultTextField(
                      showLabel: true,
                      flex: 1,
                      label: 'confirmPassword'.tr(),
                      keyboardType: TextInputType.visiblePassword,
                      validate: (s) => Validation.confirmPasswordValidation(
                          s, registerRequest.password ?? ""),
                      onSave: (s) {},
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        DefaultButton(
                            text: 'register'.tr(),
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                AuthCubit.get(context)
                                    .register(registerRequest: registerRequest);
                              }
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            NavigationService.goNamed(Routes.loginRoute);
                          },
                          child: CustomText(
                            "haveAccount".tr(),
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
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
