import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'google_data.g.dart';

@HiveType(typeId: 1)
@JsonSerializable(createToJson: true)
class GoogleData {
  @HiveField(1)
  @JsonKey(name: "data")
  final Data data;

  GoogleData({
    required this.data,
  });

  factory GoogleData.fromJson(Map<String, dynamic> json) =>
      _$GoogleDataFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleDataToJson(this);
}

@HiveType(typeId: 2)
@JsonSerializable()
class Data {
  @HiveField(1)
  @JsonKey(name: "user_profile")
  final UserProfile userProfile;
  @HiveField(3)
  @JsonKey(name: "token")
  final String token;

  Data({
    required this.userProfile,
    required this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@HiveType(typeId: 3)
@JsonSerializable()
class UserProfile {
  @HiveField(1)
  @JsonKey(name: "user_id")
  final String userId;
  @HiveField(3)
  @JsonKey(name: "email")
  final String email;
  @HiveField(5)
  @JsonKey(name: "name")
  final String name;
  @HiveField(7)
  @JsonKey(name: "profile_pic")
  final String profilePic;
  @HiveField(9)
  @JsonKey(name: "dob")
  final dynamic dob;
  @HiveField(11)
  @JsonKey(name: "city")
  final String city;
  @HiveField(13)
  @JsonKey(name: "pincode")
  final String pincode;
  @HiveField(15)
  @JsonKey(name: "blood_type")
  final String bloodType;
  @HiveField(17)
  @JsonKey(name: "profile_filled")
  final bool profileFilled;

  UserProfile({
    required this.userId,
    required this.email,
    required this.name,
    required this.profilePic,
    required this.dob,
    required this.city,
    required this.pincode,
    required this.bloodType,
    required this.profileFilled,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
