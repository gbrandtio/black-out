import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

/// ----------------------------------------------------------------------------
/// rest_service.dart
/// ----------------------------------------------------------------------------
/// Base service that implements all the common REST requests.
class RestService {
  /// Performs a POST request.
  /// url: The url to perform the request to.
  /// headers: The headers of the request (must include the authentication key for all the requests).
  /// body: The body of the request.
  static Future<Response> doPOST(
      String url, Map<String, String> headers, Map<String, String> body) async {
    return http.post(Uri.parse(url), headers: headers, body: jsonEncode(body));
  }

  /// Performs a PUT request.
  /// url: The url to perform the request to.
  /// headers: The headers of the request (must include the authentication key for all the requests).
  /// body: The body of the request.
  static Future<Response> doPUT(
      String url, Map<String, String> headers, dynamic body) async {
    return http.put(Uri.parse(url), headers: headers, body: jsonEncode(body));
  }

  /// Performs a GET request.
  /// url: The url to perform the request to.
  /// headers: The headers of the request (must include the authentication key for all the requests).
  static Future<Response> doGET(String url, Map<String, String> headers) async {
    return http.get(Uri.parse(url), headers: headers);
  }

  /// Performs a DELETE request.
  /// url: The url to perform the request to.
  /// headers: The headers of the request (must include the authentication key for all the requests).
  static Future<Response> doDELETE(
      String url, Map<String, String> headers) async {
    return http.delete(Uri.parse(url), headers: headers);
  }
}
