import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/auth/role_dto.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/widget/custom_easy_refresh.dart';
import 'package:ledger/widget/empty_layout.dart';
import 'package:ledger/widget/lottie_indicator.dart';
import 'invite_employee_controller.dart';

class InviteEmployeeView extends StatelessWidget {
  final controller = Get.find<InviteEmployeeController>();
  final state = Get.find<InviteEmployeeController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '邀请员工',
          style: TextStyle(color: Colors.white),
        ),
        leading: BackButton(
          color: Colors.white,
        ),
      ),
      body: GetBuilder<InviteEmployeeController>(
          init: controller,
          builder: (_) {
            return CustomEasyRefresh(
              emptyWidget: state.roleList == null
                  ? LottieIndicator()
                  : state.roleList!.isEmpty
                      ? EmptyLayout(hintText: '什么都没有哦'.tr)
                      : null,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  RoleDTO entity = state.roleList![index];
                  return InkWell(
                    onTap: () => controller.inviteEmployee(index),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 32.w, horizontal: 40.w),
                      child:Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '邀请 ${entity.roleName}',
                            style: TextStyle(
                              color: Colours.text_333,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            entity.roleDesc ?? '',
                            style: TextStyle(
                              color: Colours.text_666,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ],
                      )
                    ),
                  );
                },
                //separatorBuilder是分隔符组件，可以直接拿来用
                separatorBuilder: (context, index) => Container(
                  height: 2.w,
                  color: Colours.divider,
                  width: double.infinity,
                ),
                itemCount: state.roleList?.length ?? 0,
              ),
            );
          }),
    );
  }
}
