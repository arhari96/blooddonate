import 'package:blooddonateapp/features/google_sign/domain/entities/google_data.dart';

import '../../../../shared/data/model/data_response.dart';

abstract class GoogleSignInRepository {
  Future<DataResponse<GoogleData>> googleSignIn(String token);
}
