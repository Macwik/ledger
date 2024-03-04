import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/app_check_dto.g.dart';
import 'dart:convert';

@JsonSerializable()
class AppCheckDTO {
  bool? latest;
  bool? forceUpdate;
  String? latestVersion;
  String? latestUrl;
  List<String>? updateContent;

  AppCheckDTO({
    this.latest,
    this.forceUpdate,
    this.latestVersion,
    this.latestUrl,
    this.updateContent,
  });

  factory AppCheckDTO.fromJson(Map<String, dynamic> json) =>
      $AppCheckDTOFromJson(json);

  Map<String, dynamic> toJson() => $AppCheckDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
