import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registration_flutter/data/datasource/pref/pref_datasource.dart';

final prefDatasourceProvider = Provider<PrefDatasource>((ref) {
  return PrefDatasource();
});
