enum UnitType { SINGLE, MULTI_WEIGHT, MULTI_NUMBER }

extension UnitTypeExtension on UnitType {
  int get value {
    switch (this) {
      case UnitType.SINGLE:
        return 0;
      case UnitType.MULTI_WEIGHT:
        return 1;
      case UnitType.MULTI_NUMBER:
        return 2;
      default:
        throw Exception('Unsupported UnitType');
    }
  }
}
