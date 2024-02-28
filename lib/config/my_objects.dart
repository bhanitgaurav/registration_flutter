import 'package:registration_flutter/models/pair.dart';

class MyObject {
  static MyObject? _singleton;

  MyObject._internal();

  static MyObject get instance {
    _singleton ??= MyObject._internal();
    return _singleton!;
  }

  late var _registrationUrl;
  late Triple<String, Triple<String, double?, double?>,
      Triple<String, double?, double?>> _splash;
  late var _brandImage;

  void setRegistrationUrl(String url) {
    _registrationUrl = url;
  }

  String getRegistrationUrl() {
    return _registrationUrl;
  }

  void setSplash({
    required String name,
    String assetUrl = '',
    String imageUrl = '',
    double? height,
    double? width,
  }) {
    final asset = Triple<String, double?, double?>(assetUrl, height, width);
    final image = Triple<String, double?, double?>(imageUrl, height, width);
    _splash = Triple(name, asset, image);
  }

  Triple<String, Triple<String, double?, double?>,
      Triple<String, double?, double?>> getSplash() {
    return _splash;
  }

  void setBrandImage({required String url}) {
    _brandImage = url;
  }

  String getBrandImage() {
    return _brandImage;
  }
}
