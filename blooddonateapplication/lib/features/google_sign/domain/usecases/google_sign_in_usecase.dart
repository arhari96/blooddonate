import '../../../../shared/data/model/data_response.dart';
import '../entities/google_data.dart';

abstract class GoogleSignInUseCase {
  Future<DataResponse<GoogleData>> googleSignIn();
}
