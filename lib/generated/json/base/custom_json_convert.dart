import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart' show debugPrint;

class CustomJsonConvert extends JsonConvert {
  @override
  T? convert<T>(dynamic value, {EnumConvertFunction? enumConvert}) {
    if (value == null) {
      return null;
    }
    if (value is T) {
      return value;
    }
    try {
      return asT<T>(value, enumConvert: enumConvert);
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      return null;
    }
  }

  T? asT<T extends Object?>(dynamic value, {EnumConvertFunction? enumConvert}) {
    final String type = T.toString();
    final String valueS = value.toString();
    if (enumConvert != null) {
      return enumConvert(valueS) as T;
    } else if (type == "String") {
      return valueS as T;
    } else if (type == "int") {
      final int? intValue = int.tryParse(valueS);
      if (intValue == null) {
        return double.tryParse(valueS)?.toInt() as T?;
      } else {
        return intValue as T;
      }
    } else if (type == "double") {
      return double.parse(valueS) as T;
    } else if (type == "DateTime") {
      return DateTime.parse(valueS) as T;
    } else if (type == "bool") {
      if (valueS == '0' || valueS == '1') {
        return (valueS == '1') as T;
      }
      return (valueS == 'true') as T;
    } else if (type == "Decimal") {
      return Decimal.parse(value.toString()) as T;
    } else if (type == "Map" || type.startsWith("Map<")) {
      return value as T;
    } else {
      if (convertFuncMap.containsKey(type)) {
        if (value == null) {
          return null;
        }
        return convertFuncMap[type]!(Map<String, dynamic>.from(value)) as T;
      } else {
        throw UnimplementedError(
            '$type unimplemented,you can try running the app again');
      }
    }
  }
}
