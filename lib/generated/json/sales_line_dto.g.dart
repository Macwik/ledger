import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/setting/sales_line_dto.dart';

SalesLineDTO $SalesLineDTOFromJson(Map<String, dynamic> json) {
  final SalesLineDTO salesLineDTO = SalesLineDTO();
  final String? startTime = jsonConvert.convert<String>(json['startTime']);
  if (startTime != null) {
    salesLineDTO.startTime = startTime;
  }
  final String? endTime = jsonConvert.convert<String>(json['endTime']);
  if (endTime != null) {
    salesLineDTO.endTime = endTime;
  }
  return salesLineDTO;
}

Map<String, dynamic> $SalesLineDTOToJson(SalesLineDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['startTime'] = entity.startTime;
  data['endTime'] = entity.endTime;
  return data;
}

extension SalesLineDTOExtension on SalesLineDTO {
  SalesLineDTO copyWith({
    String? startTime,
    String? endTime,
  }) {
    return SalesLineDTO()
      ..startTime = startTime ?? this.startTime
      ..endTime = endTime ?? this.endTime;
  }
}