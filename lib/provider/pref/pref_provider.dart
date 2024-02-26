import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registration_flutter/data/repository/pref/pref_repository_provider.dart';
import 'package:registration_flutter/provider/auth/auth_state.dart';
import 'package:registration_flutter/provider/pref/pref_notifier.dart';

final prefProvider = StateNotifierProvider<PrefNotifier, AuthState>((ref) {
  final repository = ref.watch(prefRepositoryProvider);
  return PrefNotifier(repository);
});
