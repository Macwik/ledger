import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/store/store_controller.dart';
import 'package:ledger/util/image_util.dart';
import 'package:ledger/widget/permission/permission_owner_widget.dart';

import 'mine_controller.dart';

class MineView extends StatelessWidget {
  MineView({super.key});

  final controller = Get.find<MineController>();
  final state = Get.find<MineController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      appBar: TitleBar(
        title: '我的',
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            InkWell(
              onTap: () => controller.toMineDetail(),
              child: Container(
                height: 100,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.w),
                child: ListView(
                  children: [
                    ListTile(
                      leading: LoadAssetImage(
                        'logo',
                        format: ImageFormat.jpg,
                        width: 90.w,
                      ),
                      title: GetBuilder<MineController>(
                        id: 'user_detail_name',
                        builder: (logic) =>
                            Text(StoreController.to.getUser()?.username ?? '',
                                style: TextStyle(
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.w500,
                                )),
                      ),
                      subtitle: Text(
                          TextUtil.hideNumber(
                              StoreController.to.getUser()!.phone!),
                          style: TextStyle(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w300,
                          )),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colours.text_ccc,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(40.w, 10, 0.0, 10.0.w),
              child: Text(
                '账目',
                style: TextStyle(
                  fontSize: 26.sp,
                  color: Colours.text_999,
                ),
              ),
            ),
            InkWell(
              onTap: () => controller.toMyAccount(),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 32.w),
                child: Row(
                  children: [
                    LoadSvg(
                      'svg/ic_mine_accounts',
                      width: 40.w,
                    ),
                    SizedBox(width: 20.w),
                    Text(
                      '我的账本',
                      style: TextStyle(
                        color: Colours.text_666,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    GetBuilder<MineController>(
                        id: 'mine_active_ledger_name',
                        builder: (_) {
                      return Text(
                        StoreController.to
                                .getUser()
                                ?.activeLedger
                                ?.ledgerName ??
                            '',
                        style: TextStyle(
                          color: Colours.primary,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }),
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
              onTap: () => Get.toNamed(RouteConfig.employeeManage),
              child: PermissionOwnerWidget(
                  child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 32.w),
                child: Row(
                  children: [
                    LoadSvg(
                      'svg/ic_mine_manager',
                      width: 40.w,
                    ),
                    SizedBox(width: 20.w),
                    Text(
                      '营业员管理',
                      style: TextStyle(
                        color: Colours.text_666,
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
              )),
            ),
            Container(
              color: Colours.divider,
              height: 1.w,
              width: double.infinity,
            ),
            Visibility(
                maintainSize: false,
                visible: false,
                child: InkWell(
                  onTap: () => Get.toNamed(RouteConfig.dataExport),
                  child: Container(
                    color: Colors.white,
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.w, vertical: 32.w),
                    child: Row(
                      children: [
                        LoadSvg(
                          'svg/ic_mine_export',
                          width: 40.w,
                        ),
                        SizedBox(width: 20.w),
                        Text(
                          '数据导出',
                          style: TextStyle(
                            color: Colours.text_666,
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
                )),
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(40.w, 10, 0.0, 10.0.w),
              child: Text(
                '其他',
                style: TextStyle(fontSize: 26.sp, color: Colours.text_999),
              ),
            ),
            InkWell(
              onTap: () => Get.toNamed(RouteConfig.accountSetting),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 32.w),
                child: Row(
                  children: [
                    LoadSvg(
                      'svg/ic_mine_setting',
                      width: 40.w,
                    ),
                    SizedBox(width: 20.w),
                    Text(
                      '记账设置',
                      style: TextStyle(
                        color: Colours.text_666,
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
              onTap: () => controller.checkUpdate(context),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 32.w),
                child: Row(
                  children: [
                    LoadSvg(
                      'svg/ic_mine_checkUpDate',
                      width: 40.w,
                    ),
                    SizedBox(width: 20.w),
                    Text(
                      '检查更新',
                      style: TextStyle(
                        color: Colours.text_666,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    GetBuilder<MineController>(
                        id: 'mine_app_version',
                        builder: (_) {
                          return Text(
                            state.version ?? '',
                            style: TextStyle(
                              color: Colours.text_666,
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        }),
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
            Container(
              color: Colours.divider,
              height: 1.w,
              width: double.infinity,
            ),
            InkWell(
              onTap: () => Get.toNamed(RouteConfig.aboutUs),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 32.w),
                child: Row(
                  children: [
                    LoadSvg(
                      'svg/ic_mine_aboutUs',
                      width: 40.w,
                    ),
                    SizedBox(width: 20.w),
                    Text(
                      '关于我们',
                      style: TextStyle(
                        color: Colours.text_666,
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
            Visibility(
                maintainSize: false,
                visible: false,
                child: InkWell(
                  child: Container(
                    color: Colors.white,
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.w, vertical: 32.w),
                    child: Row(
                      children: [
                        LoadSvg(
                          'svg/ic_mine_help',
                          width: 40.w,
                        ),
                        SizedBox(width: 20.w),
                        Text(
                          '帮助',
                          style: TextStyle(
                            color: Colours.text_666,
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
                )),
          ],
        ),
      ),
    );
  }
}
