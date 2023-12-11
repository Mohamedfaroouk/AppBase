import 'package:efatorh/modules/client/domain/repository/endpoints.dart';

import '../../../../core/data_source/dio.dart';
import '../model/client_model.dart';

class ClientRepository {
  final DioService dioService;
  ClientRepository(this.dioService);

  Future<ClientModel?> list({Map<String, dynamic>? params}) async {
    final response = await dioService.getData(url: ClientEndPoints.get, query: params);
    if (response.isError == false) {
      return ClientModel.fromJson(response.response?.data);
    }
    return null;
  }

  Future store({required Client client}) async {
    final response = await dioService.postData(url: ClientEndPoints.add, loading: true, body: client.toJson());
    if (response.isError == false) {
      return response.response?.data;
    }
    return null;
  }

  Future update({required Client client}) async {
    final response = await dioService.putData(url: ClientEndPoints.update(client.id), loading: true, body: client.toJson());
    if (response.isError == false) {
      return response.response?.data;
    }
    return null;
  }

  Future delete({required int id}) async {
    final response = await dioService.deleteData(url: ClientEndPoints.delete(id), loading: true);
    if (response.isError == false) {
      return response.response?.data;
    }
    return null;
  }

  Future<ClientModel?> show({required int id}) async {
    final response = await dioService.postData(url: ClientEndPoints.show(id), loading: true);
    if (response.isError == false) {
      return ClientModel.fromJson(response.response?.data["data"]);
    }
    return null;
  }
}
