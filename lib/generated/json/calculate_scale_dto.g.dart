import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/calculate/calculate_scale_dto.dart';

CalculateScaleDTO $CalculateScaleDTOFromJson(Map<String, dynamic> json) {
  final CalculateScaleDTO calculateScaleDTO = CalculateScaleDTO();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    calculateScaleDTO.id = id;
  }
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    calculateScaleDTO.userId = userId;
  }
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    calculateScaleDTO.ledgerId = ledgerId;
  }
  final int? scale = jsonConvert.convert<int>(json['scale']);
  if (scale != null) {
    calculateScaleDTO.scale = scale;
  }
  return calculateScaleDTO;
}

Map<String, dynamic> $CalculateScaleDTOToJson(CalculateScaleDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['userId'] = entity.userId;
  data['ledgerId'] = entity.ledgerId;
  data['scale'] = entity.scale;
  return data;
}

extension CalculateScaleDTOExtension on CalculateScaleDTO {
  CalculateScaleDTO copyWith({
    int? id,
    int? userId,
    int? ledgerId,
    int? scale,
  }) {
    return CalculateScaleDTO()
      ..id = id ?? this.id
      ..userId = userId ?? this.userId
      ..ledgerId = ledgerId ?? this.ledgerId
      ..scale = scale ?? this.scale;
  }
}