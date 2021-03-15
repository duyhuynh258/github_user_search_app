import 'package:dio/dio.dart' as dio;
import 'package:github_user_search_app/infrastructure/log/logger.dart';
import 'package:github_user_search_app/infrastructure/network/dio/dio_github_interceptors.dart';
import 'package:github_user_search_app/infrastructure/network/network.dart';
import 'package:injectable/injectable.dart';

abstract class GithubClientDelegate {
  void didRefreshToken(String accessToken, String refreshToken, int accessTokenExpiresIn);
}

abstract class NetworkExecutor {
  String baseURL;

  void clearTokenAndClearRequests();

  void setToken({String accessToken, String refreshToken});

  void setDefaultHeader(String key, String value);

  Future<dio.Response> requestWith(Request request);
}

@Injectable(as: ApiClient)
class GithubApiClient extends ApiClient implements DioGithubInterceptorsDidRefreshToken, NetworkExecutor {
  DioGithubInterceptors oauth2Interceptor;

  // CacheInterceptors _cacheInterceptors;

  @override
  void setToken({String accessToken, String refreshToken}) {
    oauth2Interceptor.accessToken = accessToken;
    oauth2Interceptor.refreshToken = refreshToken;
    oauth2Interceptor.previous = client;
    oauth2Interceptor.delegate = this;
  }

  @override
  void clearTokenAndClearRequests() {
    cancelRequests();
    _clearToken();
  }

  void _clearToken() {
    oauth2Interceptor.accessToken = null;
    oauth2Interceptor.refreshToken = null;
  }

  GithubApiClient(String baseURL)
      : super(
          baseURL: baseURL,
          requestTimeout: const Duration(seconds: 10),
          interceptors: [],
        );

  @override
  void didRefreshToken(String accessToken, String refreshToken, int accessTokenExpiresIn) {
    Logger.logInfo("AccessToken did refresh: $accessToken");
    // TODO: implement didRefreshToken
  }

  @override
  String baseURL;

  @override
  Future<dio.Response> requestWith(Request request) {
    // TODO: implement requestWith
    throw UnimplementedError();
  }

  @override
  void setDefaultHeader(String key, String value) {
    // TODO: implement setDefaultHeader
  }
}
