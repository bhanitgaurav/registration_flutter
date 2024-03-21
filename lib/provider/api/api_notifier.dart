import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registration_flutter/data/datasource/api/api_datasource.dart';
import 'package:registration_flutter/data/models/user.dart';
import 'package:registration_flutter/data/repository/api/api_repository.dart';
import 'package:registration_flutter/models/joke/joke_model.dart';

class ApiNotifier extends StateNotifier<JokeModel> {
  String get _tag {
    return runtimeType.toString();
  }

  final ApiRepository _repository;

  ApiNotifier(this._repository) : super(const JokeModel());

  EitherResponse<JokeModel> fetchJokesApiRequest(User user) async {
    return await _repository.fetchJokesApiRequest();
  }

  EitherResponse<JokeModel> generateOtp(String mobileNumber) async {
    return await _repository.fetchJokesApiRequest();
  }

  EitherResponse<JokeModel> verifyOtp(String otp) async {
    return await _repository.fetchJokesApiRequest();
  }
}
