import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/entity/auth/sys_res_dto.dart';
import 'package:ledger/generated/json/sys_res_dto.g.dart';
import 'package:ledger/generated/json/ledger_tree_node.g.dart';
import 'dart:convert';

@JsonSerializable()
class LedgerTreeNode {
  int? nodeId;
  int? parentId;
  int? level;
  SysResDTO? value;
  List<LedgerTreeNode>? children;
  int? ordinal;
  bool? expanded;
  bool? selected;

  LedgerTreeNode();

  factory LedgerTreeNode.fromJson(Map<String, dynamic> json) =>
      $LedgerTreeNodeFromJson(json);

  Map<String, dynamic> toJson() => $LedgerTreeNodeToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
