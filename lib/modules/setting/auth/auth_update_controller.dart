import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/auth_api.dart';
import 'package:ledger/entity/auth/ledger_tree_node.dart';
import 'package:ledger/entity/auth/sys_res_dto.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/store/store_controller.dart';
import 'package:ledger/modules/setting/auth/node_wrapper.dart';

import 'auth_update_state.dart';

class AuthUpdateController extends GetxController {
  final AuthUpdateState state = AuthUpdateState();

  Future<void> initState() async {
    var arguments = Get.arguments;
    if (arguments != null && arguments['role'] != null) {
      state.roleDTO = arguments['role'];
    }
    await _queryData();
  }

  _queryData() {
    Http().network<List<LedgerTreeNode>>(Method.get, AuthApi.query_role_auth,
        queryParameters: {
          'roleId': state.roleDTO?.id,
        }).then((result) {
      if (result.success) {
        var treeNodes = buildTreeNodes(result.d!);
        state.treeNode = treeNodes;
        update(['role_permission_update']);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  NodeWrapper<SysResDTO> buildTreeNodes(List<LedgerTreeNode> ledgerTreeNodes) {
    state.appendList.clear();
    NodeWrapper<SysResDTO> root = NodeWrapper<SysResDTO>(
        data: SysResDTO(
            resType: 0,
            resName:
                StoreController.to.getUser()?.activeLedger?.ledgerName ?? ''));
    List<NodeWrapper<SysResDTO>> result = [];
    for (var node in ledgerTreeNodes) {
      var sysResDTO = node.value;
      var treeNode =
          NodeWrapper<SysResDTO>(data: sysResDTO, select: node.selected);
      if ((node.selected ?? false) &&
          (sysResDTO?.resCode?.isNotEmpty ?? false)) {
        state.appendList.add(sysResDTO!.resCode!);
      }
      buildTreeNode(node, treeNode);
      result.add(treeNode);
    }
    root.addAll(result);
    return root;
  }

  void buildTreeNode(
      LedgerTreeNode ledgerTreeNode, NodeWrapper<SysResDTO> treeNode) {
    List<LedgerTreeNode>? children = ledgerTreeNode.children;
    if (children?.isEmpty ?? true) {
      return;
    }

    children!.sort((a, b) {
      return a.ordinal!.compareTo(b.ordinal!);
    });
    for (var child in children) {
      var sysResDTO = child.value;
      var childNode =
          NodeWrapper<SysResDTO>(data: child.value, select: child.selected);
      if ((child.selected ?? false) &&
          (sysResDTO?.resCode?.isNotEmpty ?? false)) {
        state.appendList.add(sysResDTO!.resCode!);
      }
      treeNode.add(childNode);
      buildTreeNode(child, childNode);
    }
  }

  void updatePermission(bool? check, String? resCode, NodeWrapper nodeWrapper) {
    if (null == check || (resCode?.isEmpty ?? true)) {
      return;
    }
    List<String> codeList = [resCode!];
    List<ListenableNode> childrenAsList = nodeWrapper.childrenAsList;
    if (childrenAsList.isNotEmpty) {
      for (var element in childrenAsList) {
        var wrapperElement = element as NodeWrapper;
        if (wrapperElement.data?.resCode?.isNotEmpty ?? false) {
          codeList.add(element.data!.resCode!);
        }
      }
    }
    if (check) {
      state.appendList.addAll(codeList);
      state.removeList.removeWhere((resCode) => codeList.contains(resCode));
    } else {
      state.removeList.addAll(codeList);
      state.appendList.removeWhere((resCode) => codeList.contains(resCode));
    }
    update(['role_permission_update']);
  }

  void submitUpdatePermission() {
    Loading.showDuration();
    Http().network<void>(Method.post, AuthApi.role_auth_update, data: {
      'roleId': state.roleDTO?.id,
      'appendPermissions': state.appendList,
      'removePermissions': state.removeList,
    }).then((result) {
      Loading.dismiss();
      if (result.success) {
        Get.snackbar('提示', '更新成功');
      } else {
        Toast.show(result.m.toString());
      }
    });
  }
}
