import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

///Base service that performs all the common REST requests.
class Rest{

  ///Performs a POST request.
  ///url: The url to perform the request to.
  ///headers: The headers of the request (must include the authentication key for all the requests).
  ///body: The body of the request. 
  Future<Response> doPOST(String url, Map<String,String> headers, dynamic body) async{
    return http.post(Uri.parse(url),
      headers: headers,
      body: jsonEncode(body)
      ,);
  }

  ///Performs a PUT request.
  ///url: The url to perform the request to.
  ///headers: The headers of the request (must include the authentication key for all the requests).
  ///body: The body of the request.
  Future<Response> doPUT(String url, Map<String,String> headers, dynamic body) async{
    return http.put(url, headers: headers, body: jsonEncode(body));
  }
  
  ///Performs a GET request.
  ///url: The url to perform the request to.
  ///headers: The headers of the request (must include the authentication key for all the requests).
  Future<Response> doGET(dynamic url, Map<String, String> headers) async{
    return http.get(url, headers: headers);
  }

  ///Performs a DELETE request.
  ///url: The url to perform the request to.
  ///headers: The headers of the request (must include the authentication key for all the requests).
  Future<Response> doDELETE(dynamic url, Map<String, String> headers) async{
    return http.delete(url, headers: headers);
  }
}