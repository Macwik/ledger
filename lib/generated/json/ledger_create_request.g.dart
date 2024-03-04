import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/ledger/ledger_create_request.dart';

LedgerCreateRequest $LedgerCreateRequestFromJson(Map<String, dynamic> json) {
  final LedgerCreateRequest ledgerCreateRequest = LedgerCreateRequest();
  final String? ledgerName = jsonConvert.convert<String>(json['ledgerName']);
  if (ledgerName != null) {
    ledgerCreateRequest.ledgerName = ledgerName;
  }
  final int? storeType = jsonConvert.convert<int>(json['storeType']);
  if (storeType != null) {
    ledgerCreateRequest.storeType = storeType;
  }
  final int? businessScope = jsonConvert.convert<int>(json['businessScope']);
  if (businessScope != null) {
    ledgerCreateRequest.businessScope = businessScope;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    ledgerCreateRequest.remark = remark;
  }
  return ledgerCreateRequest;
}

Map<String, dynamic> $LedgerCreateRequestToJson(LedgerCreateRequest entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ledgerName'] = entity.ledgerName;
  data['storeType'] = entity.storeType;
  data['businessScope'] = entity.businessScope;
  data['remark'] = entity.remark;
  return data;
}

extension LedgerCreateRequestExtension on LedgerCreateRequest {
  LedgerCreateRequest copyWith({
    String? ledgerName,
    int? storeType,
    int? businessScope,
    String? remark,
  }) {
    return LedgerCreateRequest()
      ..ledgerName = ledgerName ?? this.ledgerName
      ..storeType = storeType ?? this.storeType
      ..businessScope = businessScope ?? this.businessScope
      ..remark = remark ?? this.remark;
  }
}