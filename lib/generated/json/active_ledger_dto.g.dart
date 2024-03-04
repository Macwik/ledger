import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/ledger/active_ledger_dto.dart';

ActiveLedgerDTO $ActiveLedgerDTOFromJson(Map<String, dynamic> json) {
  final ActiveLedgerDTO activeLedgerDTO = ActiveLedgerDTO();
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    activeLedgerDTO.ledgerId = ledgerId;
  }
  final String? ledgerName = jsonConvert.convert<String>(json['ledgerName']);
  if (ledgerName != null) {
    activeLedgerDTO.ledgerName = ledgerName;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    activeLedgerDTO.remark = remark;
  }
  return activeLedgerDTO;
}

Map<String, dynamic> $ActiveLedgerDTOToJson(ActiveLedgerDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ledgerId'] = entity.ledgerId;
  data['ledgerName'] = entity.ledgerName;
  data['remark'] = entity.remark;
  return data;
}

extension ActiveLedgerDTOExtension on ActiveLedgerDTO {
  ActiveLedgerDTO copyWith({
    int? ledgerId,
    String? ledgerName,
    String? remark,
  }) {
    return ActiveLedgerDTO()
      ..ledgerId = ledgerId ?? this.ledgerId
      ..ledgerName = ledgerName ?? this.ledgerName
      ..remark = remark ?? this.remark;
  }
}