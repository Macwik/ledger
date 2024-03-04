import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/payment/payment_method_dto.dart';

PaymentMethodDTO $PaymentMethodDTOFromJson(Map<String, dynamic> json) {
  final PaymentMethodDTO paymentMethodDTO = PaymentMethodDTO();
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    paymentMethodDTO.ledgerId = ledgerId;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    paymentMethodDTO.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    paymentMethodDTO.name = name;
  }
  final String? icon = jsonConvert.convert<String>(json['icon']);
  if (icon != null) {
    paymentMethodDTO.icon = icon;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    paymentMethodDTO.remark = remark;
  }
  final int? ordinal = jsonConvert.convert<int>(json['ordinal']);
  if (ordinal != null) {
    paymentMethodDTO.ordinal = ordinal;
  }
  return paymentMethodDTO;
}

Map<String, dynamic> $PaymentMethodDTOToJson(PaymentMethodDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ledgerId'] = entity.ledgerId;
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['icon'] = entity.icon;
  data['remark'] = entity.remark;
  data['ordinal'] = entity.ordinal;
  return data;
}

extension PaymentMethodDTOExtension on PaymentMethodDTO {
  PaymentMethodDTO copyWith({
    int? ledgerId,
    int? id,
    String? name,
    String? icon,
    String? remark,
    int? ordinal,
  }) {
    return PaymentMethodDTO()
      ..ledgerId = ledgerId ?? this.ledgerId
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..icon = icon ?? this.icon
      ..remark = remark ?? this.remark
      ..ordinal = ordinal ?? this.ordinal;
  }
}