import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

/// Base service that performs all the common REST requests.
class Rest {
  /// Mandatory Req Headers for the outages requests.
  static const Map<String, String> outagesRequestHeaders = {
    "Accept-Language": "en-US,en;q=0.9,el;q=0.8",
    "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
    "Access-Control-Allow-Origin": "*"
  };

  /// Mandatory Req Body for the outages request.
  static const Map<String, String> outagesRequestBody = {
    "X-Requested-With": "XMLHttpRequest"
  };

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
