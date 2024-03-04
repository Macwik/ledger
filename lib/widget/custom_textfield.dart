import 'package:ledger/res/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomTextField extends StatelessWidget {
  final String? initialValue;

  const CustomTextField(
      {super.key,
      required this.name,
      this.hintText,
      this.validator,
      this.maxLength = 20,
      this.obscureText = false, //用于隐藏敏感信息
      this.readOnly = false,
      this.keyboardType = TextInputType.text,
      this.initialValue, //表单中提供默认值，初始值
      this.fontSize,
      this.textColor,
      this.hintColor,
      this.controller,
      this.border = InputBorder.none,
      this.onChanged,
        this.focusNode,
      this.maxLines = 1,
      this.minLines = 1,
      this.autovalidateMode,
      this.onEditingComplete,
      this.prefixIcon, //输入框前添加一个图标
      this.textAlign = TextAlign.left});

  final String name;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final int maxLength;
  final int maxLines;
  final int minLines;
  final bool obscureText;
  final bool readOnly;
  final TextInputType keyboardType;
  final double? fontSize;
  final Color? textColor;
  final Color? hintColor;
  final Widget? prefixIcon;
  final TextAlign textAlign;
  final FocusNode? focusNode;
  final InputBorder border;
  final ValueChanged<String?>? onChanged;
  final VoidCallback? onEditingComplete;
  final AutovalidateMode? autovalidateMode;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      initialValue: initialValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      name: name,
      textAlign: textAlign,
      style: TextStyle(
        color: textColor ?? Colors.black,
        fontSize: fontSize ?? 28.sp,
      ),
      obscureText: obscureText,
      readOnly: readOnly,
      maxLines: maxLines,
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: Colours.primary,
      onChanged: onChanged,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        counterText: '',
        hintText: hintText,
        hintStyle: TextStyle(
            color: hintColor ?? Colours.text_ccc, fontSize: fontSize ?? 28.sp),
        // errorBorder: UnderlineInputBorder(
        //   borderSide: BorderSide(
        //     width: 2.w,
        //     color: Colors.red,
        //   ),
        // ),
        // focusedBorder: UnderlineInputBorder(
        //   borderSide: BorderSide(
        //     width: 2.w,
        //     color: Colours.primary,
        //   ),
        // ),
        // enabledBorder: UnderlineInputBorder(
        //   borderSide: BorderSide(
        //     width: 2.w,
        //     color: Colours.divider,
        //   ),
        // ),
        // focusedErrorBorder: UnderlineInputBorder(
        //   borderSide: BorderSide(
        //     width: 2.w,
        //     color: Colors.red,
        //   ),
        // ),
        border: border,
      ),
      maxLength: maxLength,
      validator: validator,
    );
  }
}
