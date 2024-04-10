import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class StockChangeSingleDialogController extends GetxController {

  final TextEditingController stockChangeController = TextEditingController();


  Future<void> initState() async{
    WidgetsBinding.instance.addPostFrameCallback((_) {
      stockChangeController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: stockChangeController.value.text.length,
      );
    });
  }
}