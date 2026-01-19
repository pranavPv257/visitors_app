import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ServerClient {
  static const int _timeout = 90;

  /// Get request

  static Future<List> get(String url, {BuildContext? context}) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "VOX-API-KEY": " Vm94ZWxWaXNpdG9yQm9vazIwMjU=",
    };

    try {
      var response = await http.get(Uri.parse(url), headers: headers).timeout(const Duration(seconds: _timeout));
      return _response(response, context);
    } on SocketException {
      return [600, "No internet"];
    } catch (e) {
      return [600, e.toString()];
    }
  }

  /// Post request

  static Future<List> post(String url, BuildContext context, {Map<String, dynamic>? data, bool post = true}) async {
    Map<String, String> headers = {"Content-Type": "application/json", "VOX-API-KEY": "Vm94ZWxWaXNpdG9yQm9vazIwMjU="};
    try {
      print(data);
      var body = json.encode(data);
      var response = await http
          .post(Uri.parse(url), body: post ? body : null, headers: headers)
          .timeout(const Duration(seconds: _timeout));
      print(response.body);
      return _response(response, context);
    } on SocketException {
      return [600, "No internet"];
    } catch (e) {
      print(e);
      return [600, e.toString()];
    }
  }

  /// Put request

  static Future<List> put(String url, BuildContext context, {Map<String, dynamic>? data, bool put = false}) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "country": "india",
    };

    try {
      String? body = json.encode(data);
      var response = await http
          .put(Uri.parse(url), body: put == false ? null : body, headers: headers)
          .timeout(const Duration(seconds: _timeout));
      return _response(response, context);
    } on SocketException {
      return [600, "No urbanistnet"];
    } catch (e) {
      return [600, e.toString()];
    }
  }

  /// Delete request

  static Future<List> delete(
    String url,
    BuildContext context, {
    bool delete = false,
    String? id,
    Map<String, dynamic>? data,
  }) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "country": "india",
      "authorization": "Bearer ",
    };
    String? jsonData = data != null ? json.encode(data) : null;

    var response = await http.delete(Uri.parse(url), headers: headers, body: delete == false ? null : jsonData);
    return await _response(response, context);
  }

  // ------------------- ERROR HANDLING ------------------- \\

  static Future<List> _response(http.Response response, BuildContext? context) async {
    print(jsonDecode(response.body));
    if (jsonDecode(response.body)["message"] == "Token not found") {}
    switch (response.statusCode) {
      case 200:
        return [response.statusCode, jsonDecode(response.body)];
      case 201:
        return [response.statusCode, jsonDecode(response.body)];
      case 400:
        return [response.statusCode, jsonDecode(response.body), jsonDecode(response.body)["message"]];
      case 401:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 403:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 404:
        return [response.statusCode, "You're using unregistered application"];
      case 500:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 502:
        return [response.statusCode, "Server Crashed or under maintenance"];
      case 503:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 504:
        return [
          response.statusCode,
          {"message": "Request timeout", "code": 504, "status": "Cancelled"},
        ];
      default:
        return [response.statusCode, jsonDecode(response.body)["message"]];
    }
  }
}
