import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/auth/sys_res_dto.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/logger_util.dart';

import 'auth_update_controller.dart';
import 'node_wrapper.dart';

class AuthUpdateView extends StatelessWidget {
  final controller = Get.find<AuthUpdateController>();
  final state = Get.find<AuthUpdateController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      appBar: TitleBar(
        title: '${state.roleDTO?.roleName}权限设置',
      ),
      body: GetBuilder<AuthUpdateController>(
          id: 'role_permission_update',
          builder: (_) {
            return state.treeNode == null
                ? EmptyLayout(hintText: '什么都没有')
                : Column(
                    children: [
                      Expanded(
                        child: TreeView.simple(
                          tree: state.treeNode!,
                          showRootNode: true,
                          expansionIndicatorBuilder: (context, node) =>
                              ChevronIndicator.rightDown(
                            tree: node,
                            color: Colors.blue[700],
                            padding: const EdgeInsets.all(8),
                          ),
                          indentation:
                              const Indentation(style: IndentStyle.squareJoint),
                          onItemTap: (item) {
                            LoggerUtil.i('onItemTap----------');
                          },
                          onTreeReady: (controller) {
                            state.treeViewController = controller;
                            controller.expandAllChildren(state.treeNode!);
                          },
                          builder: (context, node) {
                            var nodeWrapper = node as NodeWrapper<SysResDTO>;
                            SysResDTO? sysResDTO = nodeWrapper.data;
                            return Card(
                                child: Row(children: [
                              Expanded(
                                flex: 8,
                                child: ListTile(
                                  title: Text(sysResDTO?.resName ?? ''),
                                  subtitle: Text(sysResDTO?.resDesc ?? ''),
                                ),
                              ),
                              Visibility(
                                visible: sysResDTO?.resType != 0,
                                child: Expanded(
                                  flex: 2,
                                  child: Checkbox(
                                      value: state.appendList
                                          .contains(sysResDTO!.resCode),
                                      onChanged: (value) {
                                        controller.updatePermission(value,
                                            sysResDTO.resCode, nodeWrapper);
                                      }),
                                ),
                              )
                            ]));
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => controller.submitUpdatePermission(),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.teal[300]),
                          ),
                          child: Text(
                            '确 认',
                            style: TextStyle(
                              fontSize: 30.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
          }),
    );
  }
}
