import 'package:get/get.dart';
import 'sale_bill_controller.dart';

class SaleBillBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<SaleBillController>(() => SaleBillController(),
        permanent: false);
  }
}
