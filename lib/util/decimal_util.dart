import 'package:decimal/decimal.dart';

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
      return '￥0';
    }
    if (Decimal.zero == amount) {
      return '￥0';
    }
    return '￥${Decimal.parse(amount.toStringAsFixed(scale))}';
  }

  static String formatNegativeAmount(Decimal? amount, {int scale = 2}) {
    if (null == amount) {
      return '';
    }
    if (Decimal.zero == amount) {
      return '￥0';
    }
    return '￥-${Decimal.parse(amount.toStringAsFixed(scale))}';
  }

  static String formatDecimalNumber(Decimal? amount, {int scale = 2}) {
    if (null == amount) {
      return '0';
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

  // /// 减法
  // static Decimal subtractDecimal(Decimal? first, Decimal? second) {
  //   first = first ?? Decimal.zero;
  //   second = second ?? Decimal.zero;
  //   return first - second;
  // }

  /// 除法
  static Decimal? divide(Decimal? dividend, Decimal? divisor) {
    if ((divisor == null) || (dividend == null)) {
      return null;
    }
    if (divisor == Decimal.zero) {
      return null;
    }
    var rational = dividend / divisor;
    return rational.toDecimal(scaleOnInfinitePrecision: 2);
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

  static String multiply(Decimal slaveStock, Decimal conversion,
      {int scale = 2}) {
    return formatDecimal(slaveStock * conversion);
  }

  static int compare(Decimal left, Decimal right, {int scale = 2}) {
    return left.round(scale: scale).compareTo(right.round(scale: scale));
  }
}
