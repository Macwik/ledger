import 'package:get/get.dart';
import 'package:ledger/widget/dialog_widget/add_stock_dialog/single/add_stock_single_dialog_controller.dart';

class AddStockSingleDialogBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<AddStockSingleDialogController>(() => AddStockSingleDialogController(),
        permanent: false);
  }
}