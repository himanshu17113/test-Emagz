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
      address: fields[31] as Address?,
      commentPrivacy: fields[32] as CommentPrivacy?,
      postPrivacy: fields[33] as Privacy?,
      mentionPrivacy: fields[34] as Privacy?,
      messagePrivacy: fields[35] as Privacy?,
      livePrivacy: fields[36] as Privacy?,
      storyPrivacy: fields[37] as StoryPrivacy?,
      password: fields[38] as String?,
      mobileNumber: fields[6] as String?,
      isActive: fields[39] as bool?,
      isPrivate: fields[40] as String?,
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
      profilePic: fields[5] as String?,
      displayName: fields[27] as String?,
      enableLocation: fields[28] as bool?,
      notificationSound: fields[29] as bool?,
      desktopNotification: fields[30] as bool?,
      blockUsers: (fields[41] as List?)?.cast<String>(),
      socialType: fields[42] as String?,
      bio: fields[43] as String?,
      followersData: (fields[45] as List?)?.cast<String>(),
      followingData: (fields[44] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserSchema obj) {
    writer
      ..writeByte(41)
      ..writeByte(5)
      ..write(obj.profilePic)
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
      ..write(obj.displayName)
      ..writeByte(28)
      ..write(obj.enableLocation)
      ..writeByte(29)
      ..write(obj.notificationSound)
      ..writeByte(30)
      ..write(obj.desktopNotification)
      ..writeByte(31)
      ..write(obj.address)
      ..writeByte(32)
      ..write(obj.commentPrivacy)
      ..writeByte(33)
      ..write(obj.postPrivacy)
      ..writeByte(34)
      ..write(obj.mentionPrivacy)
      ..writeByte(35)
      ..write(obj.messagePrivacy)
      ..writeByte(36)
      ..write(obj.livePrivacy)
      ..writeByte(37)
      ..write(obj.storyPrivacy)
      ..writeByte(38)
      ..write(obj.password)
      ..writeByte(39)
      ..write(obj.isActive)
      ..writeByte(40)
      ..write(obj.isPrivate)
      ..writeByte(41)
      ..write(obj.blockUsers)
      ..writeByte(42)
      ..write(obj.socialType)
      ..writeByte(43)
      ..write(obj.bio)
      ..writeByte(44)
      ..write(obj.followingData)
      ..writeByte(45)
      ..write(obj.followersData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserSchemaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AddressAdapter extends TypeAdapter<Address> {
  @override
  final int typeId = 1;

  @override
  Address read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Address(
      addressLine1: fields[0] as String?,
      addressLine2: fields[1] as String?,
      city: fields[2] as String?,
      district: fields[3] as String?,
      pinCode: fields[4] as String?,
      state: fields[5] as String?,
      latitude: fields[6] as String?,
      longitude: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Address obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.addressLine1)
      ..writeByte(1)
      ..write(obj.addressLine2)
      ..writeByte(2)
      ..write(obj.city)
      ..writeByte(3)
      ..write(obj.district)
      ..writeByte(4)
      ..write(obj.pinCode)
      ..writeByte(5)
      ..write(obj.state)
      ..writeByte(6)
      ..write(obj.latitude)
      ..writeByte(7)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CommentPrivacyAdapter extends TypeAdapter<CommentPrivacy> {
  @override
  final int typeId = 2;

  @override
  CommentPrivacy read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CommentPrivacy(
      everyone: fields[0] as bool?,
      followers: fields[1] as bool?,
      follow: fields[2] as bool?,
      followAndFollowers: fields[3] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, CommentPrivacy obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.everyone)
      ..writeByte(1)
      ..write(obj.followers)
      ..writeByte(2)
      ..write(obj.follow)
      ..writeByte(3)
      ..write(obj.followAndFollowers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentPrivacyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PrivacyAdapter extends TypeAdapter<Privacy> {
  @override
  final int typeId = 3;

  @override
  Privacy read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Privacy(
      everyone: fields[0] as bool?,
      followers: fields[1] as bool?,
      noOne: fields[2] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Privacy obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.everyone)
      ..writeByte(1)
      ..write(obj.followers)
      ..writeByte(2)
      ..write(obj.noOne);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrivacyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StoryPrivacyAdapter extends TypeAdapter<StoryPrivacy> {
  @override
  final int typeId = 5;

  @override
  StoryPrivacy read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoryPrivacy(
      everyone: fields[0] as bool?,
      closeFriend: fields[1] as bool?,
      specific: fields[2] as bool?,
      noOne: fields[3] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, StoryPrivacy obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.everyone)
      ..writeByte(1)
      ..write(obj.closeFriend)
      ..writeByte(2)
      ..write(obj.specific)
      ..writeByte(3)
      ..write(obj.noOne);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoryPrivacyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
