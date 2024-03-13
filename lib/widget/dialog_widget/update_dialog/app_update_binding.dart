import 'package:get/get.dart';
import 'package:ledger/widget/dialog_widget/update_dialog/app_update_controller.dart';

class AppUpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<AppUpdateController>(() => AppUpdateController(),
        permanent: false);
  }
}