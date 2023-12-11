import 'dart:io';

import 'package:efatorh/core/utils/Utils.dart';
import 'package:efatorh/shared/data/shared_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:version/version.dart';
import 'states.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitial());
  static LayoutCubit get(context) => BlocProvider.of(context);

  getStoreSetting() async {
    final response = await SharedRepository.getStoreSetting();
    if (response != null) {
      Utils.storeSettings = response;
    }
  }

  getGeneralSetting() async {
    final response = await SharedRepository.getGeneralSetting();
    if (response != null) {
      Utils.generalSettings = response;

      if (Utils.generalSettings.maintenanceMode == true) {
        emit(MaintenanceModeStatus());
        return;
      }
      if (!Platform.isWindows) {
        final lastVersion = Version.parse(Platform.isAndroid
            ? (Utils.generalSettings.androidVersion ?? "")
            : (Utils.generalSettings.iosVersion ?? ""));

        final packageInfo = await PackageInfo.fromPlatform();
        final currentVersion = Version.parse(packageInfo.version);
        print("vvvv${currentVersion < lastVersion}");

        if (currentVersion < lastVersion) {
          emit(NeedUpdateStatus());
          return;
        }
      }

      if (Utils.generalSettings.maintenanceMode == true) {
        emit(MaintenanceModeStatus());
        return;
      }
      if (Utils.generalSettings.introPdf != null ||
          Utils.generalSettings.introVideo != null) {
        if (Utils.pref().userGuid == false) {
          emit(NeedUserGuidStatus());
        }
      }
    }
  }

  refresh() {
    emit(LayoutRefresh());
  }
}
