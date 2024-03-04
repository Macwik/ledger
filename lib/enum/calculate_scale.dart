enum CalculateScale {
  KEEP_TWO_DECIMALS,
  KEEP_ONE_DECIMAL,
  KEEP_INTEGER,
}

extension CalculateScaleExtension on CalculateScale {
  int get value {
    switch (this) {
      case CalculateScale.KEEP_TWO_DECIMALS:
        return 1;
      case CalculateScale.KEEP_ONE_DECIMAL:
        return 2;
      case CalculateScale.KEEP_INTEGER:
        return 3;
      default:
        throw Exception('无此精确度');
    }
  }

  String get desc {
    switch (this) {
      case CalculateScale.KEEP_TWO_DECIMALS:
        return '保留两位小数';
      case CalculateScale.KEEP_ONE_DECIMAL:
        return '保留一位小数';
      case CalculateScale.KEEP_INTEGER:
        return '取整';
      default:
        throw Exception('无此精确度');
    }
  }
}
