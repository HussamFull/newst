import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newst/core/remote_source/ApiConfing.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  ApiService._internal();

  final String apiKey = ApiConfig.apiKey;

  Future<dynamic> get(String endpoint, {Map<String, String>? params}) async {
    var url = Uri.https(ApiConfig.baseUrl, endpoint, {
      'apiKey': ApiConfig.apiKey,
      ...?params,
    });

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  ///final http.Response response = await http.get(url);
}
