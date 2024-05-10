import 'package:get/get.dart';

import 'first_index_state.dart';

class FirstIndexController extends GetxController {
  final FirstIndexState state = FirstIndexState();


  void onFormChange() {
    state.formKey.currentState?.saveAndValidate(focusOnInvalid: false);
    update(['first_index_btn']);
  }
}
