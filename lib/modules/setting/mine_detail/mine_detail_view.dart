import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/image_util.dart';
import 'package:ledger/widget/will_pop.dart';

import 'mine_detail_controller.dart';

class MineDetailView extends StatelessWidget {
  MineDetailView({super.key});

  final controller = Get.find<MineDetailController>();
  final state = Get.find<MineDetailController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
        appBar: TitleBar(
          title:
            '个人信息',
        ),
        body: MyWillPop(
          onWillPop: () async {
            Get.back(result: state.changeStatus);
            return Future(() => true);
          },
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                    child: ListView(
                  children: [
                    Container(
                      height: 20.w,
                      width: double.infinity,
                    ),
                    InkWell(
                      child: Container(
                        color: Colors.white,
                        height: 100.w,
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        child: Row(
                          children: [
                            SizedBox(width: 20.w),
                            Text(
                              '头像',
                              style: TextStyle(
                                color: Colours.text_666,
                            fontSize: 30.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            LoadAssetImage(
                              'logo',
                              format: ImageFormat.jpg,
                              width: 80.w,
                              height: 80.w,
                            )
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
                      onTap: controller.editNickName,
                      child: Container(
                        color: Colors.white,
                        height: 100.w,
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        child: Row(
                          children: [
                            SizedBox(width: 20.w),
                            Text(
                              '昵称',
                              style: TextStyle(
                                color: Colours.text_666,
                            fontSize: 30.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            GetBuilder<MineDetailController>(
                                id: 'user_detail_name',
                                builder: (logic) => Text(
                                      state.user?.username ?? '',
                                      style: TextStyle(
                                        color: Colours.text_333,
                                    fontSize: 30.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )),
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
                      onTap: () => Get.toNamed(RouteConfig.forgetPassword,
                          arguments: {'type': 1}),
                      child: Container(
                        color: Colors.white,
                        height: 100.w,
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        child: Row(
                          children: [
                            SizedBox(width: 20.w),
                            Text(
                              '设置/修改密码',
                              style: TextStyle(
                                color: Colours.text_666,
                            fontSize: 30.sp,
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
                      onTap: () => controller.changePhone(),
                      child: Container(
                        color: Colors.white,
                        height: 100.w,
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        child: Row(
                          children: [
                            SizedBox(width: 20.w),
                            Text(
                              '修改手机号',
                              style: TextStyle(
                                color: Colours.text_666,
                            fontSize: 30.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '点击联系客服修改',
                              style: TextStyle(
                                color: Colours.text_666,
                                fontSize: 26.sp,
                                fontWeight: FontWeight.w500,
                              ),
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
                    GetBuilder<MineDetailController>(builder: (logic) {
                      return ElevatedBtn(
                        margin: EdgeInsets.only(top: 80.w),
                        size: Size(double.infinity, 90.w),
                        radius: 15.w,
                        backgroundColor: Colors.white,
                        text: '退出登录',
                        onPressed: controller.logout,
                        style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }),
                  ],
                )),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: GetBuilder<MineDetailController>(
                      builder: (logic) {
                        return ElevatedBtn(
                          onPressed: ()=> Get.toNamed(RouteConfig.logoutApp),
                          margin: EdgeInsets.only(top: 80.w),
                          size: Size(double.infinity, 90.w),
                          radius: 15.w,
                          backgroundColor: Colors.white,
                          text: '注销账号',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    )),
              ],
            ),
          ),
        ));
  }
}
