import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registration_flutter/data/datasource/auth/auth_datasource_provider.dart';
import 'package:registration_flutter/data/repository/auth/auth_repository.dart';
import 'package:registration_flutter/data/repository/auth/auth_repository_impl.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final datasource = ref.read(authDatasourceProvider);
  return AuthRepositoryImpl(datasource);
});
