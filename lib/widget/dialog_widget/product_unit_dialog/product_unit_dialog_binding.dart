import 'package:get/get.dart';
import 'package:ledger/widget/dialog_widget/product_unit_dialog/product_unit_dialog_controller.dart';

class ProductUnitDialogBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<ProductUnitDialogController>(() => ProductUnitDialogController(),
        permanent: false);
  }
}
