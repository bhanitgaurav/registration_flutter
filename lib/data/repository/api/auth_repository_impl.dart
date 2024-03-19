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
      debugPrint('fetchJokesApiRequest response ${joke}');
      return right(joke);
    });
  }
}
