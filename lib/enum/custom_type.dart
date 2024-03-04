enum CustomType { CUSTOM, SUPPLIER }

extension CustomTypeExtension on CustomType {
  int get value {
    switch (this) {
      case CustomType.CUSTOM:
        return 0;
      case CustomType.SUPPLIER:
        return 1;
      default:
        throw Exception('Unsupported CustomType');
    }
  }
}