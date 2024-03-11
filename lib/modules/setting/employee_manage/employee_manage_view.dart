import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/user/user_base_dto.dart';
import 'package:ledger/modules/setting/employee_manage/employee_manage_controller.dart';
import 'package:ledger/res/export.dart';

class EmployeeManageView extends StatelessWidget {
  final controller = Get.find<EmployeeManageController>();
  final state = Get.find<EmployeeManageController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      appBar: AppBar(
        title: Text('员工管理',style: TextStyle(color: Colors.white),),
        leading: BackButton(color: Colors.white,),),
      body: Column(
          children: [
            Container(
              height: 20.w,
              width: double.infinity,
            ),
            InkWell(
              onTap: controller.toInviteEmployee,
              child: Container(
                color: Colors.white,
                height: 100.w,
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Row(
                  children: [
                    SizedBox(width: 20.w),
                    Text(
                      '邀请员工',
                      style: TextStyle(
                        color: Colours.text_333,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 25.w,
                      color: Colours.text_ccc,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colours.divider,
              height: 1.w,
              width: double.infinity,
            ),
            InkWell(
              onTap: controller.toPermissionManage,
              child: Container(
                color: Colors.white,
                height: 100.w,
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Row(
                  children: [
                    SizedBox(width: 20.w),
                    Text(
                      '岗位权限管理',
                      style: TextStyle(
                        color: Colours.text_333,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 25.w,
                      color: Colours.text_ccc,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white12,
              height: 40.w,
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(24,10.0, 0.0, 5.0),
              child: Text(
                '营业员',
                style: TextStyle(fontSize: 28.sp, color: Colours.text_ccc),
              ),
            ),
            GetBuilder<EmployeeManageController>(
              id: 'employee_manage_employee_list',
                init: controller,
                builder: (_) {
                  return Expanded(
                      child: CustomEasyRefresh(
                    emptyWidget: state.items == null
                        ? LottieIndicator()
                        : state.items!.isEmpty
                            ? EmptyLayout(hintText: '什么都没有'.tr)
                            : null,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        UserBaseDTO user = state.items![index];
                        return InkWell(
                          onTap: () => controller.employeeDetail(user),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 48.w, vertical: 40.w),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.username ?? '',
                                      style: TextStyle(
                                        color: Colours.text_333,
                                        fontSize: 32.sp,
                                        fontWeight: FontWeight.w500,
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
                          ),
                        );
                      },
                      //separatorBuilder是分隔符组件，可以直接拿来用
                      separatorBuilder: (context, index) => Container(
                        height: 2.w,
                        color: Colours.divider,
                        width: double.infinity,
                      ),
                      itemCount: state.items?.length ?? 0,
                    ),
                  ));
                }),
          ],
        ),
    );
  }
}
