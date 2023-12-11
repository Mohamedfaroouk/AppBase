import 'dart:async';

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../../core/Router/Router.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/theme/dynamic_theme/colors.dart';
import '../../../core/utils/Utils.dart';
import '../../../core/utils/alerts.dart';
import '../../../shared/widgets/applogo.dart';
import '../../../shared/widgets/buttons.dart';
import '../../../shared/widgets/customtext.dart';

class Otpscreen extends StatefulWidget {
  const Otpscreen(
      {Key? key,
      required this.phone,
      required this.code,
      required this.onVerify,
      this.sendOnStart,
      this.routeForBack,
      required this.onReSend})
      : super(key: key);
  final String phone;
  final String code;
  final Function(String phone, String code, String otp) onVerify;
  final Function(String phone, String code) onReSend;
  final bool? sendOnStart;
  final String? routeForBack;
  @override
  _OtpscreenState createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  Timer? timer;
  int seconds = 30;
  String phone = "";
  String code = "";
  @override
  void initState() {
    phone = widget.phone;
    code = widget.code;
    if (widget.sendOnStart == true) {
      widget.onReSend.call(
        widget.phone,
        widget.code,
      );
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      timer = Timer.periodic(const Duration(seconds: 1), (s) {
        if (seconds != 0) {
          seconds--;
          setState(() {});
        } else {
          timer!.cancel();
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  final TextEditingController _pinOTPController = TextEditingController();

  final FocusNode _pinOTPCodeFocus = FocusNode();

  String? verificationCode;

  final BoxDecoration pinOTPCodeDecoration = BoxDecoration(
    color: Colors.transparent,
    borderRadius: BorderRadius.circular(5),
    border: Border.all(
      color: AppColors.primary,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: widget.routeForBack != null
              ? IconButton(
                  onPressed: () {
                    NavigationService.goNamed(widget.routeForBack!);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.primary,
                  ))
              : null,
          title: Text("confirmMobile".tr())),
      body: Form(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 80,
                  ),
                  const AppLogo(),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomText(
                    "confirmMobileCode".tr(),
                    weight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        widget.phone,
                        weight: FontWeight.bold,
                      ),
                      TextButton(
                        onPressed: () async {
                          final newPhone =
                              await NavigationService.pushNamed<Map>(
                                  Routes.changePhoneScreen);
                          if (newPhone != null) {
                            if (context.mounted) {
                              context.replaceNamed(Routes.otpScreen, extra: {
                                "phone": newPhone["phone"],
                                "countryCode": newPhone["countryCode"],
                                "onVerify": widget.onVerify,
                                "onReSend": widget.onReSend,
                                "sendOnStart": true
                              });
                              widget.onReSend.call(
                                  newPhone["phone"], newPhone["countryCode"]);
                            }
                          }
                        },
                        child: CustomText(
                          "change".tr(),
                          color: AppColors.primary,
                        ),
                      )
                    ],
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Pinput(
                        androidSmsAutofillMethod:
                            AndroidSmsAutofillMethod.smsUserConsentApi,
                        // smsCodeMatcher: d,
                        length: 4,
                        autofocus: true,
                        onClipboardFound: (s) {},

                        focusNode: _pinOTPCodeFocus,
                        controller: _pinOTPController,
                        defaultPinTheme: PinTheme(
                            textStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 16,
                            ),
                            width: 40.0,
                            height: 40.0,
                            decoration: pinOTPCodeDecoration),
                        pinAnimationType: PinAnimationType.rotation,
                        onCompleted: (pin) async {
                          print("222$pin");
                          widget.onVerify.call(phone, code, pin);
                        },
                        onChanged: (s) {
                          verificationCode = s;
                        },
                      ),
                    ),
                  ),
                  if (seconds != 0)
                    Text(
                      seconds.toString(),
                    ),
                  InkWell(
                      onTap: seconds != 0
                          ? null
                          : () async {
                              widget.onReSend.call(
                                widget.phone,
                                widget.code,
                              );
                              seconds = 30;
                              setState(() {});
                              timer = Timer.periodic(const Duration(seconds: 1),
                                  (s) {
                                if (seconds != 0) {
                                  seconds--;
                                  setState(() {});
                                } else {
                                  timer!.cancel();
                                }
                              });
                            },
                      child: Card(
                          elevation: 0,
                          color: seconds == 0
                              ? AppColors.primary.withOpacity(0.3)
                              : Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(
                              "reSendCode".tr(),
                              color: AppColors.primary,
                              weight: FontWeight.w600,
                            ),
                          ))),
                  const SizedBox(
                    height: 20,
                  ),
                  DefaultButton(
                      text: "confirmCode".tr(),
                      onTap: () {
                        if (_pinOTPController.text.isNotEmpty) {
                          widget.onVerify
                              .call(phone, code, _pinOTPController.text);
                        } else {
                          Alerts.snack(
                              text: "confirmCodeRequired".tr(),
                              state: SnackState.failed);
                        }
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      child: CustomText(
                        "requestHelp".tr(),
                        color: AppColors.primary,
                        weight: FontWeight.w600,
                      ),
                      onPressed: () {
                        Utils.requestHelp();
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
