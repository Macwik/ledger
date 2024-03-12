import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/contact_dto.g.dart';
import 'dart:convert';

@JsonSerializable()
class ContactDTO {
  String name;
  String phone;

  ContactDTO({this.name, this.phone});

  factory ContactDTO.fromJson(Map<String, dynamic> json) =>
      $ContactDTOFromJson(json);

  Map<String, dynamic> toJson() => $ContactDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
