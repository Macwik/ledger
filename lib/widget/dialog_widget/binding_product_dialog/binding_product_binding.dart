import 'package:get/get.dart';
import 'package:ledger/widget/dialog_widget/binding_product_dialog/binding_product_controller.dart';

class BindingProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<BindingProductController>(() => BindingProductController(),
        permanent: false);
  }
}
