import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/auth/role_dto.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/widget/empty_layout.dart';
import 'package:ledger/widget/image.dart';

import 'permission_manage_controller.dart';

class PermissionManageView extends StatelessWidget {
  final controller = Get.find<PermissionManageController>();
  final state = Get.find<PermissionManageController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      appBar: TitleBar(
        title:
          '岗位管理',
        actionWidget:
          Row(children: [
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: InkWell(
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: controller.toAddRole,
                        child: LoadAssetImage(
                          'add',
                          width: 30.w,
                          height: 30.w,
                          color: Colors.black54,
                        ))
                  ],
                ),
              ),
            ),
          ])
      ),
      body: GetBuilder<PermissionManageController>(
          id: 'permission_manage_list',
          builder: (_) {
            return state.roleList?.isEmpty ?? true
                ? EmptyLayout(hintText: '什么都没有'.tr)
                : ListView.separated(
                    itemBuilder: (context, index) {
                      RoleDTO roleDTO = state.roleList![index];
                      return InkWell(
                          onTap: () {
                            controller.toRoleAuth(roleDTO);
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.w, vertical: 40.w),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      roleDTO.roleName ?? '',
                                      style: TextStyle(
                                        color: Colours.text_333,
                                        fontSize: 32.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      roleDTO.roleDesc ?? '',
                                      style: TextStyle(
                                        color: Colours.text_666,
                                        fontSize: 26.sp,
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                  ],
                                )),
                                LoadAssetImage(
                                  'common/arrow_right',
                                  width: 25.w,
                                  color: Colours.text_999,
                                ),
                              ],
                            ),
                          ));
                    },
                    //separatorBuilder是分隔符组件，可以直接拿来用
                    separatorBuilder: (context, index) => Container(
                      height: 2.w,
                      color: Colours.divider,
                      width: double.infinity,
                    ),
                    itemCount: state.roleList?.length ?? 0,
                  );
          }),
    );
  }
}
