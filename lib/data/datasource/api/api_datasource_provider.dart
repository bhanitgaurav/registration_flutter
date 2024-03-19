import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registration_flutter/data/datasource/api/api_datasource.dart';

import '../../../network/dio_client.dart';

final dioInstanceProvider = Provider<Dio>((ref) {
  return Dio();
});

final dioClientProvider = Provider<DioClient>((ref) {
  final dio = ref.watch(dioInstanceProvider);
  return DioClient(dio);
});

final apiDatasourceProvider = Provider<ApiDataSource>((ref) {
  return ApiDataSource(ref.read(dioClientProvider));
});
