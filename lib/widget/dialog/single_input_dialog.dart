import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class SingleInputDialog {
  final formKey = GlobalKey<FormBuilderState>();

  void singleInputDialog({
    String title = '标题',
    String? hintText,
    String? okLabel,
    String? cancelLabel,
    TextEditingController? controller,
    TextInputType? keyboardType,
    final FormFieldValidator<String>? validator,
    VoidCallback? onCancelPressed,
    Future<bool> Function(String text)? onOkPressed,
  }) {
    controller = controller ?? TextEditingController();
    Get.defaultDialog(
      title: title,
      content: FormBuilder(
        key: formKey,
        child: TextFormField(
          decoration: InputDecoration(
            hintText: hintText ?? '请输入',
            border: UnderlineInputBorder(),
          ),
          controller: controller,
          keyboardType: keyboardType ?? TextInputType.text,
          validator: validator,
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: onCancelPressed ?? () => Get.back(),
          child: Text(cancelLabel ?? '取消'),
        ),
        ElevatedButton(
          onPressed: () {
            if (!formKey.currentState!.saveAndValidate()) {
              return;
            }
            // 执行其他操作，并关闭对话框
            var value = controller!.text;
            onOkPressed?.call(value).then((value) => value ? Get.back() : null);
          },
          child: Text(okLabel ?? '确定'),
        ),
      ],
    );
  }
}
