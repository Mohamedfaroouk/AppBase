import 'package:easy_localization/easy_localization.dart';
import 'package:appbase/modules/splash/cubit/states.dart';
import 'package:appbase/shared/widgets/customtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/Router/Router.dart';
import '../../../core/services/navigation_service.dart';
import '../../../shared/widgets/animation_build_widget.dart';
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
          if (state is GoHomeState) {
            NavigationService.goNamed(Routes.home);
          }
        }, builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  child: Container(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimationAppearanceOpacity(
                            duration: const Duration(milliseconds: 500),
                            child: InkWell(
                                onTap: () {}, child: const FlutterLogo()),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
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
