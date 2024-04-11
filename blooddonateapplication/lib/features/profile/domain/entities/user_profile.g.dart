// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      userId: json['user_id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      profilePic: json['profile_pic'] as String,
      dob: json['dob'],
      city: json['city'] as String,
      pincode: json['pincode'] as String,
      bloodType: json['blood_type'] as String,
      profileFilled: json['profile_filled'] as bool,
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'email': instance.email,
      'name': instance.name,
      'profile_pic': instance.profilePic,
      'dob': instance.dob,
      'city': instance.city,
      'pincode': instance.pincode,
      'blood_type': instance.bloodType,
      'profile_filled': instance.profileFilled,
    };
