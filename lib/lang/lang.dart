import 'package:get/get.dart';
import 'package:ledger/lang/en_us.dart';
import 'package:ledger/lang/zh_cn.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': zh_CN,
        'en_US': en_US,
      };
}
