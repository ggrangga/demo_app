import 'dart:convert';
import 'dart:io';

import 'package:demo_app/common/errors/api_error.dart';
import 'package:demo_app/data/datasources/session_manager.dart';
import 'package:demo_app/data/models/response_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

abstract class NetworkClient {
  Future<ResponseData> get(String url, {Map<String, String> headers});

  Future<ResponseData> post(String url,
      {Map<String, String> headers, body, Encoding encoding});
  

  Future<ResponseData> put(String url,
      {Map<String, String> header, body, Encoding encoding});

  Future<ResponseData> delete(String url, {Map<String, String> header});

  Future<http.Response> postMultipart(String url,
      {Map<String, String> headers,
      Map<String, String> body,
      String fileField,
      File file,
      Encoding encoding});
}

class NetworkClientImpl extends NetworkClient {
  final http.Client client;
  final SessionManager sessionManager;

  NetworkClientImpl({@required this.client, @required this.sessionManager});

  @override
  Future<ResponseData> get(String url, {Map<String, String> headers}) async {
    final uri = Uri.encodeFull(url);
    final request =
        () async => client.get(uri, headers: await _addServiceHeaders(headers));
    return _handleResponse(
        httpResponse: await request(), request: request, url: url);
  }

  @override
  Future<ResponseData> post(String url,
      {Map<String, String> headers, body, Encoding encoding}) async {
    final request = () async => client.post(Uri.encodeFull(url),
        headers: await _addServiceHeaders(headers),
        body: body,
        encoding: encoding);
    return _handleResponse(
      request: request,
      url: url,
      httpResponse: await request(),
      requestBody: body,
    );
  }

  @override
  Future<ResponseData> delete(String url, {Map<String, String> header}) async {
    final request = () async => client.delete(Uri.encodeFull(url),
        headers: await _addServiceHeaders(header));
    return _handleResponse(
        httpResponse: await request(), request: request, url: url);
  }

  @override
  Future<http.Response> postMultipart(String url,
      {Map<String, String> headers,
      Map<String, String> body,
      String fileField,
      File file,
      Encoding encoding}) {
    return null;
  }

  @override
  Future<ResponseData> put(String url,
      {Map<String, String> header, body, Encoding encoding}) async {
    final request = () async => client.put(Uri.encodeFull(url),
        headers: header, body: body, encoding: encoding);
    return _handleResponse(
        httpResponse: await request(),
        request: request,
        url: url,
        requestBody: body);
  }

  Future<String> _getAuthorizationToken() async {
    return (await sessionManager.getSession())?.token ?? '';
  }

  Future<Map<String, String>> _addServiceHeaders(
      Map<String, String> headers) async {
    final String token = await _getAuthorizationToken();
    final Map<String, String> resultHeaders = Map();
    if (token != null) resultHeaders[HttpHeaders.authorizationHeader] = token;
    if (headers != null) resultHeaders.addAll(headers);
    return resultHeaders;
  }

  bool _isTokenInvalid(http.Response httpResponse) {
    if (httpResponse.statusCode == 401) {
      return true;
    } else {
      return false;
    }
  }

  ResponseData _handleResponse(
      {@required http.Response httpResponse,
      @required final request,
      String url,
      final requestBody}) {
    if (httpResponse.statusCode >= 200 && httpResponse.statusCode < 300) {
      final ResponseData res =
          ResponseData.fromJson(json.decode(httpResponse.body));
      if (res?.data != null) {
        final bool hasError = res.error != null;
        if (!hasError) {
          return res;
        } else {
          if (!_isTokenInvalid(httpResponse)) {
            throw ApiError(
              message: res.error?.message ?? '',
              uri: Uri.parse(url),
              responseError: res.error,
              code: httpResponse.statusCode,
            );
          }
        }
      }
    }

    if (httpResponse.statusCode >= 400 && httpResponse.statusCode < 500) {
      final ResponseData res =
          ResponseData.fromJson(json.decode(httpResponse.body));
      if (!_isTokenInvalid(httpResponse)) {
        final error = res?.error;
        if (error != null) {
          throw ApiError(
            message: res.error?.message ?? '',
            uri: Uri.parse(url),
            responseError: error,
            code: httpResponse.statusCode,
          );
        }
      }
    }
    throw _getHttpError(httpResponse, url);
  }

  ApiError _getHttpError(
    http.Response response,
    String url, {
    String requestBody,
  }) {
    return ApiError(
      uri: Uri.parse(url),
      body: response.body,
      code: response.statusCode,
      message: response.reasonPhrase,
      method: response.request.method,
      requestBody: requestBody,
    );
  }
}
