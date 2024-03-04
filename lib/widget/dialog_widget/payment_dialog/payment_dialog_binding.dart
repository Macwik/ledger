import 'package:get/get.dart';
import 'package:ledger/widget/dialog_widget/payment_dialog/payment_dialog_controller.dart';

class PaymentDialogBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<PaymentDialogController>(() => PaymentDialogController(),
        permanent: false);
  }
}
