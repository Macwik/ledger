import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:ledger/entity/auth/role_dto.dart';
import 'package:ledger/entity/auth/sys_res_dto.dart';

import 'node_wrapper.dart';

class AuthUpdateState {
  AuthUpdateState() {
    ///Initialize variables
  }

  RoleDTO? roleDTO;

  List<String> appendList = [];
  List<String> removeList = [];

  TreeViewController? treeViewController;

  NodeWrapper<SysResDTO>? treeNode;

}
