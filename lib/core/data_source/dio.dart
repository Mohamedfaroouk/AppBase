import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:efatorh/core/Router/Router.dart';
import 'package:efatorh/core/services/navigation_service.dart';
import '../../shared/widgets/myLoading.dart';
import '../utils/Utils.dart';
import '../utils/alerts.dart';

class DioService {
  Dio _mydio = Dio();

  DioService([String baseUrl = "", BaseOptions? options]) {
    _mydio = Dio(
      options ??
          BaseOptions(
              headers: {
                "Accept": "application/json",
                'Content-Type': "application/json",
              },
              baseUrl: baseUrl,
              contentType: "application/json",
              receiveDataWhenStatusError: true,
              connectTimeout: const Duration(seconds: 30),
              receiveTimeout: const Duration(seconds: 30),
              sendTimeout: const Duration(seconds: 30)),
    )..interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestBody: true,
        ),
      );
  }

  Future<ApiResponse> postData({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    ResponseType? responseType,
    bool loading = false,
    bool isForm = false,
    bool showSnack = true,
  }) async {
    _mydio.options.headers["Authorization"] = 'Bearer ${Utils.token}';
    _mydio.options.headers["Accept-Language"] = Utils.local;

    try {
      if (loading) {
        MyLoading.show();
      }
      if (isForm) {
        log("form data");
        log(FormData.fromMap(body ?? {}).fields.toString());
      }
      final response = await _mydio.post(url,
          queryParameters: query,
          data: isForm ? FormData.fromMap(body ?? {}) : body,
          options: responseType != null
              ? Options(responseType: responseType)
              : null);
      if (loading) {
        MyLoading.dismis();
      }
      return ApiResponse(isError: false, response: response);
    } on DioException catch (e) {
      return getDioException(
        showSnack: showSnack,
        e: e,
      );
    }
  }

  Future<ApiResponse> putData({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    bool loading = false,
    bool isForm = false,
    bool showSnack = true,
  }) async {
    _mydio.options.headers["Authorization"] = 'Bearer ${Utils.token}';
    _mydio.options.headers["Accept-Language"] = Utils.local;

    try {
      if (loading) {
        MyLoading.show();
      }
      final response = await _mydio.put(url,
          queryParameters: query,
          data: isForm ? FormData.fromMap(body ?? {}) : body);
      if (loading) {
        MyLoading.dismis();
      }
      return ApiResponse(isError: false, response: response);
    } on DioException catch (e) {
      return getDioException(
        showSnack: showSnack,
        e: e,
      );
    }
  }

  Future<ApiResponse> deleteData({
    required String url,
    Map<String, dynamic>? query,
    bool loading = false,
    bool showSnack = true,
  }) async {
    _mydio.options.headers["Authorization"] = 'Bearer ${Utils.token}';
    _mydio.options.headers["Accept-Language"] = Utils.local;

    try {
      if (loading) {
        MyLoading.show();
      }
      final response = await _mydio.delete(url, queryParameters: query);
      if (loading) {
        MyLoading.dismis();
      }
      return ApiResponse(isError: false, response: response);
    } on DioException catch (e) {
      return getDioException(
        showSnack: showSnack,
        e: e,
      );
    }
  }

  Future<ApiResponse> getData({
    required String url,
    Map<String, dynamic>? query,
    ResponseType? responseType,
    bool loading = false,
    bool showSnack = true,
  }) async {
    _mydio.options.headers["Authorization"] = 'Bearer ${Utils.token}';
    _mydio.options.headers["Accept-Language"] = Utils.local;

    try {
      if (loading) {
        MyLoading.show();
      }
      final response = await _mydio.get(url,
          queryParameters: query,
          options: responseType != null
              ? Options(responseType: responseType)
              : null);
      if (loading) {
        MyLoading.dismis();
      }
      return ApiResponse(isError: false, response: response);
    } on DioException catch (e) {
      return getDioException(e: e, showSnack: showSnack);
    }
  }

  handleError(DioException e) {
    Alerts.snack(
        text: e.response?.data["message"] ?? "Unkown error",
        state: SnackState.failed);
  }

  getDioException({
    required DioException e,
    bool showSnack = true,
  }) {
    log("---------------autherrr");
    MyLoading.dismis();

    if (DioExceptionType.receiveTimeout == e.type ||
        DioExceptionType.connectionTimeout == e.type) {
      handleError(e);
    } else if (DioExceptionType.sendTimeout == e.type) {
      handleError(e);
    } else if (DioExceptionType.cancel == e.type) {
      handleError(e);
    } else if (DioExceptionType.badResponse == e.type) {
      if (e.response!.statusCode == 401) {
        Utils.removeToken();
        NavigationService.goNamed(Routes.loginRoute);
      } else {
        Alerts.snack(
            text: e.response?.data["message"] ?? "لا يمكن الوصول للسيرفير",
            state: SnackState.failed);
      }
    } else if (DioExceptionType.unknown == e.type) {
      if (e.message?.contains('SocketException') ?? false) {
        handleError(e);
      }
    } else {}
    return ApiResponse(isError: true, response: e.response);
  }
}

class ApiResponse {
  bool isError;
  Response? response;
  ApiResponse({this.response, required this.isError});
}
