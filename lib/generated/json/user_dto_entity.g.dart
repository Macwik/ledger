import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/user/user_dto_entity.dart';
import 'package:ledger/entity/ledger/ledger_dto_entity.dart';


UserDTOEntity $UserDTOEntityFromJson(Map<String, dynamic> json) {
  final UserDTOEntity userDTOEntity = UserDTOEntity();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    userDTOEntity.id = id;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    userDTOEntity.username = username;
  }
  final int? gender = jsonConvert.convert<int>(json['gender']);
  if (gender != null) {
    userDTOEntity.gender = gender;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    userDTOEntity.phone = phone;
  }
  final LedgerDTOEntity? activeLedger = jsonConvert.convert<LedgerDTOEntity>(
      json['activeLedger']);
  if (activeLedger != null) {
    userDTOEntity.activeLedger = activeLedger;
  }
  return userDTOEntity;
}

Map<String, dynamic> $UserDTOEntityToJson(UserDTOEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['username'] = entity.username;
  data['gender'] = entity.gender;
  data['phone'] = entity.phone;
  data['activeLedger'] = entity.activeLedger?.toJson();
  return data;
}

extension UserDTOEntityExtension on UserDTOEntity {
  UserDTOEntity copyWith({
    int? id,
    String? username,
    int? gender,
    String? phone,
    LedgerDTOEntity? activeLedger,
  }) {
    return UserDTOEntity()
      ..id = id ?? this.id
      ..username = username ?? this.username
      ..gender = gender ?? this.gender
      ..phone = phone ?? this.phone
      ..activeLedger = activeLedger ?? this.activeLedger;
  }
}