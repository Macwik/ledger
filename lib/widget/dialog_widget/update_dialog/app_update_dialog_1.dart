import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/app/app_check_dto.dart';
import 'package:ota_update/ota_update.dart';

import 'app_update_controller.dart';

class AppUpdateDialog extends StatelessWidget {
  final AppCheckDTO appCheckDTO;
  final bool force;
  final ScrollController controller =
      ScrollController(initialScrollOffset: 0.5);
  final AppUpdateController appUpdateController =
      Get.put<AppUpdateController>(AppUpdateController());

  static const double dialogWidth = 280.0;
  static const double dialogRadius = 8.0;

  AppUpdateDialog({required this.appCheckDTO, required this.force});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return WillPopScope(
      onWillPop: () async {
        // 使用false禁止返回键返回，达到强制升级目的
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.circular(dialogRadius),
            ),
            width: dialogWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 120.0,
                  width: dialogWidth,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(dialogRadius), topRight: Radius.circular(dialogRadius)),
                    image: DecorationImage(image: AssetImage('assets/images/update_head.jpg'), fit: BoxFit.cover),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                  child: Text('发现新版本', style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
                Container(
                  width: dialogWidth,
                  constraints: const BoxConstraints(minHeight: 50, maxHeight: 100),
                  child: Scrollbar(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: appCheckDTO.updateContent?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                          child: Text(appCheckDTO.updateContent![index]),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0, top: 5.0),
                  child: appUpdateController.started
                      ? LinearProgressIndicator(
                    backgroundColor: const Color(0xFFEEEEEE),
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    value: appUpdateController.percentage + 1 / 100,
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                        onPressed: () => Get.back(),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                          // 设置按钮大小
                          fixedSize: MaterialStateProperty.all(const Size(110.0, 36.0)),
                          minimumSize: MaterialStateProperty.all(const Size(110.0, 36.0)),
                          // 背景色
                          backgroundColor: MaterialStateProperty.resolveWith(
                                (states) {
                              if (states.contains(MaterialState.disabled)) {
                                // disabled状态颜色
                                return const Color(0xFFcccccc);
                              }
                              // 默认状态颜色
                              return Colors.transparent;
                            },
                          ),
                          // 文字颜色
                          foregroundColor: MaterialStateProperty.resolveWith(
                                (states) {
                              if (states.contains(MaterialState.disabled)) {
                                // disabled状态颜色
                                return Colors.white;
                              }
                              // 默认状态颜色
                              return primaryColor;
                            },
                          ),
                          // 边框
                          side: MaterialStateProperty.all(BorderSide(color: primaryColor, width: 0.8)),
                          // 圆角
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                          ),
                        ),
                        child: Text('稍后更新', style: const TextStyle(fontSize: 16.0)),
                      ),
                      TextButton(
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
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                          // 设置按钮大小
                          fixedSize: MaterialStateProperty.all(const Size(110.0, 36.0)),
                          minimumSize: MaterialStateProperty.all(const Size(110.0, 36.0)),
                          // 背景色
                          backgroundColor: MaterialStateProperty.resolveWith(
                                (states) {
                              if (states.contains(MaterialState.disabled)) {
                                // disabled状态颜色
                                return const Color(0xFFcccccc);
                              }
                              // 默认状态颜色
                              return primaryColor;
                            },
                          ),
                          // 文字颜色
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                          // 边框
                          side: MaterialStateProperty.all(BorderSide(color: primaryColor, width: 0.8)),
                          // 圆角
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                          ),
                        ),
                        child: Text('立即更新', style: const TextStyle(fontSize: 16.0)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
