import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:decimal/decimal.dart';


CustomDTO $CustomDTOFromJson(Map<String, dynamic> json) {
  final CustomDTO customDTO = CustomDTO();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    customDTO.id = id;
  }
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    customDTO.ledgerId = ledgerId;
  }
  final String? customName = jsonConvert.convert<String>(json['customName']);
  if (customName != null) {
    customDTO.customName = customName;
  }
  final String? contact = jsonConvert.convert<String>(json['contact']);
  if (contact != null) {
    customDTO.contact = contact;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    customDTO.phone = phone;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    customDTO.address = address;
  }
  final Decimal? tradeAmount = jsonConvert.convert<Decimal>(
      json['tradeAmount']);
  if (tradeAmount != null) {
    customDTO.tradeAmount = tradeAmount;
  }
  final Decimal? creditAmount = jsonConvert.convert<Decimal>(
      json['creditAmount']);
  if (creditAmount != null) {
    customDTO.creditAmount = creditAmount;
  }
  final int? invalid = jsonConvert.convert<int>(json['invalid']);
  if (invalid != null) {
    customDTO.invalid = invalid;
  }
  final int? used = jsonConvert.convert<int>(json['used']);
  if (used != null) {
    customDTO.used = used;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    customDTO.remark = remark;
  }
  final int? customType = jsonConvert.convert<int>(json['customType']);
  if (customType != null) {
    customDTO.customType = customType;
  }
  return customDTO;
}

Map<String, dynamic> $CustomDTOToJson(CustomDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['ledgerId'] = entity.ledgerId;
  data['customName'] = entity.customName;
  data['contact'] = entity.contact;
  data['phone'] = entity.phone;
  data['address'] = entity.address;
  data['tradeAmount'] = entity.tradeAmount?.toJson();
  data['creditAmount'] = entity.creditAmount?.toJson();
  data['invalid'] = entity.invalid;
  data['used'] = entity.used;
  data['remark'] = entity.remark;
  data['customType'] = entity.customType;
  return data;
}

extension CustomDTOExtension on CustomDTO {
  CustomDTO copyWith({
    int? id,
    int? ledgerId,
    String? customName,
    String? contact,
    String? phone,
    String? address,
    Decimal? tradeAmount,
    Decimal? creditAmount,
    int? invalid,
    int? used,
    String? remark,
    int? customType,
  }) {
    return CustomDTO()
      ..id = id ?? this.id
      ..ledgerId = ledgerId ?? this.ledgerId
      ..customName = customName ?? this.customName
      ..contact = contact ?? this.contact
      ..phone = phone ?? this.phone
      ..address = address ?? this.address
      ..tradeAmount = tradeAmount ?? this.tradeAmount
      ..creditAmount = creditAmount ?? this.creditAmount
      ..invalid = invalid ?? this.invalid
      ..used = used ?? this.used
      ..remark = remark ?? this.remark
      ..customType = customType ?? this.customType;
  }
}