import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/productOwner/supplier_dto.dart';

SupplierDTO $SupplierDTOFromJson(Map<String, dynamic> json) {
  final SupplierDTO supplierDTO = SupplierDTO();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    supplierDTO.id = id;
  }
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    supplierDTO.ledgerId = ledgerId;
  }
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    supplierDTO.userId = userId;
  }
  final String? supplierName = jsonConvert.convert<String>(
      json['supplierName']);
  if (supplierName != null) {
    supplierDTO.supplierName = supplierName;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    supplierDTO.phone = phone;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    supplierDTO.remark = remark;
  }
  final int? creator = jsonConvert.convert<int>(json['creator']);
  if (creator != null) {
    supplierDTO.creator = creator;
  }
  final String? creatorName = jsonConvert.convert<String>(json['creatorName']);
  if (creatorName != null) {
    supplierDTO.creatorName = creatorName;
  }
  final int? invalid = jsonConvert.convert<int>(json['invalid']);
  if (invalid != null) {
    supplierDTO.invalid = invalid;
  }
  final int? used = jsonConvert.convert<int>(json['used']);
  if (used != null) {
    supplierDTO.used = used;
  }
  final int? deleted = jsonConvert.convert<int>(json['deleted']);
  if (deleted != null) {
    supplierDTO.deleted = deleted;
  }
  final String? gmtCreate = jsonConvert.convert<String>(json['gmtCreate']);
  if (gmtCreate != null) {
    supplierDTO.gmtCreate = gmtCreate;
  }
  final String? gmtModified = jsonConvert.convert<String>(json['gmtModified']);
  if (gmtModified != null) {
    supplierDTO.gmtModified = gmtModified;
  }
  return supplierDTO;
}

Map<String, dynamic> $SupplierDTOToJson(SupplierDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['ledgerId'] = entity.ledgerId;
  data['userId'] = entity.userId;
  data['supplierName'] = entity.supplierName;
  data['phone'] = entity.phone;
  data['remark'] = entity.remark;
  data['creator'] = entity.creator;
  data['creatorName'] = entity.creatorName;
  data['invalid'] = entity.invalid;
  data['used'] = entity.used;
  data['deleted'] = entity.deleted;
  data['gmtCreate'] = entity.gmtCreate;
  data['gmtModified'] = entity.gmtModified;
  return data;
}

extension SupplierDTOExtension on SupplierDTO {
  SupplierDTO copyWith({
    int? id,
    int? ledgerId,
    int? userId,
    String? supplierName,
    String? phone,
    String? remark,
    int? creator,
    String? creatorName,
    int? invalid,
    int? used,
    int? deleted,
    String? gmtCreate,
    String? gmtModified,
  }) {
    return SupplierDTO()
      ..id = id ?? this.id
      ..ledgerId = ledgerId ?? this.ledgerId
      ..userId = userId ?? this.userId
      ..supplierName = supplierName ?? this.supplierName
      ..phone = phone ?? this.phone
      ..remark = remark ?? this.remark
      ..creator = creator ?? this.creator
      ..creatorName = creatorName ?? this.creatorName
      ..invalid = invalid ?? this.invalid
      ..used = used ?? this.used
      ..deleted = deleted ?? this.deleted
      ..gmtCreate = gmtCreate ?? this.gmtCreate
      ..gmtModified = gmtModified ?? this.gmtModified;
  }
}