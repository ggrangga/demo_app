import 'dart:convert';

import 'package:demo_app/common/errors/omdb_api_error.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

@Bind.toType(OmdbWsClientImpl)
@injectable
abstract class OmdbWsClient extends BaseClient {}

typedef _PendingRequest = Future<Response> Function();

@lazySingleton
@injectable
class OmdbWsClientImpl extends OmdbWsClient {
  final Client _client;

  OmdbWsClientImpl(this._client);

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    return _client.send(request);
  }

  @override
  Future<Response> get(url, {Map<String, String> headers}) {
    return super.get(url, headers: headers);
  }

  @override
  Future<Response> post(url,
      {Map<String, dynamic> headers, body, Encoding encoding}) {
        print('url : $url, headers : $headers, body : $body');
    return _handleResponse(() =>
        super.post(url, headers: headers, body: body, encoding: encoding));
  }

  Future<Response> _handleResponse(_PendingRequest request) async {
      Response response = await request();
      if (response.statusCode >= 200 && response.statusCode < 300)
        return response;

    throw OmdbApiError(
      uri: response.request.url,
      code: response.statusCode,
      body: response.body,
      method: response.request.method,
    );
  }
}
