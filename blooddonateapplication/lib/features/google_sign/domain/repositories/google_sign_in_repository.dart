
import '../../../../shared/data/model/data_response.dart';
import '../entities/google_data.dart';

abstract class GoogleSignInRepository {
  Future<DataResponse<GoogleData>> googleSignIn(String token);
}
