import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/user/user_status_dto.dart';
import 'package:ledger/entity/user/user_dto_entity.dart';


UserStatusDTO $UserStatusDTOFromJson(Map<String, dynamic> json) {
  final UserStatusDTO userStatusDTO = UserStatusDTO();
  final int? statusCode = jsonConvert.convert<int>(json['statusCode']);
  if (statusCode != null) {
    userStatusDTO.statusCode = statusCode;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    userStatusDTO.phone = phone;
  }
  final UserDTOEntity? userDTO = jsonConvert.convert<UserDTOEntity>(
      json['userDTO']);
  if (userDTO != null) {
    userStatusDTO.userDTO = userDTO;
  }
  return userStatusDTO;
}

Map<String, dynamic> $UserStatusDTOToJson(UserStatusDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['statusCode'] = entity.statusCode;
  data['phone'] = entity.phone;
  data['userDTO'] = entity.userDTO?.toJson();
  return data;
}

extension UserStatusDTOExtension on UserStatusDTO {
  UserStatusDTO copyWith({
    int? statusCode,
    String? phone,
    UserDTOEntity? userDTO,
  }) {
    return UserStatusDTO()
      ..statusCode = statusCode ?? this.statusCode
      ..phone = phone ?? this.phone
      ..userDTO = userDTO ?? this.userDTO;
  }
}