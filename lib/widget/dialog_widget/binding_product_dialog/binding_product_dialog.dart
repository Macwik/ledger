import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/order/order_product_detail_dto.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/widget/dialog_widget/binding_product_dialog/binding_product_controller.dart';

import 'binding_product_binding.dart';

class BindingProductDialog extends StatelessWidget {
  late final BindingProductController controller;
  final List<OrderProductDetail> orderProductDetailList;
  final Set<OrderProductDetail> result = {};
  final Function(Set<OrderProductDetail> result) onClick;

  BindingProductDialog(
      {required this.orderProductDetailList, required this.onClick}) {
    BindingProductBinding().dependencies();
    controller = Get.find<BindingProductController>();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        expand: false,
        builder: (context, ScrollController scrollController) {
          return Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  Text(
                    '请选择费用对应货物',
                    style: TextStyle(
                      fontSize: 30.sp,
                      color: Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.close_sharp,
                      ))
                ],
              ),
              Expanded(
                  child: ListView.separated(
                itemBuilder: (context, index) {
                  OrderProductDetail item = orderProductDetailList[index];
                  return InkWell(
                      onTap: () {
                        result.contains(item)
                            ? result.remove(item)
                            : result.add(item);
                        controller.update(['binding_product_checkbox']);
                      },
                      child: Row(children: [
                        GetBuilder<BindingProductController>(
                            id: 'binding_product_checkbox',
                            init: controller,
                            global: false,
                            builder: (_) {
                              return Checkbox(
                                  value: result.contains(item),
                                  onChanged: (value) {
                                    result.contains(item)
                                        ? result.remove(item)
                                        : result.add(item);
                                    controller
                                        .update(['binding_product_checkbox']);
                                  });
                            }),
                        Text(item.productName ?? '',
                        style: TextStyle(color:item.invalid == 0 ? Colours.text_333 : Colours.text_ccc ),),
                      Offstage(
                        offstage: item.invalid == 0 ? true : false,
                        child:   Container(
                            padding: EdgeInsets.only(
                                top: 2.w,
                                bottom: 2.w,
                                left: 4.w,
                                right: 4.w),
                            margin: EdgeInsets.only(left: 24.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colours.text_ccc,
                                width: 1.0,
                              ),
                              borderRadius:
                              BorderRadius.circular(8.0),
                            ),
                            child: Text( '已停用',
                              style: TextStyle(color: Colours.text_ccc)))
                      ),
                      ]));
                },
                separatorBuilder: (context, index) => Container(
                  height: 2.w,
                  color: Colours.divider,
                  width: double.infinity,
                ),
                itemCount: orderProductDetailList.length,
              )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 100.w,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (result.isEmpty) {
                        Toast.show('请选择商品');
                        return;
                      }
                      if (onClick(result)) {
                        Get.back();
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.teal[300]),
                    ),
                    child: Text(
                      '选 好 了',
                      style: TextStyle(
                        fontSize: 30.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
}
