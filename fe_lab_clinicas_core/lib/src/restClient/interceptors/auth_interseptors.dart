import 'package:dio/dio.dart';
import 'package:fe_lab_clinicas_core/src/constants/local_storage_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class AuthInterseptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final RequestOptions(:headers, :extra) = options;
    const authHeaderKey = 'Authorization';

    headers.remove(authHeaderKey);

    if (extra case {'DIO_AUTH_KEY': true}) {
      final sharedPreferences = await SharedPreferences.getInstance();

      headers.addAll({
        authHeaderKey:
            'Bearer ${sharedPreferences.getString(LocalStorageConstant.accessToken)}',
      });
    }

    handler.next(options);

    super.onRequest(options, handler);
  }
}
