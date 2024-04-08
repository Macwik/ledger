import 'dart:convert';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:ledger/config/config.dart';
import 'package:ledger/http/base_entity.dart';
import 'package:ledger/http/base_page_entity.dart';
import 'package:ledger/http/error_handle.dart';
import 'package:ledger/http/interceptors.dart';
import 'package:ledger/modules/login/login_verify/login_verify_controller.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/store/store_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:ledger/util/logger_util.dart';
import 'package:path_provider/path_provider.dart';

import 'connectivity_utils.dart';

Duration _connectTimeout = Duration(seconds: 15);
Duration _receiveTimeout = Duration(seconds: 15);
Duration _sendTimeout = Duration(seconds: 10);
String _baseUrl = Constant.SERVICE_API_URL;

class Http {
  factory Http() => _singleton;

  /// Cookie
  static CookieJar? _cookieJar;

  static FileStorage? _fileStorage;

  Http._() {
    final BaseOptions options = BaseOptions(
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      sendTimeout: _sendTimeout,
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
      validateStatus: (_) {
        return true;
      },
      baseUrl: _baseUrl,
    );
    _dio = Dio(options);
    interceptors(dio);
    if (GlobalConfig.isDebug) {
      openLog();
    }
  }

  /// 打开日志
  void openLog() {
    _dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
  }

  /// 清除Cookie
  Future<void> clearCookie() async {
    await _cookieJar?.deleteAll();
  }

  static final Http _singleton = Http._();

  static Http get instance => Http();

  static late Dio _dio;

  Dio get dio => _dio;

  ///await/async方式
  Future<BasePageEntity<T>> networkPage<T>(
    Method method,
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    /// Cookie
    initCookieFilter();
    try {
      /// 请求前先检查网络连接
      var connectivityState = await ConnectivityUtils.checkConnectivity();
      // LoggerUtil.d('DioUtil ==> checkConnectivity $connectivityState');
      if (connectivityState == ConnectivityState.none) {
        // 延迟1秒 显示加载loading
        await Future.delayed(const Duration(seconds: 1));
        Get.snackbar('提示', '网络异常，请检查你的网络');
        //throw ResultException(90005, '网络异常，请检查你的网络');
      }
      final result = await _requestPageWork<T>(
        method.value,
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      if (result.c == 401) {
        if (!Get.isRegistered<LoginVerifyController>()) {
          await StoreController.to.signOut();
          Get.offAllNamed(RouteConfig.loginVerify);
        }
      }
      return result;
    } catch (e) {
      _cancelLogPrint(e, url);
      final NetError error = ExceptionHandle.handleException(e);
      return BasePageEntity(error.code ?? ExceptionHandle.unknown_error,
          error.msg ?? '未知异常', null);
    }
  }

  ///await/async方式
  Future<BaseEntity<T>> network<T>(
    Method method,
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    /// Cookie
    initCookieFilter();
    try {
      /// 请求前先检查网络连接
      var connectivityState = await ConnectivityUtils.checkConnectivity();
      // LoggerUtil.d('DioUtil ==> checkConnectivity $connectivityState');
      if (connectivityState == ConnectivityState.none) {
        // 延迟1秒 显示加载loading
        await Future.delayed(const Duration(seconds: 1));
        Get.snackbar('提示', '网络异常，请检查你的网络');
        //throw ResultException(90005, '网络异常，请检查你的网络');
      }
      final result = await _requestWork<T>(
        method.value,
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      if (result.c == 401) {
        if (!Get.isRegistered<LoginVerifyController>()) {
          await StoreController.to.signOut();
          Get.offAllNamed(RouteConfig.loginVerify);
        }
      }
      return result;
    } catch (e) {
      _cancelLogPrint(e, url);
      final NetError error = ExceptionHandle.handleException(e);
      return BaseEntity(error.code ?? ExceptionHandle.unknown_error,
          error.msg ?? '未知异常', null);
    }
  }

  // 数据返回格式统一，统一处理异常
  Future<BaseEntity<T>> _requestWork<T>(
    String method,
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    final Response<String> response = await _dio.request<String>(
      url,
      data: data,
      queryParameters: queryParameters,
      options: _checkOptions(method, options, url),
      cancelToken: cancelToken,
    );
    try {
      final String data = response.data.toString();
      final bool isCompute = data.length > 10 * 1024;
      final Map<String, dynamic> map =
          isCompute ? await compute(parseData, data) : parseData(data);
      return BaseEntity<T>.fromJson(map);
    } catch (e) {
      debugPrint(e.toString());
      return BaseEntity<T>(ExceptionHandle.parse_error, '网络开小差了...', null);
    }
  }

  // 数据返回格式统一，统一处理异常
  Future<BasePageEntity<T>> _requestPageWork<T>(
    String method,
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    final Response<String> response = await _dio.request<String>(
      url,
      data: data,
      queryParameters: queryParameters,
      options: _checkOptions(method, options, url),
      cancelToken: cancelToken,
    );
    try {
      final String data = response.data.toString();
      final bool isCompute = data.length > 10 * 1024;
      final Map<String, dynamic> map =
          isCompute ? await compute(parseData, data) : parseData(data);
      return BasePageEntity<T>.fromJson(map);
    } catch (e) {
      debugPrint(e.toString());
      return BasePageEntity<T>(ExceptionHandle.parse_error, '网络开小差了...', null);
    }
  }

  Options _checkOptions(String method, Options? options, String path) {
    options ??= Options();
    options.method = method;
    return options;
  }

  void _cancelLogPrint(dynamic e, String url) {
    if (e is DioException && CancelToken.isCancel(e)) {
      print('取消请求接口： $url');
    }
  }

  /// 判断是否有cookie
  Future<bool> hasCookie() async {
    await initCookieJar();
    List<Cookie>? cookies =
        await _cookieJar?.loadForRequest(Uri.parse(Constant.SERVICE_API_URL));
    return (cookies != null) && cookies.isNotEmpty;
  }

  bool hasActiveLedger() {
    return StoreController.to.getActiveLedgerId() != null;
  }

  /// 初始化Cookie
  Future initCookieFilter() async {
    await initCookieJar();
    var ledgerId = StoreController.to.getActiveLedgerId();
    if (null != ledgerId) {
      _dio.options.headers[Constant.LEDGER] = ledgerId;
    }
  }

  static Future<void> initCookieJar() async {
    if (null == _fileStorage) {
      final directory = await getApplicationDocumentsDirectory();
      String currentDirectory = directory.path;
      _fileStorage = FileStorage(currentDirectory);
      _fileStorage?.init(true, false);
    }
    if (null == _cookieJar) {
      _cookieJar = PersistCookieJar(storage: _fileStorage);
      _dio.interceptors.add(CookieManager(_cookieJar!));
    }
  }
}

/// 解析数据
Map<String, dynamic> parseData(String data) {
  return json.decode(data) as Map<String, dynamic>;
}

enum Method { get, post, put, patch, delete, head }

/// 使用拓展枚举替代 switch判断取值
extension MethodExtension on Method {
  String get value => ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'HEAD'][index];
}
