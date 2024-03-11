import 'package:get/get.dart';
import 'package:ledger/widget/dialog_widget/add_stock_dialog/add_stock_dialog_controller.dart';

class AddStockDialogBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<AddStockDialogController>(() => AddStockDialogController(),
        permanent: false);
  }
}
