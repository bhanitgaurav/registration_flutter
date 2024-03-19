import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registration_flutter/data/repository/api/auth_repository_provider.dart';
import 'package:registration_flutter/models/joke/joke_model.dart';
import 'package:registration_flutter/provider/api/api_notifier.dart';

final apiProvider = StateNotifierProvider<ApiNotifier, JokeModel>((ref) {
  final repository = ref.watch(apiRepositoryProvider);
  return ApiNotifier(repository);
});
