import 'package:dio/dio.dart';

class API {
  final Dio _dio = Dio();

  API() {
    _dio.options.baseUrl = 'https://rickandmortyapi.com/api/';
  }

  Dio get sendRequest => _dio;
}
