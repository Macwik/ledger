import 'package:ledger/config/constant.dart';
import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/http/page_list_result.dart';
import 'package:ledger/util/logger_util.dart';
import 'package:ledger/util/object_util.dart';

class BaseEntity<T> {
  int? c;
  String? m;
  T? d;

  BaseEntity(this.c, this.m, this.d);

  bool get success => Constant.OK_CODE == c;

  bool get strictSuccess =>
      Constant.OK_CODE == c && ObjectUtil.isNotEmpty(d); //严格模式的返回成功

  BaseEntity.fromJson(Map<String, dynamic> json) {
    c = json[Constant.code] as int?;
    m = json[Constant.message] as String?;
    if (json.containsKey(Constant.data) &&
        json[Constant.data] != null &&
        json[Constant.data] != '') {
      d = _generateOBJ<T>(json[Constant.data] as Object);
    }
  }

  T? _generateOBJ<T>(Object json) {
    if (T.toString() == 'String') {
      return json.toString() as T;
    } else if (T.toString() == 'Map<dynamic, dynamic>') {
      return json as T;
    } else if (T.toString().startsWith('PageListResult<')) {
      return PageListResult.from(json as Map<String, dynamic>) as T;
    } else {
      /// List类型数据由fromJsonAsT判断处理
      return JsonConvert.fromJsonAsT<T>(json);
    }
  }
}
