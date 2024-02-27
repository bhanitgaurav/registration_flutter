class MyObject {
  static MyObject? _singleton;

  MyObject._internal();

  static MyObject get instance {
    _singleton ??= MyObject._internal();
    return _singleton!;
  }

  late var _registrationUrl;
  late var _splashName;
  late var _brandImage;

  void setRegistrationUrl(String url) {
    _registrationUrl = url;
  }

  String getRegistrationUrl() {
    return _registrationUrl;
  }

  void setSplashName(String name) {
    _splashName = name;
  }

  String getSplashName() {
    return _splashName;
  }

  void setBrandImage(String url) {
    _brandImage = url;
  }

  String getBrandImage() {
    return _brandImage;
  }
}
