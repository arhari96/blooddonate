import 'package:dio/dio.dart';

import '../../../../shared/data/model/data_response.dart';
import '../../domain/entities/google_data.dart';
import '../../domain/repositories/google_sign_in_repository.dart';
import '../data_source/google_sign_in_apiservices.dart';

class GoogleSignInRepositoryImpl extends GoogleSignInRepository {
  final GoogleSignInApiServices _googleSignInApiServices;

  GoogleSignInRepositoryImpl(this._googleSignInApiServices);

  @override
  Future<DataResponse<GoogleData>> googleSignIn(String token) async {
    try {
      final httpResponse = await _googleSignInApiServices.googleSignIn(token);

      return DataResponse.fromHttpResponse(httpResponse);
    } on DioException catch (e) {
      return DataResponse.fromDioException(e);
    }
  }
}
