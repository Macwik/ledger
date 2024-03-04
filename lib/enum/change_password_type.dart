enum ChangePasswordType { FORGET, UPDATE }

extension ChangePasswordTypeExtension on ChangePasswordType {
  int get value {
    switch (this) {
      case ChangePasswordType.FORGET:
        return 0;
      case ChangePasswordType.UPDATE:
        return 1;
      default:
        throw Exception('Unsupported ChangePasswordType');
    }
  }
}
