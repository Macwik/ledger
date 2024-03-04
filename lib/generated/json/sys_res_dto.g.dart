import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/auth/sys_res_dto.dart';

SysResDTO $SysResDTOFromJson(Map<String, dynamic> json) {
  final SysResDTO sysResDTO = SysResDTO();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    sysResDTO.id = id;
  }
  final String? resCode = jsonConvert.convert<String>(json['resCode']);
  if (resCode != null) {
    sysResDTO.resCode = resCode;
  }
  final String? resName = jsonConvert.convert<String>(json['resName']);
  if (resName != null) {
    sysResDTO.resName = resName;
  }
  final String? resDesc = jsonConvert.convert<String>(json['resDesc']);
  if (resDesc != null) {
    sysResDTO.resDesc = resDesc;
  }
  final int? resType = jsonConvert.convert<int>(json['resType']);
  if (resType != null) {
    sysResDTO.resType = resType;
  }
  final int? parentId = jsonConvert.convert<int>(json['parentId']);
  if (parentId != null) {
    sysResDTO.parentId = parentId;
  }
  final int? hierarchy = jsonConvert.convert<int>(json['hierarchy']);
  if (hierarchy != null) {
    sysResDTO.hierarchy = hierarchy;
  }
  final int? ordinal = jsonConvert.convert<int>(json['ordinal']);
  if (ordinal != null) {
    sysResDTO.ordinal = ordinal;
  }
  final int? deleted = jsonConvert.convert<int>(json['deleted']);
  if (deleted != null) {
    sysResDTO.deleted = deleted;
  }
  return sysResDTO;
}

Map<String, dynamic> $SysResDTOToJson(SysResDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['resCode'] = entity.resCode;
  data['resName'] = entity.resName;
  data['resDesc'] = entity.resDesc;
  data['resType'] = entity.resType;
  data['parentId'] = entity.parentId;
  data['hierarchy'] = entity.hierarchy;
  data['ordinal'] = entity.ordinal;
  data['deleted'] = entity.deleted;
  return data;
}

extension SysResDTOExtension on SysResDTO {
  SysResDTO copyWith({
    int? id,
    String? resCode,
    String? resName,
    String? resDesc,
    int? resType,
    int? parentId,
    int? hierarchy,
    int? ordinal,
    int? deleted,
  }) {
    return SysResDTO()
      ..id = id ?? this.id
      ..resCode = resCode ?? this.resCode
      ..resName = resName ?? this.resName
      ..resDesc = resDesc ?? this.resDesc
      ..resType = resType ?? this.resType
      ..parentId = parentId ?? this.parentId
      ..hierarchy = hierarchy ?? this.hierarchy
      ..ordinal = ordinal ?? this.ordinal
      ..deleted = deleted ?? this.deleted;
  }
}