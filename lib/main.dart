import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:efatorh/shared/widgets/reaponive_framwork_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:efatorh/core/data_source/hive_service.dart';
import 'package:efatorh/core/theme/app_theme.dart';
import 'package:efatorh/modules/auth/cubit/cubit.dart';
import 'package:efatorh/modules/layout/cubit/cubit.dart';
import 'package:efatorh/shared/general_cubit/cubit.dart';
import 'package:efatorh/shared/general_cubit/states.dart';

import 'core/Router/Router.dart';
import 'core/config/config.dart';
import 'core/utils/injection.dart';
import 'core/utils/Utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // bloc observer
  Bloc.observer = MyBlocObserver();
  HiveService().init();
  await setupLocator();
  Utils.getToken();
  runApp(EasyLocalization(
      startLocale: const Locale('ar', 'SA'),
      supportedLocales: const [
        Locale('ar', 'SA'),
        Locale('en', 'US'),
      ],
      saveLocale: true,
      path: 'assets/translations',
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var route = locator<Routes>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GeneralCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => LayoutCubit())
      ],
      child:
          BlocBuilder<GeneralCubit, GeneralStates>(builder: (context, state) {
        Utils.rebuildAllChildren(context);
        Utils.local = context.locale.languageCode;

        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: MaterialApp.router(
            scrollBehavior: MyCustomScrollBehavior(),
            title: '',
            builder: (_, child) {
              final botToastBuilder = BotToastInit();
              final smartDialog = FlutterSmartDialog.init();
              child = smartDialog(context, child);
              child = botToastBuilder(context, child);
              return AppResponsiveWrapper(
                child: child,
              );
            },
            debugShowCheckedModeBanner: false,
            locale: context.locale,

            theme: ThemesManger.appTheme,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            // darkTheme: appDarkTheme(),
            routeInformationProvider: route.goRouter.routeInformationProvider,
            routeInformationParser: route.goRouter.routeInformationParser,
            routerDelegate: route.goRouter.routerDelegate,
          ),
        );
      }),
    );
  }
}

// bloc observer
class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent -- ${bloc.runtimeType} -- $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType} -- $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition -- ${bloc.runtimeType} -- $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType} -- $error -- $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    print('onClose -- ${bloc.runtimeType}');
    super.onClose(bloc);
  }
}
