enum CostOrderType { COST, INCOME }

extension CostOrderTypeExtension on CostOrderType {
  int get value {
    switch (this) {
      case CostOrderType.COST:
        return 0;
      case CostOrderType.INCOME:
        return 1;
      default:
        throw Exception('Unsupported CostOrderType');
    }
  }
}