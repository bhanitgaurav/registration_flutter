import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registration_flutter/data/datasource/auth/auth_datasource.dart';

final authDatasourceProvider = Provider<AuthDatasource>((ref) {
  return AuthDatasource();
});
