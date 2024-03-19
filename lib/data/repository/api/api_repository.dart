import 'package:registration_flutter/data/datasource/api/api_datasource.dart';
import 'package:registration_flutter/models/joke/joke_model.dart';

abstract class ApiRepository {
  EitherResponse<JokeModel> fetchJokesApiRequest();
}
