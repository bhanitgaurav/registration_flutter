import 'package:freezed_annotation/freezed_annotation.dart';

part 'flag_model.freezed.dart';
part 'flag_model.g.dart';

@freezed
class FlagModel with _$FlagModel {
  const factory FlagModel({
    @Default(false) bool nsfw,
    @Default(false) bool religious,
    @Default(false) bool political,
    @Default(false) bool racist,
    @Default(false) bool sexist,
    @Default(false) bool explicit,
  }) = _FlagModel;

  factory FlagModel.fromJson(Map<String, dynamic> json) =>
      _$FlagModelFromJson(json);
}
