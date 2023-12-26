import 'package:efatorh/core/utils/injection.dart';
import 'package:efatorh/modules/client/domain/model/client_model.dart';
import 'package:efatorh/shared/models/general_setting.dart';

import '../../core/data_source/dio.dart';
import '../../modules/auth/domain/model/user_model.dart';
import '../models/city.dart';

class SharedRepository {
  static DioService dioService = locator<DioService>();

  static Future<List<Cites>> getCities() async {
    final respose = await dioService.getData(url: "/cities");
    if (respose.isError == false) {
      return List<Cites>.from(
          respose.response?.data["data"].map((x) => Cites.fromJson(x)));
    }
    return [];
  }

  // get clients
  static Future<List<Client>> getClients({String? search}) async {
    final respose = await dioService.getData(
        url: "/getClient", query: {if (search != null) "search": search});

    if (respose.isError == false) {
      return List<Client>.from(
          respose.response?.data["data"].map((x) => Client.fromJson(x)));
    }
    return [];
  }

  static Future<GeneralSettings?> getGeneralSetting() async {
    final respose = await dioService.getData(url: "/general_setting");
    if (respose.isError == false) {
      return GeneralSettings.fromJson(respose.response?.data["data"]);
    }
    return null;
  }

  static Future<UserModel?> getUserData({bool loading = false}) async {
    final respose = await dioService.getData(url: "/me", loading: loading);
    if (respose.isError == false) {
      return UserModel.fromJson({"data": respose.response?.data});
    }
    return null;
  }
}
