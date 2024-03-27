import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import 'package:registration_flutter/data/datasource/api/api_datasource.dart';
import 'package:registration_flutter/data/repository/api/api_repository.dart';
import 'package:registration_flutter/models/joke/joke_model.dart';

class ApiRepositoryImpl implements ApiRepository {
  final ApiDataSource _apiSource;

  ApiRepositoryImpl(this._apiSource);

  String get _tag {
    return runtimeType.toString();
  }

  @override
  EitherResponse<JokeModel> fetchJokesApiRequest() async {
    final result = await _apiSource.fetchJokesApiRequest();
    return result.fold((l) => left(l), (r) {
      var joke = JokeModel.fromJson(r);
      debugPrint('fetchJokesApiRequest response $joke');
      return right(joke);
    });
  }

  @override
  EitherResponse generateOtp(String mobileNumber) async {
    final result = await _apiSource.generateOtp(mobileNumber);
    return result.fold((l) => left(l), (r) {
      var joke = JokeModel.fromJson(r);
      debugPrint('fetchJokesApiRequest response $joke');
      return right(joke);
    });
  }

  @override
  EitherResponse verifyOtp(String otp) async {
    final result = await _apiSource.verifyOtp(otp);
    return result.fold((l) => left(l), (r) {
      var joke = JokeModel.fromJson(r);
      debugPrint('fetchJokesApiRequest response $joke');
      return right(joke);
    });
  }

  @override
  EitherResponse login(String username, String password) async {
    final result = await _apiSource.login(username, password);
    return result.fold((l) => left(l), (r) {
      var joke = JokeModel.fromJson(r);
      debugPrint('fetchJokesApiRequest response $joke');
      return right(joke);
    });
  }
}
