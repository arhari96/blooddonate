

import 'package:hive/hive.dart';

import '../../../../shared/data/model/data_response.dart';
import '../entities/google_data.dart';
import '../repositories/google_sign_in_repository.dart';
import 'google_sign_in_usecase.dart';

class GoogleSignInUseCaseImpl extends GoogleSignInUseCase {
  final Box<String> _DataBox;
  final GoogleSignInRepository _googleSignInRepository;

  GoogleSignInUseCaseImpl(this._DataBox, this._googleSignInRepository);

  @override
  Future<DataResponse<GoogleData>> googleSignIn(String authToken) async =>
      await _googleSignInRepository.googleSignIn(authToken);
}
