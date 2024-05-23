import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiHandler{
  final String _baseUri = 'http://10.0.2.2:5058/api';
  final Map<String, String> _headers = {'Content-Type': 'application/json; charset=UTF-8'};

  Future<List<T>?> getAllByID<T>(String id, String apiPath, T Function(Map<String, dynamic>) fromJson) async {
    try {
      Uri uri = Uri.parse('$_baseUri/$apiPath/$id');
      http.Response response = await http.get(uri, headers: _headers);
      if (response.statusCode < 200 || response.statusCode > 299) return null;
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  Future<T?> getById<T>(String id, String apiPath, T Function(Map<String, dynamic>) fromJson) async {
    try {
      Uri uri = Uri.parse('$_baseUri/$apiPath/$id');
      http.Response response = await http.get(uri, headers: _headers);
      if(response.statusCode < 200 || response.statusCode > 299) return null;
      Map<String, dynamic> jsonData = json.decode(response.body);
      return fromJson(jsonData);
    } catch(e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  Future<http.Response?> createData(dynamic model, String apiPath) async {
    try{
      Uri uri = Uri.parse('$_baseUri/$apiPath');
      return await http.post(uri, headers: _headers, body: json.encode(model));
    } catch(e) {
      throw Exception('Failed to create data: $e');
    }
  }

  Future<bool> validateData(String apiPath, String validateBy, String id, String plainText) async {
    try {
      Uri uri = Uri.parse('$_baseUri/$apiPath/ValidateData?$validateBy=$id&dataToValidate=$plainText');
      http.Response response = await http.post(uri, headers: _headers);
      return response.statusCode == 200;
    } catch(e) {
      throw Exception('Failed to validate: $e');
    }
  }

  Future<String?> getDecryptedText(String apiPath, String id) async {
    try {
      Uri uri = Uri.parse('$_baseUri/$apiPath?id=$id');
      http.Response response = await http.get(uri, headers: _headers);
      if(response.statusCode < 200 || response.statusCode > 299) return null;
      return response.body;
    } catch(e) {
      throw Exception('Failed to get text: $e');
    }
  }
}