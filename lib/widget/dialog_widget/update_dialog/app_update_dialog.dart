import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/app/app_check_dto.dart';
import 'package:ledger/res/colors.dart';
import 'package:ota_update/ota_update.dart';

import 'app_update_controller.dart';

class AppUpdateDialog extends StatelessWidget {
  final AppCheckDTO appCheckDTO;
  final bool force;
  final ScrollController controller =
      ScrollController(initialScrollOffset: 0.5);
  final AppUpdateController appUpdateController =
      Get.put<AppUpdateController>(AppUpdateController());

  AppUpdateDialog({required this.appCheckDTO, required this.force});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      backgroundColor: Colours.bg,
      title: Container(
        padding: EdgeInsets.only(bottom: 32.w),
        alignment: Alignment.center,
        child: Text('升级版本'),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 56.w),
            alignment: Alignment.topCenter,
            width: double.infinity,
            child: Scrollbar(
              controller: controller,
              child: SingleChildScrollView(
                controller: controller,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // 设置为居左对齐
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // 设置子组件的横向对齐方式为居左对齐
                  children: appCheckDTO.updateContent
                          ?.map((e) => Text(e, textAlign: TextAlign.left))
                          .toList() ??
                      [],
                  //padding: EdgeInsets.all(10),
                ),
              ),
            ),
          ),
          GetBuilder<AppUpdateController>(
              id: 'app_update_processor',
              builder: (_) {
                return Visibility(
                  visible: appUpdateController.started,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: Text(
                          '下载中',
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                      LinearProgressIndicator(
                        value: appUpdateController.percentage + 1 / 100,
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
      actionsAlignment: MainAxisAlignment.start,
      actions: <Widget>[
        Row(
          children: [
            Visibility(
              visible: !force,
              child: Expanded(
                  child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colours.primary),
                child: Text(
                  '取消',
                  style:
                      TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w500),
                ),
                onPressed: () {
                  appUpdateController.started = false;
                  Get.back();
                },
              )),
            ),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colours.primary,
                    foregroundColor: Colors.white),
                child: Text(
                  '升级',
                  style:
                      TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w500),
                ),
                onPressed: () {
                  if (appUpdateController.started) {
                    return;
                  }
                  try {
                    OtaUpdate()
                        .execute(appCheckDTO.latestUrl!,
                            destinationFilename: 'ledger.apk')
                        .listen(
                      (OtaEvent event) {
                        if (event.status == OtaStatus.DOWNLOADING) {
                          appUpdateController.percentage =
                              (int.tryParse(event.value ?? '0') ??
                                      appUpdateController.percentage) /
                                  100;
                          appUpdateController.update(['app_update_processor']);
                        } else if (event.status == OtaStatus.INSTALLING) {
                          appUpdateController.started = false;
                          Get.back();
                        }
                      },
                    );
                    appUpdateController.started = true;
                    appUpdateController.update(['app_update_processor']);
                  } catch (e) {
                    appUpdateController.update(['app_update_processor']);
                  }
                },
              ),
            )
          ],
        )
      ],
    );
  }
}
