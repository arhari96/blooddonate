import 'package:blooddonateapp/features/google_sign/domain/entities/google_data.dart';
import 'package:blooddonateapp/features/google_sign/domain/usecases/google_sign_in_usecase.dart';
import 'package:blooddonateapp/shared/data/model/data_response.dart';
import 'package:hive/hive.dart';

import '../repositories/google_sign_in_repository.dart';

class GoogleSignInUseCaseImpl extends GoogleSignInUseCase {
  final Box<String> _DataBox;
  final GoogleSignInRepository _googleSignInRepository;

  GoogleSignInUseCaseImpl(this._DataBox, this._googleSignInRepository);

  @override
  Future<DataResponse<GoogleData>> googleSignIn(String authToken) async =>
      await _googleSignInRepository.googleSignIn(authToken);
}
