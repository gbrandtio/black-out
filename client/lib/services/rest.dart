import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

/// ----------------------------------------------------------------------------
/// rest.dart
/// ----------------------------------------------------------------------------
/// Base service that implements all the common REST requests.
class Rest {
  /// Mandatory Req Headers for the outages requests.
  static const Map<String, String> outagesRequestHeaders = {
    ":authority:": "siteapps.deddie.gr",
    ":method:": "GET",
    ":scheme:": "https",
    "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
    "accept-encoding": "gzip, deflate, br",
    "accept-language": "en-US,en;q=0.9,el;q=0.8",
    "cache-control": "max-age=0",
    "sec-ch-ua": '"Google Chrome";v="111", "Not(A:Brand";v="8", "Chromium";v="111"',
    "sec-ch-ua-mobile": "?0",
    "sec-ch-ua-platform": "Windows",
    "sec-fetch-dest": "document",
    "sec-fetch-mode": "navigate",
    "sec-fetch-site": "none",
    "sec-fetch-user": "?1",
    "upgrade-insecure-requests": "1",
    "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36",
    "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
    "Access-Control-Allow-Origin": "https://black-out.vercel.app/#/",
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
