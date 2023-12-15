// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_schema.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserSchemaAdapter extends TypeAdapter<UserSchema> {
  @override
  final int typeId = 0;

  @override
  UserSchema read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserSchema(
      mobileNumber: fields[6] as String?,
      loginOtp: fields[7] as String?,
      personalTemplate: fields[8] as String?,
      sId: fields[9] as String?,
      username: fields[10] as String?,
      email: fields[11] as String?,
      dob: fields[12] as String?,
      accountType: fields[13] as String?,
      interestName: (fields[14] as List?)?.cast<String?>(),
      followers: fields[15] as int?,
      followings: fields[16] as int?,
      hirable: fields[17] as String?,
      rating: fields[18] as int?,
      reviews: fields[19] as String?,
      poll: fields[20] as String?,
      jobcreated: fields[21] as String?,
      accountStatus: fields[22] as String?,
      search: (fields[23] as List?)?.cast<String?>(),
      createdAt: fields[24] as String?,
      updatedAt: fields[25] as String?,
      getstatedName: fields[26] as String?,
      ProfilePic: fields[5] as String?,
      displayName: fields[27] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserSchema obj) {
    writer
      ..writeByte(23)
      ..writeByte(5)
      ..write(obj.ProfilePic)
      ..writeByte(6)
      ..write(obj.mobileNumber)
      ..writeByte(7)
      ..write(obj.loginOtp)
      ..writeByte(8)
      ..write(obj.personalTemplate)
      ..writeByte(9)
      ..write(obj.sId)
      ..writeByte(10)
      ..write(obj.username)
      ..writeByte(11)
      ..write(obj.email)
      ..writeByte(12)
      ..write(obj.dob)
      ..writeByte(13)
      ..write(obj.accountType)
      ..writeByte(14)
      ..write(obj.interestName)
      ..writeByte(15)
      ..write(obj.followers)
      ..writeByte(16)
      ..write(obj.followings)
      ..writeByte(17)
      ..write(obj.hirable)
      ..writeByte(18)
      ..write(obj.rating)
      ..writeByte(19)
      ..write(obj.reviews)
      ..writeByte(20)
      ..write(obj.poll)
      ..writeByte(21)
      ..write(obj.jobcreated)
      ..writeByte(22)
      ..write(obj.accountStatus)
      ..writeByte(23)
      ..write(obj.search)
      ..writeByte(24)
      ..write(obj.createdAt)
      ..writeByte(25)
      ..write(obj.updatedAt)
      ..writeByte(26)
      ..write(obj.getstatedName)
      ..writeByte(27)
      ..write(obj.displayName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UserSchemaAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
