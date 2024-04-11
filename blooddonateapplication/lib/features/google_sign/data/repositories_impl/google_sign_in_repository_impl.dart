import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../shared/data/model/data_response.dart';
import '../../domain/entities/google_data.dart';
import '../../domain/repositories/google_sign_in_repository.dart';
import '../data_source/google_sign_in_apiservices.dart';

class GoogleSignInRepositoryImpl extends GoogleSignInRepository {
  final GoogleSignInApiServices _googleSignInApiServices;

  GoogleSignInRepositoryImpl(this._googleSignInApiServices);

  @override
  Future<DataResponse<GoogleData>> googleSignIn() async {
    try {
      final GoogleSignIn googleSignIn = await GoogleSignIn();
      await googleSignIn.signOut();
      final GoogleSignInAccount? _googleSignInAccount =
          await googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await _googleSignInAccount?.authentication;
      final httpResponse =
          await _googleSignInApiServices.googleSignIn(googleAuth!.idToken!);

      return DataResponse.fromHttpResponse(httpResponse);
    } on DioException catch (e) {
      return DataResponse.fromDioException(e);
    }
  }
}
