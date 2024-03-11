import 'package:get/get.dart';
import 'package:ledger/widget/dialog_widget/stock_change/multi/stock_change_multi_dialog_controller.dart';

class StockChangeMultiDialogBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<StockChangeMultiDialogController>(() => StockChangeMultiDialogController(),
        permanent: false);
  }
}