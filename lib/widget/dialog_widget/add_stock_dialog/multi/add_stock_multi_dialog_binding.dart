import 'package:get/get.dart';
import 'package:ledger/widget/dialog_widget/add_stock_dialog/multi/add_stock_multi_dialog_controller.dart';

class AddStockMultiDialogBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<AddStockMultiDialogController>(() => AddStockMultiDialogController(),
        permanent: false);
  }
}