import 'package:fpdart/fpdart.dart';
import 'package:registration_flutter/network/constant/endpoints.dart';
import 'package:registration_flutter/network/dio_client.dart';

typedef EitherResponse<T> = Future<Either<String, T>>;

class ApiDataSource {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  ApiDataSource(this._dioClient);

  EitherResponse<dynamic> fetchJokesApiRequest() async {
    try {
      final res = await _dioClient.get(Endpoints.baseUrl);
      return right(res.data);
    } catch (e) {
      return left(e.toString());
    }
  }

  EitherResponse<dynamic> generateOtp(String mobileNumber) async {
    try {
      final res = await _dioClient.get(Endpoints.baseUrl);
      return right(res.data);
    } catch (e) {
      return left(e.toString());
    }
  }

  EitherResponse<dynamic> verifyOtp(String otp) async {
    try {
      final res = await _dioClient.get(Endpoints.baseUrl);
      return right(res.data);
    } catch (e) {
      return left(e.toString());
    }
  }
}
