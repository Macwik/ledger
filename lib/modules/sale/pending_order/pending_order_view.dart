import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/draft/order_draft_dto.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/decimal_util.dart';

import 'pending_order_controller.dart';

class PendingOrderView extends StatelessWidget {
  PendingOrderView({super.key});

  final controller = Get.find<PendingOrderController>();
  final state = Get.find<PendingOrderController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return  Scaffold(
      appBar: TitleBar(
        title: '挂单情况',
      ),
      body:  Column(
        children: [
          Container(
            height: 120.w,
            color: Colors.white60,
            padding: EdgeInsets.all(10.w),
            child: SearchBar(
              onChanged: (value) {
                controller.searchPendingOrder(value);
              },
              leading: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              hintText: '请输入客户、货物名称',
            ),
          ),
          Expanded(child:
              GetBuilder<PendingOrderController>(
                  id: 'pending_order',
                  global: false,
                  init: controller,
                  builder: (_) {
                    return CustomEasyRefresh(
                        controller: controller.state.refreshController,
                        onLoad: controller.onLoad,
                        onRefresh: controller.onRefresh,
                        emptyWidget: controller.state.list == null
                            ? LottieIndicator()
                            : controller.state.list?.isEmpty ?? true
                            ? EmptyLayout(hintText: '什么都没有'.tr)
                            : null,
                        child:ListView.separated(
                        itemBuilder: (context, index) {
                          OrderDraftDTO orderDraftDTO = controller.state.list![index];
                          return InkWell(
                            onTap: () => Get.toNamed(RouteConfig.pendingRetailBill,arguments: {'draftId':orderDraftDTO.id})
                            ?.then((value) => controller.onRefresh()),
                            child: Slidable(
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  extentRatio: 0.25,
                                  children: [
                                    SlidableAction(
                                      label: '删除',
                                      backgroundColor: Colors.red,
                                      icon: Icons.delete_outline_rounded,
                                      onPressed: (context) {
                                        controller.toDeleteOrder(orderDraftDTO.id);
                                      },
                                    ),
                                  ],
                                ),
                                child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40.w, vertical: 20.w),
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Container(
                                            child: Row(
                                              children: [
                                                Text(orderDraftDTO.customName??'默认客户',
                                                    style: TextStyle(
                                                      color: Colours.text_333,
                                                      fontSize: 32.sp,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    )),
                                                const Spacer(),
                                                Text('继续开单',
                                                    style: TextStyle(
                                                      color: Colors.orange,
                                                      fontSize: 28.sp,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    )),
                                              ],
                                            )),
                                        Container(
                                            margin: EdgeInsets.symmetric(vertical: 16.w),
                                            alignment:
                                            Alignment.centerLeft,
                                            child:
                                            Text(TextUtil.listToStr(orderDraftDTO.productNameList),
                                                    style: TextStyle(
                                                      color: Colours.text_999,
                                                      fontSize: 28.sp,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    )),),
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              children: [
                                                Text(DateUtil.formatDefaultDate2(orderDraftDTO.gmtCreate),
                                                    style: TextStyle(
                                                      color: Colours.text_ccc,
                                                      fontSize: 28.sp,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    )),
                                                const Spacer(),
                                                Text(DecimalUtil.formatAmount(orderDraftDTO.totalAmount),
                                                    style: TextStyle(
                                                      color: Colours.primary,
                                                      fontSize: 32.sp,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    )),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          );
                        },
                        separatorBuilder: (context, index) => Container(
                          height: 2.w,
                          color: Colours.divider,
                          width: double.infinity,
                        ),
                        itemCount: state.list?.length??0,
                      ),
                    );
                  })),
            ],
          ),
    );
  }
}
