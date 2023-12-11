import 'package:easy_localization/easy_localization.dart';
import 'package:efatorh/core/utils/Utils.dart';
import 'package:efatorh/modules/splash/cubit/states.dart';
import 'package:efatorh/shared/widgets/customtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:efatorh/core/utils/extentions.dart';

import '../../../core/Router/Router.dart';
import '../../../core/services/navigation_service.dart';
import '../../../shared/widgets/animation_build_widget.dart';
import '../../auth/cubit/cubit.dart';
import '../cubit/cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // await Firebase.initializeApp(
      //   options: DefaultFirebaseOptions.currentPlatform,
      // );
      // await FcmNotification().init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SplashCubit()..navigateTo(),
        lazy: false,
        child:
            BlocConsumer<SplashCubit, SplashStates>(listener: (context, state) {
          if (state is NotLoginNoInBoardingState) {
            NavigationService.goNamed(Routes.onBoardingRoute);
          }
          if (state is NotLoginState) {
            NavigationService.goNamed(Routes.loginRoute);
          }
          if (state is LoginAndVerifiedState) {
            NavigationService.goNamed(Routes.cashier);
          }
          if (state is LoginNeedVerifyState) {
            // NavigationService.goNamed(Routes.cashier);
            // return;
            NavigationService.goNamed(Routes.otpScreen, extra: {
              "phone": Utils.user?.phone,
              "countryCode": Utils.user?.countryCode,
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
          if (state is SplashNetworkErrorState) {}
        }, builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: ExactAssetImage("splash".png("images")),
                    fit: BoxFit.cover,
                  )),
                  child: Container(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimationAppearanceOpacity(
                            duration: const Duration(milliseconds: 500),
                            child: InkWell(
                              onTap: () {
                                NavigationService.goNamed(
                                    Routes.onBoardingRoute);
                              },
                              child: Image(
                                image:
                                    AssetImage("logo_font_wight".png("images")),
                                fit: BoxFit.contain,
                                height: 120,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AnimationAppearanceOpacity(
                            delayed: const Duration(milliseconds: 800),
                            duration: const Duration(
                                milliseconds:
                                    1000), // default is 500 milliseconds
                            child: CustomText(
                              "easyPrintInvoices".tr(),
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                if (state is SplashNetworkErrorState)
                  Container(
                    height: 90,
                    alignment: Alignment.bottomCenter,
                    color: Colors.red,
                    child: ListTile(
                      trailing: IconButton(
                        onPressed: () {
                          SplashCubit.get(context).navigateTo();
                        },
                        icon: const Icon(
                          Icons.replay,
                          color: Colors.white,
                        ),
                      ),
                      tileColor: Colors.red,
                      title: CustomText(
                        "networkError".tr(),
                        color: Colors.white,
                        weight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          );
        }));
  }
}
