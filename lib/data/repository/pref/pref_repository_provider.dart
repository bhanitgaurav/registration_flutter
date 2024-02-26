import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registration_flutter/data/datasource/pref/pref_datasource_provider.dart';
import 'package:registration_flutter/data/repository/pref/pref_repository.dart';
import 'package:registration_flutter/data/repository/pref/pref_repository_impl.dart';

final prefRepositoryProvider = Provider<PrefRepository>((ref) {
  final datasource = ref.read(prefDatasourceProvider);
  return PrefRepositoryImpl(datasource);
});
