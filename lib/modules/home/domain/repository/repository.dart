import 'package:appbase/modules/home/domain/repository/endpoints.dart';

import '../../../../core/data_source/dio.dart';
import '../model/home_model.dart';

class HomeRepository {
  final DioService dioService;
  HomeRepository(this.dioService);

  Future<HomeModel?> list({Map<String, dynamic>? params}) async {
    final response =
        await dioService.getData(url: HomeEndPoints.get, query: params);
    if (response.isError == false) {
      return HomeModel.fromJson(response.response?.data["data"]);
    }
    return null;
  }

  Future store({required Home home}) async {
    final response = await dioService.postData(
        url: HomeEndPoints.add, loading: true, body: home.toJson());
    if (response.isError == false) {
      return response.response?.data;
    }
    return null;
  }

  Future update({required Home home}) async {
    final response = await dioService.putData(
        url: HomeEndPoints.update(home.id), loading: true, body: home.toJson());
    if (response.isError == false) {
      return response.response?.data;
    }
    return null;
  }

  Future delete({required int id}) async {
    final response = await dioService.deleteData(
        url: HomeEndPoints.delete(id), loading: true);
    if (response.isError == false) {
      return response.response?.data;
    }
    return null;
  }

  Future<Home?> show({required int id}) async {
    final response =
        await dioService.postData(url: HomeEndPoints.show(id), loading: true);
    if (response.isError == false) {
      return Home.fromJson(response.response?.data["data"]);
    }
    return null;
  }
}
