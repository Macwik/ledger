import 'package:ledger/config/constant.dart';
import 'package:ledger/http/page_list_result.dart';
import 'package:ledger/util/object_util.dart';

class BasePageEntity<T> {
  int? c;
  String? m;
  PageListResult<T>? d;

  BasePageEntity(this.c, this.m, this.d);

  bool get success => Constant.OK_CODE == c;

  bool get strictSuccess =>
      Constant.OK_CODE == c && ObjectUtil.isNotEmpty(d); //严格模式的返回成功

  BasePageEntity.fromJson(Map<String, dynamic> json) {
    c = json[Constant.code] as int?;
    m = json[Constant.message] as String?;
    if (json.containsKey(Constant.data) &&
        json[Constant.data] != null &&
        json[Constant.data] != '') {
      d = _generatePageOBJ<T>(json[Constant.data] as Map<String, dynamic>);
    }
  }

  PageListResult<T>? _generatePageOBJ<T>(Map<String, dynamic> json) {
    return PageListResult<T>.fromJson(json);
  }
}
