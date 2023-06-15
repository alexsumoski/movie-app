import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/models/app_config.dart';

class HTTPService {
  final Dio dio = Dio();
  final GetIt getIt = GetIt.instance;

  String? _base_url;
  String? _api_key;

  HTTPService() {
    AppConfig _config = getIt.get<AppConfig>();
    _base_url = _config.BASE_API_URL;
    _api_key = _config.API_KEY;
  }

  Future<Response?> get(String path, {Map<String, dynamic>? query}) async {
    try {
      String _url = '$_base_url$path';
      Map<String, dynamic> _query = {
        'api_key': _api_key,
        'language': 'en-US',
      };
      if (query != null) {
        _query.addAll(query);
      }
      return await dio.get(_url, queryParameters: _query);
    } on DioError catch (e) {
      print('DioError:$e');
    }
    return null;
  }
}
