import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class CustomDialog {
  final formKey = GlobalKey<FormBuilderState>();

  void newDefaultDialog({
    String title = '标题',
    String? okLabel,
    String? cancelLabel,
    required Widget content,
    VoidCallback? onCancelPressed,
    Future<bool> Function(GlobalKey<FormBuilderState> state)? onOkPressed,
  }) {
    Get.defaultDialog(
      title: title,
      content: FormBuilder(
        key: formKey,
        child: content,
      ),
      actions: [
        ElevatedButton(
          onPressed: onCancelPressed ?? () => Get.back(),
          child: Text(cancelLabel ?? '取消'),
        ),
        ElevatedButton(
          onPressed: () {
            onOkPressed
                ?.call(formKey)
                .then((value) => value ? Get.back() : null);
          },
          child: Text(okLabel ?? '确定'),
        ),
      ],
    );
  }
}
