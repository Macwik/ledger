import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/auth/user_role_relation_dto.dart';

UserRoleRelationDTO $UserRoleRelationDTOFromJson(Map<String, dynamic> json) {
  final UserRoleRelationDTO userRoleRelationDTO = UserRoleRelationDTO();
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    userRoleRelationDTO.userId = userId;
  }
  final int? roleId = jsonConvert.convert<int>(json['roleId']);
  if (roleId != null) {
    userRoleRelationDTO.roleId = roleId;
  }
  final String? roleName = jsonConvert.convert<String>(json['roleName']);
  if (roleName != null) {
    userRoleRelationDTO.roleName = roleName;
  }
  final String? roleDesc = jsonConvert.convert<String>(json['roleDesc']);
  if (roleDesc != null) {
    userRoleRelationDTO.roleDesc = roleDesc;
  }
  return userRoleRelationDTO;
}

Map<String, dynamic> $UserRoleRelationDTOToJson(UserRoleRelationDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userId'] = entity.userId;
  data['roleId'] = entity.roleId;
  data['roleName'] = entity.roleName;
  data['roleDesc'] = entity.roleDesc;
  return data;
}

extension UserRoleRelationDTOExtension on UserRoleRelationDTO {
  UserRoleRelationDTO copyWith({
    int? userId,
    int? roleId,
    String? roleName,
    String? roleDesc,
  }) {
    return UserRoleRelationDTO()
      ..userId = userId ?? this.userId
      ..roleId = roleId ?? this.roleId
      ..roleName = roleName ?? this.roleName
      ..roleDesc = roleDesc ?? this.roleDesc;
  }
}