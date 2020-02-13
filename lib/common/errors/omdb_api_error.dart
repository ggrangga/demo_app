import 'dart:io';

class OmdbApiError extends HttpException{
  final int code;
  final String method;
  final String body;

  OmdbApiError({
    String message = 'OmdbApiError',
    this.code, 
    this.method, 
    this.body,
    Uri uri,
  }): super(message, uri : uri);

  String toString(){
    var b = StringBuffer()..write('OmdbApiError : ')..write(message);
    if(method != null)
      b..write('method : $method');
    if(code != null)
      b..write('method : $code');
    if(body != null)
      b..write(', body : $body');
    if(uri != null)
      b..write(', uri : $uri');
    return b.toString();
  }
}