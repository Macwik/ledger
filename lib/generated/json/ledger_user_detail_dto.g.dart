import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/ledger/ledger_user_detail_dto.dart';
import 'package:ledger/entity/auth/role_dto.dart';

import 'package:ledger/entity/user/user_dto_entity.dart';


LedgerUserDetailDTO $LedgerUserDetailDTOFromJson(Map<String, dynamic> json) {
  final LedgerUserDetailDTO ledgerUserDetailDTO = LedgerUserDetailDTO();
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    ledgerUserDetailDTO.userId = userId;
  }
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    ledgerUserDetailDTO.ledgerId = ledgerId;
  }
  final UserDTOEntity? userBaseDTO = jsonConvert.convert<UserDTOEntity>(
      json['userBaseDTO']);
  if (userBaseDTO != null) {
    ledgerUserDetailDTO.userBaseDTO = userBaseDTO;
  }
  final RoleDTO? roleDTO = jsonConvert.convert<RoleDTO>(json['roleDTO']);
  if (roleDTO != null) {
    ledgerUserDetailDTO.roleDTO = roleDTO;
  }
  final DateTime? entryDate = jsonConvert.convert<DateTime>(json['entryDate']);
  if (entryDate != null) {
    ledgerUserDetailDTO.entryDate = entryDate;
  }
  return ledgerUserDetailDTO;
}

Map<String, dynamic> $LedgerUserDetailDTOToJson(LedgerUserDetailDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userId'] = entity.userId;
  data['ledgerId'] = entity.ledgerId;
  data['userBaseDTO'] = entity.userBaseDTO?.toJson();
  data['roleDTO'] = entity.roleDTO?.toJson();
  data['entryDate'] = entity.entryDate?.toIso8601String();
  return data;
}

extension LedgerUserDetailDTOExtension on LedgerUserDetailDTO {
  LedgerUserDetailDTO copyWith({
    int? userId,
    int? ledgerId,
    UserDTOEntity? userBaseDTO,
    RoleDTO? roleDTO,
    DateTime? entryDate,
  }) {
    return LedgerUserDetailDTO()
      ..userId = userId ?? this.userId
      ..ledgerId = ledgerId ?? this.ledgerId
      ..userBaseDTO = userBaseDTO ?? this.userBaseDTO
      ..roleDTO = roleDTO ?? this.roleDTO
      ..entryDate = entryDate ?? this.entryDate;
  }
}