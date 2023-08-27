import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  // final AuthRepository authRepository = AuthRepository();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // options.headers['X-Parse-Session-Token'] =
    //     'r:7d618fd5b9d890d3231516ba3d11b129';
    handler.next(options);
  }
}
