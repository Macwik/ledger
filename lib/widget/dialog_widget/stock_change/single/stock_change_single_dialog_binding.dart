import 'package:get/get.dart';
import 'package:ledger/widget/dialog_widget/stock_change/single/stock_change_single_dialog_controller.dart';

class StockChangeSingleDialogBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<StockChangeSingleDialogController>(() => StockChangeSingleDialogController(),
        permanent: false);
  }
}