import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:registration_flutter/models/joke/flag_model.dart';

part 'joke_model.freezed.dart';
part 'joke_model.g.dart';

@freezed
class JokeModel with _$JokeModel {
  const factory JokeModel({
    bool? error,
    String? category,
    String? type,
    String? setup,
    String? delivery,
    @Default(FlagModel()) FlagModel flagModel,
    int? id,
    @Default(false) bool safe,
    String? lang,
  }) = _JokeModel;

  factory JokeModel.fromJson(Map<String, dynamic> json) =>
      _$JokeModelFromJson(json);
}
