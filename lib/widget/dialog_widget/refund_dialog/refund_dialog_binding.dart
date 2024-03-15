import 'package:get/get.dart';
import 'package:ledger/widget/dialog_widget/refund_dialog/refund_dialog_controller.dart';

class RefundDialogBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<RefundDialogController>(() => RefundDialogController(),
        permanent: false);
  }
}