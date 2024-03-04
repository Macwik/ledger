import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/auth/ledger_tree_node.dart';
import 'package:ledger/entity/auth/sys_res_dto.dart';


LedgerTreeNode $LedgerTreeNodeFromJson(Map<String, dynamic> json) {
  final LedgerTreeNode ledgerTreeNode = LedgerTreeNode();
  final int? nodeId = jsonConvert.convert<int>(json['nodeId']);
  if (nodeId != null) {
    ledgerTreeNode.nodeId = nodeId;
  }
  final int? parentId = jsonConvert.convert<int>(json['parentId']);
  if (parentId != null) {
    ledgerTreeNode.parentId = parentId;
  }
  final int? level = jsonConvert.convert<int>(json['level']);
  if (level != null) {
    ledgerTreeNode.level = level;
  }
  final SysResDTO? value = jsonConvert.convert<SysResDTO>(json['value']);
  if (value != null) {
    ledgerTreeNode.value = value;
  }
  final List<LedgerTreeNode>? children = (json['children'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<LedgerTreeNode>(e) as LedgerTreeNode)
      .toList();
  if (children != null) {
    ledgerTreeNode.children = children;
  }
  final int? ordinal = jsonConvert.convert<int>(json['ordinal']);
  if (ordinal != null) {
    ledgerTreeNode.ordinal = ordinal;
  }
  final bool? expanded = jsonConvert.convert<bool>(json['expanded']);
  if (expanded != null) {
    ledgerTreeNode.expanded = expanded;
  }
  final bool? selected = jsonConvert.convert<bool>(json['selected']);
  if (selected != null) {
    ledgerTreeNode.selected = selected;
  }
  return ledgerTreeNode;
}

Map<String, dynamic> $LedgerTreeNodeToJson(LedgerTreeNode entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['nodeId'] = entity.nodeId;
  data['parentId'] = entity.parentId;
  data['level'] = entity.level;
  data['value'] = entity.value?.toJson();
  data['children'] = entity.children?.map((v) => v.toJson()).toList();
  data['ordinal'] = entity.ordinal;
  data['expanded'] = entity.expanded;
  data['selected'] = entity.selected;
  return data;
}

extension LedgerTreeNodeExtension on LedgerTreeNode {
  LedgerTreeNode copyWith({
    int? nodeId,
    int? parentId,
    int? level,
    SysResDTO? value,
    List<LedgerTreeNode>? children,
    int? ordinal,
    bool? expanded,
    bool? selected,
  }) {
    return LedgerTreeNode()
      ..nodeId = nodeId ?? this.nodeId
      ..parentId = parentId ?? this.parentId
      ..level = level ?? this.level
      ..value = value ?? this.value
      ..children = children ?? this.children
      ..ordinal = ordinal ?? this.ordinal
      ..expanded = expanded ?? this.expanded
      ..selected = selected ?? this.selected;
  }
}