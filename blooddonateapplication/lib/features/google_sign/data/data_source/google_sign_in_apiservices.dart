import 'package:blooddonateapp/features/google_sign/data/models/google_sign_in_response_model.dart';
import 'package:blooddonateapp/shared/data/model/data_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../Constants.dart';
import '../../domain/entities/google_data.dart';

part 'google_sign_in_apiservices.g.dart';

@RestApi(baseUrl: Urls.baseUrl)
abstract class GoogleSignInApiServices {
  factory GoogleSignInApiServices(Dio dio) = _GoogleSignInApiServices;

  @POST(Urls.baseUrl)
  Future<HttpResponse<GoogleSignInResponseModel>> googleSignIn(
    @Field(ApiArguments.auth_token) String authToken,
  );
}
