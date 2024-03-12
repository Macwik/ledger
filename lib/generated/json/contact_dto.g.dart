import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/contact/contact_dto.dart';

ContactDTO $ContactDTOFromJson(Map<String, dynamic> json) {
  final ContactDTO contactDTO = ContactDTO();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    contactDTO.name = name;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    contactDTO.phone = phone;
  }
  return contactDTO;
}

Map<String, dynamic> $ContactDTOToJson(ContactDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['phone'] = entity.phone;
  return data;
}

extension ContactDTOExtension on ContactDTO {
  ContactDTO copyWith({
    String? name,
    String? phone,
  }) {
    return ContactDTO()
      ..name = name ?? this.name
      ..phone = phone ?? this.phone;
  }
}