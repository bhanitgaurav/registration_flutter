import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registration_flutter/data/repository/auth/auth_repository_provider.dart';
import 'package:registration_flutter/provider/auth/auth_notifier.dart';
import 'package:registration_flutter/provider/auth/auth_state.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});
