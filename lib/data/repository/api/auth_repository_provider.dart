import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registration_flutter/data/datasource/api/api_datasource_provider.dart';
import 'package:registration_flutter/data/repository/api/api_repository.dart';
import 'package:registration_flutter/data/repository/api/auth_repository_impl.dart';

final apiRepositoryProvider = Provider<ApiRepository>((ref) {
  final datasource = ref.read(apiDatasourceProvider);
  return ApiRepositoryImpl(datasource);
});
