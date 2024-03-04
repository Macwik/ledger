import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'dart:convert';

import 'package:ledger/http/page_constants.dart';

class PageListResult<T> {
  int? totalCount;
  int? count;
  bool? hasMore;
  List<T>? result;
  int? curPage;
  int? size;
  int? totalPage;

  PageListResult();

  PageListResult.from(Map<String, dynamic> json) {
    PageListResult<T>.fromJson(json);
  }

  PageListResult.fromJson(Map<String, dynamic> json) {
    totalCount = json[PageConstants.totalCount] as int?;
    count = json[PageConstants.count] as int?;
    hasMore = json[PageConstants.hasMore] as bool?;
    curPage = json[PageConstants.curPage] as int?;
    size = json[PageConstants.size] as int?;
    totalPage = json[PageConstants.totalPage] as int?;
    if (json.containsKey(PageConstants.result) &&
        json[PageConstants.result] != null &&
        json[PageConstants.result] != '') {
      result = jsonConvert
          .convertListNotNull<T>(json[PageConstants.result] as Object);
    }
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
