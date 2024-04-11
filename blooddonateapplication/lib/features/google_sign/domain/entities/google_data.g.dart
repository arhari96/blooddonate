// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleData _$GoogleDataFromJson(Map<String, dynamic> json) => GoogleData(
      userProfile:
          UserProfile.fromJson(json['user_profile'] as Map<String, dynamic>),
      token: json['token'] as String,
    );

Map<String, dynamic> _$GoogleDataToJson(GoogleData instance) =>
    <String, dynamic>{
      'user_profile': instance.userProfile,
      'token': instance.token,
    };
