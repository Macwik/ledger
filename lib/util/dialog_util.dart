import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:get/get.dart';

class DialogUtil {
  /// 最简单的Alert，只有一个OK按钮
  static void alert({
    String? title = 'title',
    String? message = 'message',
    String? okLabel = '确定',
  }) {
    showOkAlertDialog(
      context: Get.context!,
      title: title,
      message: message,
      okLabel: okLabel,
      barrierDismissible: false,
    );
  }

  /// Alert，有OK和cancel两个按钮
  static Future<OkCancelResult> alertWithCancel({
    String? title = 'title',
    String? message = 'message',
    String? okLabel = '确定',
    String? cancelLabel = '取消',
  }) {
    return showOkCancelAlertDialog(
      context: Get.context!,
      title: title,
      message: message,
      okLabel: okLabel,
      cancelLabel: cancelLabel,
      barrierDismissible: false,
    );
  }
}
