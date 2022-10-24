import 'package:dio/dio.dart';
import 'package:netflix/service/api.dart';

class ApiService {
  final Api api = Api();
  final Dio dio = Dio();

  Future<Response> getData(String path, {Map<String, dynamic>? params}) async {
    String _url = api.baseUrl + path;
    Map<String, dynamic> query = {
      "api_key": api.apiKey,
      "language": "fr-FR",
    };

    if(params != null) {
      query.addAll(params);
    }

    final response = await dio.get(_url, queryParameters: query);

    if(response.statusCode == 200) {
      return response;
    }
    else {
      throw response;
    }
  }
}