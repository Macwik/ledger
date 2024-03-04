import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/app/app_check_dto.dart';

AppCheckDTO $AppCheckDTOFromJson(Map<String, dynamic> json) {
  final AppCheckDTO appCheckDTO = AppCheckDTO();
  final bool? latest = jsonConvert.convert<bool>(json['latest']);
  if (latest != null) {
    appCheckDTO.latest = latest;
  }
  final bool? forceUpdate = jsonConvert.convert<bool>(json['forceUpdate']);
  if (forceUpdate != null) {
    appCheckDTO.forceUpdate = forceUpdate;
  }
  final String? latestVersion = jsonConvert.convert<String>(
      json['latestVersion']);
  if (latestVersion != null) {
    appCheckDTO.latestVersion = latestVersion;
  }
  final String? latestUrl = jsonConvert.convert<String>(json['latestUrl']);
  if (latestUrl != null) {
    appCheckDTO.latestUrl = latestUrl;
  }
  final List<String>? updateContent = (json['updateContent'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<String>(e) as String)
      .toList();
  if (updateContent != null) {
    appCheckDTO.updateContent = updateContent;
  }
  return appCheckDTO;
}

Map<String, dynamic> $AppCheckDTOToJson(AppCheckDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['latest'] = entity.latest;
  data['forceUpdate'] = entity.forceUpdate;
  data['latestVersion'] = entity.latestVersion;
  data['latestUrl'] = entity.latestUrl;
  data['updateContent'] = entity.updateContent;
  return data;
}

extension AppCheckDTOExtension on AppCheckDTO {
  AppCheckDTO copyWith({
    bool? latest,
    bool? forceUpdate,
    String? latestVersion,
    String? latestUrl,
    List<String>? updateContent,
  }) {
    return AppCheckDTO()
      ..latest = latest ?? this.latest
      ..forceUpdate = forceUpdate ?? this.forceUpdate
      ..latestVersion = latestVersion ?? this.latestVersion
      ..latestUrl = latestUrl ?? this.latestUrl
      ..updateContent = updateContent ?? this.updateContent;
  }
}