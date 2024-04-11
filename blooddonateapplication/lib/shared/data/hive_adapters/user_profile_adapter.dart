import 'package:hive/hive.dart';

import '../../../features/profile/domain/entities/user_profile.dart'; // Adjust import path as needed

class UserProfileAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = 3; // Unique identifier for this adapter

  @override
  UserProfile read(BinaryReader reader) {
    return UserProfile(
      userId: reader.readString(),
      email: reader.readString(),
      name: reader.readString(),
      profilePic: reader.readString(),
      dob: reader.read(), // Adjust this line as per your data type
      city: reader.readString(),
      pincode: reader.readString(),
      bloodType: reader.readString(),
      profileFilled: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer.writeString(obj.userId);
    writer.writeString(obj.email);
    writer.writeString(obj.name);
    writer.writeString(obj.profilePic);
    writer.write(obj.dob); // Adjust this line as per your data type
    writer.writeString(obj.city);
    writer.writeString(obj.pincode);
    writer.writeString(obj.bloodType);
    writer.writeBool(obj.profileFilled);
  }
}
