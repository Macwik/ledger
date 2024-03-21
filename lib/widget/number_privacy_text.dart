import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NumberPrivacyText extends StatelessWidget {
  final String number;
  final RxBool hideSensitiveText = RxBool(true);
  final TextAlign? textAlign;
  final TextStyle? style;

  NumberPrivacyText(
      {super.key, required this.number, this.textAlign, this.style});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 显示/隐藏文本的小眼睛图标
        InkWell(
          onTap: () {
            hideSensitiveText.value = !hideSensitiveText.value;
          },
          child: Obx(() => Icon(
                hideSensitiveText.value
                    ? Icons.visibility_off
                    : Icons.visibility,
              )),
        ),
        // 敏感信息文本
        Obx(
          () => Text(
            hideSensitiveText.value ? '*******' : number,
            style: style,
            textAlign: textAlign,
          ),
        )
      ],
    );
  }
}
