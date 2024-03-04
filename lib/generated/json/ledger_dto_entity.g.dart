import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/ledger/ledger_dto_entity.dart';

LedgerDTOEntity $LedgerDTOEntityFromJson(Map<String, dynamic> json) {
  final LedgerDTOEntity ledgerDTOEntity = LedgerDTOEntity();
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    ledgerDTOEntity.ledgerId = ledgerId;
  }
  final String? ledgerName = jsonConvert.convert<String>(json['ledgerName']);
  if (ledgerName != null) {
    ledgerDTOEntity.ledgerName = ledgerName;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    ledgerDTOEntity.remark = remark;
  }
  final bool? owner = jsonConvert.convert<bool>(json['owner']);
  if (owner != null) {
    ledgerDTOEntity.owner = owner;
  }
  return ledgerDTOEntity;
}

Map<String, dynamic> $LedgerDTOEntityToJson(LedgerDTOEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ledgerId'] = entity.ledgerId;
  data['ledgerName'] = entity.ledgerName;
  data['remark'] = entity.remark;
  data['owner'] = entity.owner;
  return data;
}

extension LedgerDTOEntityExtension on LedgerDTOEntity {
  LedgerDTOEntity copyWith({
    int? ledgerId,
    String? ledgerName,
    String? remark,
    bool? owner,
  }) {
    return LedgerDTOEntity()
      ..ledgerId = ledgerId ?? this.ledgerId
      ..ledgerName = ledgerName ?? this.ledgerName
      ..remark = remark ?? this.remark
      ..owner = owner ?? this.owner;
  }
}