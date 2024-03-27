import 'package:blooddonateapp/features/google_sign/domain/entities/google_data.dart';
import 'package:blooddonateapp/shared/data/model/data_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'google_sign_in_response_model.g.dart';

@JsonSerializable()
class GoogleSignInResponseModel extends DataResponse<GoogleData> {
  GoogleSignInResponseModel({
    required super.status,
    required super.message,
    required super.data,
  });

  factory GoogleSignInResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GoogleSignInResponseModelFromJson(json);
}
