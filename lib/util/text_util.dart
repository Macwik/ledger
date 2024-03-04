/// Text Util.
class TextUtil {
  static final RegExp inputAmountRegExp =
      RegExp(r'^(0(\.\d+)?|0|[1-9]\d*(\.\d+)?)$');

  static final RegExp phoneRegExp = RegExp(
      r'^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$');

  /// isEmpty
  static bool isEmpty(String? text) {
    return text == null || text.isEmpty;
  }

  /// 每隔 x位 加 pattern
  static String formatDigitPattern(String text,
      {int digit = 4, String pattern = ' '}) {
    text = text.replaceAllMapped(RegExp('(.{$digit})'), (Match match) {
      return '${match.group(0)}$pattern';
    });
    if (text.endsWith(pattern)) {
      text = text.substring(0, text.length - 1);
    }
    return text;
  }

  /// 校验输入的字符串是否为正实数
  static bool validNumber(String text) {
    return inputAmountRegExp.hasMatch(text);
  }

  /// 每隔 x位 加 pattern, 从末尾开始
  static String formatDigitPatternEnd(String text,
      {int digit = 4, String pattern = ' '}) {
    String temp = reverse(text);
    temp = formatDigitPattern(temp, digit: digit, pattern: pattern);
    temp = reverse(temp);
    return temp;
  }

  /// 每隔4位加空格
  static String formatSpace4(String text) {
    return formatDigitPattern(text);
  }

  /// 每隔3三位加逗号
  /// num 数字或数字字符串。int型。
  static String formatComma3(Object num) {
    return formatDigitPatternEnd(num.toString(), digit: 3, pattern: ',');
  }

  /// 每隔3三位加逗号
  /// num 数字或数字字符串。double型。
  static String formatDoubleComma3(Object num,
      {int digit = 3, String pattern = ','}) {
    List<String> list = num.toString().split('.');
    String left =
        formatDigitPatternEnd(list[0], digit: digit, pattern: pattern);
    String right = list[1];
    return '$left.$right';
  }

  /// 隐藏手机号中间四位
  static String hideNumber(String phoneNo,
      {int start = 3, int end = 7, String replacement = '****'}) {
    if (isEmpty(phoneNo) || phoneNo.length != 11) {
      return '';
    } else {
      return phoneNo.replaceRange(start, end, replacement);
    }
  }

  /// replace
  static String replace(String text, Pattern from, String replace) {
    return text.replaceAll(from, replace);
  }

  /// split
  static List<String> split(String text, Pattern pattern) {
    return text.split(pattern);
  }

  /// reverse
  static String reverse(String text) {
    if (isEmpty(text)) return '';
    StringBuffer sb = StringBuffer();
    for (int i = text.length - 1; i >= 0; i--) {
      sb.writeCharCode(text.codeUnitAt(i));
    }
    return sb.toString();
  }

  static String listToStr(List<String>? list) {
    if (null == list || list.isEmpty) {
      return '';
    }
    String result = '';
    for (var element in list) {
      result = '$result$element ';
    }
    if (result.length >= 20) {
      return '${result.substring(0, 20)}...';
    }
    return result;
  }

  static bool isPhone(String? phone) {
    if (phone == null) {
      return false;
    }
    return phoneRegExp.hasMatch(phone);
  }
}
