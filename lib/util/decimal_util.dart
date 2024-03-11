import 'package:decimal/decimal.dart';
import 'package:ledger/enum/calculate_scale.dart';
import 'package:ledger/store/store_controller.dart';

enum DecimalUnit {
  YUAN, // ¥6.00
  NONE, // 6.00金额无单位修饰
}

class DecimalUtil {
  static final Decimal _decimalTen = Decimal.fromInt(10);

  static String formatPrice(double price,
      {DecimalUnit unit = DecimalUnit.YUAN}) {
    if (unit == DecimalUnit.YUAN) {
      return '¥${Decimal.parse(price.toStringAsFixed(2))}';
    } else {
      return '${Decimal.parse(price.toStringAsFixed(2))}';
    }
  }

  static String formatAmount(Decimal? amount, {int scale = 2}) {
    if (null == amount) {
      return '';
    }
    return '￥${Decimal.parse(amount.toStringAsFixed(scale))}';
  }

  static String formatDecimalNumber(Decimal? amount, {int scale = 2}) {
    if (null == amount) {
      return '';
    }
    if (amount.isInteger) {
      return amount.toBigInt().toString();
    }
    return amount.toStringAsFixed(scale);
  }

  static String formatDecimalDefault(Decimal? amount, {int scale = 2}) {
    if (null == amount) {
      return '';
    }
    if (amount.isInteger) {
      return amount.toBigInt().toString();
    }
    return amount.toStringAsFixed(scale);
  }

  /// 减法
  static String subtract(Decimal? first, Decimal? second) {
    first = first ?? Decimal.zero;
    second = second ?? Decimal.zero;
    return (first - second).toStringAsFixed(2);
  }

  /// 减法
  static Decimal subtractDecimal(Decimal? first, Decimal? second) {
    first = first ?? Decimal.zero;
    second = second ?? Decimal.zero;
    return first - second;
  }

  /// 除法
  static Decimal? divide(Decimal? dividend, Decimal? divisor) {
    if ((divisor == null) || (dividend == null)) {
      return null;
    }
    if (divisor == Decimal.zero) {
      return null;
    }
    var rational = dividend / divisor;
    return rational.toDecimal(scaleOnInfinitePrecision: 4);
  }

  /// 抹零函数
  static Decimal roundToZero(Decimal value) {
    if (value >= _decimalTen) {
      return value % _decimalTen;
    } else {
      if (value < Decimal.zero) {
        throw ArgumentError('DecimalUtil.roundToZero: value < Decimal.zero');
      }
      return value - value.truncate();
    }
  }

  static String formatDecimal(Decimal? value, {int scale = 2}) {
    if (null == value) {
      return '';
    }
    return value.toStringAsFixed(scale);
  }

  static String formatDecimalScale(Decimal? value) {
    if (null == value) {
      return '';
    }
    int scale = StoreController.to.getLedgerCalculateScale();
    CalculateScale calculateScale = getByValue(scale);
    switch (calculateScale) {
      case CalculateScale.KEEP_TWO_DECIMALS:
        return value.toStringAsFixed(2).replaceAll(RegExp(r'\.00'), '');
      case CalculateScale.KEEP_INTEGER:
        return value.toStringAsFixed(0);
      case CalculateScale.KEEP_ONE_DECIMAL:
        return value.toStringAsFixed(1).replaceAll(RegExp(r'\.0'), '');
    }
  }

  static const List<CalculateScale> calculateScaleList = CalculateScale.values;

  static CalculateScale getByValue(int scaleValue) {
    for (var value in calculateScaleList) {
      if (value.value == scaleValue) {
        return value;
      }
    }
    return CalculateScale.KEEP_TWO_DECIMALS;
  }

  static String multiply(Decimal slaveStock, Decimal conversion,
      {int scale = 2}) {
    return formatDecimal(slaveStock * conversion);
  }
}
