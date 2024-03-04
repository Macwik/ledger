import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/auth/role_dto.dart';

RoleDTO $RoleDTOFromJson(Map<String, dynamic> json) {
  final RoleDTO roleDTO = RoleDTO();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    roleDTO.id = id;
  }
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    roleDTO.ledgerId = ledgerId;
  }
  final String? roleName = jsonConvert.convert<String>(json['roleName']);
  if (roleName != null) {
    roleDTO.roleName = roleName;
  }
  final String? roleDesc = jsonConvert.convert<String>(json['roleDesc']);
  if (roleDesc != null) {
    roleDTO.roleDesc = roleDesc;
  }
  final int? roleType = jsonConvert.convert<int>(json['roleType']);
  if (roleType != null) {
    roleDTO.roleType = roleType;
  }
  return roleDTO;
}

Map<String, dynamic> $RoleDTOToJson(RoleDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['ledgerId'] = entity.ledgerId;
  data['roleName'] = entity.roleName;
  data['roleDesc'] = entity.roleDesc;
  data['roleType'] = entity.roleType;
  return data;
}

extension RoleDTOExtension on RoleDTO {
  RoleDTO copyWith({
    int? id,
    int? ledgerId,
    String? roleName,
    String? roleDesc,
    int? roleType,
  }) {
    return RoleDTO()
      ..id = id ?? this.id
      ..ledgerId = ledgerId ?? this.ledgerId
      ..roleName = roleName ?? this.roleName
      ..roleDesc = roleDesc ?? this.roleDesc
      ..roleType = roleType ?? this.roleType;
  }
}