import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/ledger/user_ledger_dto.dart';

UserLedgerDTO $UserLedgerDTOFromJson(Map<String, dynamic> json) {
  final UserLedgerDTO userLedgerDTO = UserLedgerDTO();
  final List<
      LedgerUserRelationDetailDTO>? ownerList = (json['ownerList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<LedgerUserRelationDetailDTO>(
          e) as LedgerUserRelationDetailDTO).toList();
  if (ownerList != null) {
    userLedgerDTO.ownerList = ownerList;
  }
  final List<LedgerUserRelationDetailDTO>? joinList = (json['joinList'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<LedgerUserRelationDetailDTO>(
          e) as LedgerUserRelationDetailDTO).toList();
  if (joinList != null) {
    userLedgerDTO.joinList = joinList;
  }
  return userLedgerDTO;
}

Map<String, dynamic> $UserLedgerDTOToJson(UserLedgerDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ownerList'] = entity.ownerList?.map((v) => v.toJson()).toList();
  data['joinList'] = entity.joinList?.map((v) => v.toJson()).toList();
  return data;
}

extension UserLedgerDTOExtension on UserLedgerDTO {
  UserLedgerDTO copyWith({
    List<LedgerUserRelationDetailDTO>? ownerList,
    List<LedgerUserRelationDetailDTO>? joinList,
  }) {
    return UserLedgerDTO()
      ..ownerList = ownerList ?? this.ownerList
      ..joinList = joinList ?? this.joinList;
  }
}

LedgerUserRelationDetailDTO $LedgerUserRelationDetailDTOFromJson(
    Map<String, dynamic> json) {
  final LedgerUserRelationDetailDTO ledgerUserRelationDetailDTO = LedgerUserRelationDetailDTO();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    ledgerUserRelationDetailDTO.id = id;
  }
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    ledgerUserRelationDetailDTO.userId = userId;
  }
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    ledgerUserRelationDetailDTO.ledgerId = ledgerId;
  }
  final String? ledgerName = jsonConvert.convert<String>(json['ledgerName']);
  if (ledgerName != null) {
    ledgerUserRelationDetailDTO.ledgerName = ledgerName;
  }
  final int? ledgerUserType = jsonConvert.convert<int>(json['ledgerUserType']);
  if (ledgerUserType != null) {
    ledgerUserRelationDetailDTO.ledgerUserType = ledgerUserType;
  }
  final int? storeType = jsonConvert.convert<int>(json['storeType']);
  if (storeType != null) {
    ledgerUserRelationDetailDTO.storeType = storeType;
  }
  final int? businessScope = jsonConvert.convert<int>(json['businessScope']);
  if (businessScope != null) {
    ledgerUserRelationDetailDTO.businessScope = businessScope;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    ledgerUserRelationDetailDTO.remark = remark;
  }
  final bool? active = jsonConvert.convert<bool>(json['active']);
  if (active != null) {
    ledgerUserRelationDetailDTO.active = active;
  }
  return ledgerUserRelationDetailDTO;
}

Map<String, dynamic> $LedgerUserRelationDetailDTOToJson(
    LedgerUserRelationDetailDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['userId'] = entity.userId;
  data['ledgerId'] = entity.ledgerId;
  data['ledgerName'] = entity.ledgerName;
  data['ledgerUserType'] = entity.ledgerUserType;
  data['storeType'] = entity.storeType;
  data['businessScope'] = entity.businessScope;
  data['remark'] = entity.remark;
  data['active'] = entity.active;
  return data;
}

extension LedgerUserRelationDetailDTOExtension on LedgerUserRelationDetailDTO {
  LedgerUserRelationDetailDTO copyWith({
    int? id,
    int? userId,
    int? ledgerId,
    String? ledgerName,
    int? ledgerUserType,
    int? storeType,
    int? businessScope,
    String? remark,
    bool? active,
  }) {
    return LedgerUserRelationDetailDTO()
      ..id = id ?? this.id
      ..userId = userId ?? this.userId
      ..ledgerId = ledgerId ?? this.ledgerId
      ..ledgerName = ledgerName ?? this.ledgerName
      ..ledgerUserType = ledgerUserType ?? this.ledgerUserType
      ..storeType = storeType ?? this.storeType
      ..businessScope = businessScope ?? this.businessScope
      ..remark = remark ?? this.remark
      ..active = active ?? this.active;
  }
}