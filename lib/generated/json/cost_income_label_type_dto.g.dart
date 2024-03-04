import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/costIncome/cost_income_label_type_dto.dart';

CostIncomeLabelTypeDTO $CostIncomeLabelTypeDTOFromJson(
    Map<String, dynamic> json) {
  final CostIncomeLabelTypeDTO costIncomeLabelTypeDTO = CostIncomeLabelTypeDTO();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    costIncomeLabelTypeDTO.id = id;
  }
  final String? labelName = jsonConvert.convert<String>(json['labelName']);
  if (labelName != null) {
    costIncomeLabelTypeDTO.labelName = labelName;
  }
  return costIncomeLabelTypeDTO;
}

Map<String, dynamic> $CostIncomeLabelTypeDTOToJson(
    CostIncomeLabelTypeDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['labelName'] = entity.labelName;
  return data;
}

extension CostIncomeLabelTypeDTOExtension on CostIncomeLabelTypeDTO {
  CostIncomeLabelTypeDTO copyWith({
    int? id,
    String? labelName,
  }) {
    return CostIncomeLabelTypeDTO()
      ..id = id ?? this.id
      ..labelName = labelName ?? this.labelName;
  }
}