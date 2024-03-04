import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/auth/user_authorization_dto.dart';

UserAuthorizationDTO $UserAuthorizationDTOFromJson(Map<String, dynamic> json) {
  final UserAuthorizationDTO userAuthorizationDTO = UserAuthorizationDTO();
  final List<String>? authorizationCodes = (json['authorizationCodes'] as List<
      dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (authorizationCodes != null) {
    userAuthorizationDTO.authorizationCodes = authorizationCodes;
  }
  final bool? latest = jsonConvert.convert<bool>(json['latest']);
  if (latest != null) {
    userAuthorizationDTO.latest = latest;
  }
  final int? version = jsonConvert.convert<int>(json['version']);
  if (version != null) {
    userAuthorizationDTO.version = version;
  }
  return userAuthorizationDTO;
}

Map<String, dynamic> $UserAuthorizationDTOToJson(UserAuthorizationDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['authorizationCodes'] = entity.authorizationCodes;
  data['latest'] = entity.latest;
  data['version'] = entity.version;
  return data;
}

extension UserAuthorizationDTOExtension on UserAuthorizationDTO {
  UserAuthorizationDTO copyWith({
    List<String>? authorizationCodes,
    bool? latest,
    int? version,
  }) {
    return UserAuthorizationDTO()
      ..authorizationCodes = authorizationCodes ?? this.authorizationCodes
      ..latest = latest ?? this.latest
      ..version = version ?? this.version;
  }
}