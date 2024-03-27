// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoogleDataAdapter extends TypeAdapter<GoogleData> {
  @override
  final int typeId = 1;

  @override
  GoogleData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GoogleData(
      data: fields[1] as Data,
    );
  }

  @override
  void write(BinaryWriter writer, GoogleData obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoogleDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DataAdapter extends TypeAdapter<Data> {
  @override
  final int typeId = 2;

  @override
  Data read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Data(
      userProfile: fields[1] as UserProfile,
      token: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Data obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.userProfile)
      ..writeByte(3)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserProfileAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = 3;

  @override
  UserProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfile(
      userId: fields[1] as String,
      email: fields[3] as String,
      name: fields[5] as String,
      profilePic: fields[7] as String,
      dob: fields[9] as dynamic,
      city: fields[11] as String,
      pincode: fields[13] as String,
      bloodType: fields[15] as String,
      profileFilled: fields[17] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer
      ..writeByte(9)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(7)
      ..write(obj.profilePic)
      ..writeByte(9)
      ..write(obj.dob)
      ..writeByte(11)
      ..write(obj.city)
      ..writeByte(13)
      ..write(obj.pincode)
      ..writeByte(15)
      ..write(obj.bloodType)
      ..writeByte(17)
      ..write(obj.profileFilled);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleData _$GoogleDataFromJson(Map<String, dynamic> json) => GoogleData(
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GoogleDataToJson(GoogleData instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      userProfile:
          UserProfile.fromJson(json['user_profile'] as Map<String, dynamic>),
      token: json['token'] as String,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'user_profile': instance.userProfile,
      'token': instance.token,
    };

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
