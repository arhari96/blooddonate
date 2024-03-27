// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_sign_in_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleSignInResponseModel _$GoogleSignInResponseModelFromJson(
        Map<String, dynamic> json) =>
    GoogleSignInResponseModel(
      status: json['status'] as String? ?? "",
      message: json['message'],
      data: json['data'] == null
          ? null
          : GoogleData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GoogleSignInResponseModelToJson(
        GoogleSignInResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
