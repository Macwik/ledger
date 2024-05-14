enum UserStatus { NO_REGISTER, NO_ACTIVE, ACTIVE }

extension UserStatusExtension on UserStatus {
  int get value {
    switch (this) {
      case UserStatus.ACTIVE:
        return 2;
      case UserStatus.NO_ACTIVE:
        return 1;
      case UserStatus.NO_REGISTER:
        return 0;
      default:
        throw Exception('Unsupported ChangeStatus');
    }
  }
}
