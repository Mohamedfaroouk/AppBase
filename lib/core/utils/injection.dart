import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:appbase/core/Router/Router.dart';
import 'package:appbase/modules/auth/domain/repository/repository.dart';

import '../config/key.dart';
import '../data_source/PrefService.dart';
import '../data_source/dio.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  var prefInstance = await PrefService.getInstance();
  locator.registerSingleton<PrefService>(prefInstance);
  locator.registerLazySingleton(() => GlobalKey<ScaffoldState>());
  locator.registerLazySingleton(() => GlobalKey<NavigatorState>());

  locator.registerLazySingleton(() => DioService(ConstKeys.baseUrl));
  locator.registerLazySingleton(() => DioService(ConstKeys.moyaser),
      instanceName: "moyaser");
  locator.registerLazySingleton(() => Routes());

  // repo locator
  locator.registerLazySingleton(() => AuthRepository(locator<DioService>()));
}
