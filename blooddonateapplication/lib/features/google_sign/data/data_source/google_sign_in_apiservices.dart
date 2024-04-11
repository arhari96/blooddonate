
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../Constants.dart';
import '../models/google_sign_in_response_model.dart';

part 'google_sign_in_apiservices.g.dart';

@RestApi(baseUrl: Urls.baseUrl)
abstract class GoogleSignInApiServices {
  factory GoogleSignInApiServices(Dio dio) = _GoogleSignInApiServices;

  @POST(Urls.googleLogin)
  Future<HttpResponse<GoogleSignInResponseModel>> googleSignIn(
    @Field(ApiArguments.auth_token) String authToken,
  );
}
