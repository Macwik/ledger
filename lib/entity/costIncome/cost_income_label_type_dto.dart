import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/cost_income_label_type_dto.g.dart';
import 'dart:convert';

@JsonSerializable()
class CostIncomeLabelTypeDTO {
  int? id;
  String? labelName;


  CostIncomeLabelTypeDTO();

  factory CostIncomeLabelTypeDTO.fromJson(Map<String, dynamic> json) =>
      $CostIncomeLabelTypeDTOFromJson(json);

  Map<String, dynamic> toJson() => $CostIncomeLabelTypeDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}