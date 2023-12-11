import 'package:efatorh/modules/<FTName | snakecase>/domain/repository/endpoints.dart';

import '../../../../core/data_source/dio.dart';
import '../model/<FTName | snakecase>_model.dart';

class <FTName | pascalcase>Repository {
  final DioService dioService;
  <FTName | pascalcase>Repository(this.dioService);

  Future<<FTName | pascalcase>Model?> list({Map<String, dynamic>? params}) async {
    final response = await dioService.getData(url: <FTName | pascalcase>EndPoints.get, query: params);
    if (response.isError == false) {
      return <FTName | pascalcase>Model.fromJson(response.response?.data["data"]);
    }
    return null;
  }

  Future store({required <FTName | pascalcase> <FTName | camelcase>}) async {
    final response = await dioService.postData(url: <FTName | pascalcase>EndPoints.add, loading: true, body: <FTName | camelcase>.toJson());
    if (response.isError == false) {
      return response.response?.data;
    }
    return null;
  }

  Future update({required <FTName | pascalcase> <FTName | camelcase>}) async {
    final response = await dioService.putData(url: <FTName | pascalcase>EndPoints.update(<FTName | camelcase>.id), loading: true, body: <FTName | camelcase>.toJson());
    if (response.isError == false) {
      return response.response?.data;
    }
    return null;
  }

  Future delete({required int id}) async {
    final response = await dioService.deleteData(url: <FTName | pascalcase>EndPoints.delete(id), loading: true);
    if (response.isError == false) {
      return response.response?.data;
    }
    return null;
  }

  Future<<FTName | pascalcase>?> show({required int id}) async {
    final response = await dioService.postData(url: <FTName | pascalcase>EndPoints.show(id), loading: true);
    if (response.isError == false) {
      return <FTName | pascalcase>.fromJson(response.response?.data["data"]);
    }
    return null;
  }
}
