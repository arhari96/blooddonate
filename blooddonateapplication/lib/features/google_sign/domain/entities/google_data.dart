import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../profile/domain/entities/user_profile.dart';

part 'google_data.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class GoogleData {
  @HiveField(1)
  @JsonKey(name: "user_profile")
  final UserProfile userProfile;
  @HiveField(3)
  @JsonKey(name: "token")
  final String token;

  GoogleData({
    required this.userProfile,
    required this.token,
  });

  factory GoogleData.fromJson(Map<String, dynamic> json) => _$GoogleDataFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleDataToJson(this);
}
