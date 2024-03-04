import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/user/user_detail_dto.dart';

UserDetailDTO $UserDetailDTOFromJson(Map<String, dynamic> json) {
  final UserDetailDTO userDetailDTO = UserDetailDTO();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    userDetailDTO.id = id;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    userDetailDTO.username = username;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    userDetailDTO.nickname = nickname;
  }
  final int? gender = jsonConvert.convert<int>(json['gender']);
  if (gender != null) {
    userDetailDTO.gender = gender;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    userDetailDTO.phone = phone;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    userDetailDTO.email = email;
  }
  final DateTime? gmtCreate = jsonConvert.convert<DateTime>(json['gmtCreate']);
  if (gmtCreate != null) {
    userDetailDTO.gmtCreate = gmtCreate;
  }
  final String? gmtModified = jsonConvert.convert<String>(json['gmtModified']);
  if (gmtModified != null) {
    userDetailDTO.gmtModified = gmtModified;
  }
  return userDetailDTO;
}

Map<String, dynamic> $UserDetailDTOToJson(UserDetailDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['username'] = entity.username;
  data['nickname'] = entity.nickname;
  data['gender'] = entity.gender;
  data['phone'] = entity.phone;
  data['email'] = entity.email;
  data['gmtCreate'] = entity.gmtCreate?.toIso8601String();
  data['gmtModified'] = entity.gmtModified;
  return data;
}

extension UserDetailDTOExtension on UserDetailDTO {
  UserDetailDTO copyWith({
    int? id,
    String? username,
    String? nickname,
    int? gender,
    String? phone,
    String? email,
    DateTime? gmtCreate,
    String? gmtModified,
  }) {
    return UserDetailDTO()
      ..id = id ?? this.id
      ..username = username ?? this.username
      ..nickname = nickname ?? this.nickname
      ..gender = gender ?? this.gender
      ..phone = phone ?? this.phone
      ..email = email ?? this.email
      ..gmtCreate = gmtCreate ?? this.gmtCreate
      ..gmtModified = gmtModified ?? this.gmtModified;
  }
}