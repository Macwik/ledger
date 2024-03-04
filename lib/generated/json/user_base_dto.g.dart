import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/user/user_base_dto.dart';

UserBaseDTO $UserBaseDTOFromJson(Map<String, dynamic> json) {
  final UserBaseDTO userBaseDTO = UserBaseDTO();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    userBaseDTO.id = id;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    userBaseDTO.username = username;
  }
  final int? gender = jsonConvert.convert<int>(json['gender']);
  if (gender != null) {
    userBaseDTO.gender = gender;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    userBaseDTO.phone = phone;
  }
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    userBaseDTO.ledgerId = ledgerId;
  }
  final String? ledgerName = jsonConvert.convert<String>(json['ledgerName']);
  if (ledgerName != null) {
    userBaseDTO.ledgerName = ledgerName;
  }
  return userBaseDTO;
}

Map<String, dynamic> $UserBaseDTOToJson(UserBaseDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['username'] = entity.username;
  data['gender'] = entity.gender;
  data['phone'] = entity.phone;
  data['ledgerId'] = entity.ledgerId;
  data['ledgerName'] = entity.ledgerName;
  return data;
}

extension UserBaseDTOExtension on UserBaseDTO {
  UserBaseDTO copyWith({
    int? id,
    String? username,
    int? gender,
    String? phone,
    int? ledgerId,
    String? ledgerName,
  }) {
    return UserBaseDTO()
      ..id = id ?? this.id
      ..username = username ?? this.username
      ..gender = gender ?? this.gender
      ..phone = phone ?? this.phone
      ..ledgerId = ledgerId ?? this.ledgerId
      ..ledgerName = ledgerName ?? this.ledgerName;
  }
}