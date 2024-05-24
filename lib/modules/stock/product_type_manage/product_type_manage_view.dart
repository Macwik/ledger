import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/res/export.dart';
import 'package:uuid/uuid.dart';

import 'product_type_manage_controller.dart';

class ProductTypeManageView extends StatelessWidget {
  ProductTypeManageView({super.key});

  final controller = Get.find<ProductTypeManageController>();

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
        appBar: TitleBar(
          title: '货物列表分组管理',
        ),
        body: Column(
          children: [
            GetBuilder<ProductTypeManageController>(
                id: 'product_classify_item',
                init: controller,
                global: false,
                builder: (_) {
                  return Expanded(
                      child: controller.state.productClassifyList == null
                          ? LottieIndicator()
                          : controller.state.productClassifyList?.isEmpty ??
                                  true
                              ? EmptyLayout(hintText: '什么都没有'.tr)
                              : AnimatedReorderableListView(
                                  items: controller.state.productClassifyList!,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var productClassify = controller
                                        .state.productClassifyList![index];
                                    return InkWell(
                                      key: Key(
                                          '${Uuid().v1()}${productClassify.id}${productClassify.ordinal}'),
                                      onTap: () =>
                                          controller.selectProductClassify(
                                              productClassify),
                                      child: Container(
                                        color: Colors.white,
                                        child: ListTile(
                                            title: Text(
                                                productClassify
                                                        .productClassify ??
                                                    '',
                                                style: TextStyle(
                                                    fontSize: 36.sp,
                                                    color: Colours.text_333)),
                                            subtitle: Text(
                                              productClassify.remark ?? '',
                                              style: TextStyle(
                                                color: Colours.text_ccc,
                                                fontSize: 28.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            trailing: IconButton(
                                                onPressed: () =>
                                                    controller.showBottomSheet(
                                                        context,
                                                        productClassify),
                                                icon: Icon(
                                                  Icons.more_horiz_outlined,
                                                  color: Colours.text_999,
                                                ))),
                                      ),
                                    );
                                  },
                                  enterTransition: [FadeIn(), ScaleIn()],
                                  exitTransition: [SlideInUp()],
                                  insertDuration:
                                      const Duration(milliseconds: 300),
                                  removeDuration:
                                      const Duration(milliseconds: 300),
                                  onReorder: (int oldIndex, int newIndex) {
                                    if (oldIndex == 0 || newIndex == 0) {
                                      Toast.showError('默认分类不能移动，且只能在第一位');
                                      return;
                                    }
                                    controller.updateProductClassify(
                                        oldIndex, newIndex);
                                  },
                                ));
                }),
            Container(
              height: 90.w,
              width: double.infinity,
              margin: EdgeInsets.only(right: 20.w, left: 20.w, top: 10.w),
              child: ElevatedButton(
                onPressed: () {
                  controller.addProductClassify(context);
                },
                child: Text('+ 新增货物分组',
                    style: TextStyle(
                      color: Colours.primary,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w500,
                    )),
                style: ButtonStyle(
                  fixedSize: WidgetStateProperty.all(Size(300, 50)), // 设置
                  backgroundColor: WidgetStateProperty.all(Colors.white),
                ),
              ),
            )
          ],
        ));
  }
}
