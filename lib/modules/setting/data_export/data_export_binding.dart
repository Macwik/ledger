import 'package:get/get.dart';

import 'data_export_controller.dart';

class DataExportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DataExportController());
  }
}
