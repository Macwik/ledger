import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/widget/empty_layout.dart';
import 'package:ledger/widget/lottie_indicator.dart';

import 'product_type_manage_controller.dart';

class ProductTypeManageView extends StatelessWidget {
  ProductTypeManageView({super.key});

  final controller = Get.find<ProductTypeManageController>();
  final state = Get.find<ProductTypeManageController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '货物列表分组管理',
            style: TextStyle(color: Colors.white),
          ),
          leading: BackButton(
            color: Colors.white,
          ),
        ),
        body: Column(
          children: [
            GetBuilder<ProductTypeManageController>(
                id: 'product_classify_item',
                init: controller,
                builder: (_) {
                  return Expanded(
                      child: state.productClassifyList == null
                          ? LottieIndicator()
                          : state.productClassifyList?.isEmpty ?? true
                              ? EmptyLayout(hintText: '什么都没有'.tr)
                              : ListView.separated(
                                  itemBuilder: (context, index) {
                                    var productClassify =
                                        state.productClassifyList![index];
                                    return InkWell(
                                      onTap: () =>
                                          controller.selectProductClassify(
                                              productClassify),
                                      child: Container(
                                        color: Colors.white,
                                        child: ListTile(
                                            title: Text(
                                                productClassify.productClassify ?? '',
                                                style: TextStyle(
                                                    fontSize: 32.sp,
                                                    color: Colours.text_333)),
                                            subtitle: Text(
                                              productClassify.remark ?? '',
                                              style: TextStyle(
                                                color: Colours.text_ccc,
                                                fontSize: 24.sp,
                                                fontWeight: FontWeight.w500,
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
                                  separatorBuilder: (context, index) =>
                                      Container(
                                    height: 2.w,
                                    color: Colours.divider,
                                    width: double.infinity,
                                  ),
                                  itemCount:
                                      state.productClassifyList?.length ?? 0,
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
                  fixedSize: MaterialStateProperty.all(Size(300, 50)), // 设置
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
            )
          ],
        ));
  }
}
