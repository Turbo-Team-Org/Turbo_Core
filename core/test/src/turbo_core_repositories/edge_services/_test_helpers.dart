import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void registerEdgeFallbacks() {
  registerFallbackValue(<String, dynamic>{});
  registerFallbackValue(<String, Object?>{});
  registerFallbackValue(RequestOptions(path: '/'));
}

Response<T> okResponse<T>(T data, {String path = '/'}) {
  return Response<T>(
    data: data,
    statusCode: 200,
    requestOptions: RequestOptions(path: path),
  );
}
