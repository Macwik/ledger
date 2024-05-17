import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/util/date_util.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/widget/custom_easy_refresh.dart';
import 'package:ledger/widget/empty_layout.dart';
import 'package:ledger/widget/lottie_indicator.dart';
import 'package:ledger/widget/title_bar.dart';

import 'product_cost_detail_controller.dart';

class ProductCostDetailView extends StatelessWidget {
  ProductCostDetailView({super.key});

  final controller = Get.find<ProductCostDetailController>();
  final state = Get.find<ProductCostDetailController>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(
        title: '费用收入明细'.tr,
      ),
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Column(
          children: [
            Container(
                color: Colors.white,
                height: 90.w, // 调整TabBar高度
                child: TabBar(
                  controller: controller.tabController,
                  tabs: [
                    Tab(
                      text: '费用',
                    ),
                    Tab(
                      text: '收入',
                    ),
                  ],
                  indicatorWeight: 3.w,
                  indicatorPadding: EdgeInsets.all(0),
                  labelPadding: EdgeInsets.all(0),
                  isScrollable: false,
                  indicatorColor: Colours.primary,
                  dividerColor: Colours.bg,
                  unselectedLabelColor: Colours.text_999,
                  unselectedLabelStyle:
                      const TextStyle(fontWeight: FontWeight.w500),
                  labelStyle: TextStyle(fontWeight: FontWeight.w500),
                  labelColor: Colours.primary,
                )),
            //  }),
            Expanded(
                child:
                    TabBarView(controller: controller.tabController, children: [
              widgetSaleRecord(),
              widgetSaleRecord(),
            ]))
          ],
        ),
      ),
    );
  }

  widgetSaleRecord() {
    return GetBuilder<ProductCostDetailController>(
        id: 'product_cost_detail',
        builder: (_) {
          return CustomEasyRefresh(
            controller: state.refreshController,
            onLoad: controller.onLoad,
            onRefresh: controller.onRefresh,
            emptyWidget: state.list == null
                ? LottieIndicator()
                : state.list?.isEmpty ?? true
                    ? EmptyLayout(hintText: '什么都没有'.tr)
                    : null,
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: state.list?.length ?? 0,
              itemBuilder: (context, index) {
                var externalOrderStatisticDTO = state.list![index];
                return Card(
                    elevation: 6,
                    shadowColor: Colors.black45,
                    margin: EdgeInsets.only(left: 24.w, top: 16.w, right: 24.w),
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(28.w)),
                    ),
                    child: Column(
                      children: [
                        Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: 16.w, horizontal: 40.w),
                            color: Colors.white12,
                            child: Row(
                              children: [
                                Text(
                                  '批次号：',
                                  style: TextStyle(
                                    color: Colours.text_ccc,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  externalOrderStatisticDTO.batchNo ?? '',
                                  style: TextStyle(
                                    color: Colours.text_999,
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '合计：',
                                  style: TextStyle(
                                    color: Colours.text_ccc,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  DecimalUtil.formatAmount(
                                      externalOrderStatisticDTO
                                          .externalOrderList
                                          ?.map((e) =>
                                              e.totalAmount ?? Decimal.zero)
                                          .reduce((value, element) =>
                                              value + element)),
                                  style: TextStyle(
                                    color: Colours.primary,
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            )),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(
                              left: 40.w, right: 40.w, top: 20.w, bottom: 20.w),
                          child: ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: externalOrderStatisticDTO
                                .externalOrderList!
                                .map((item) {
                              return InkWell(
                                  onTap: () => Get.toNamed(
                                          RouteConfig.costDetail,
                                          arguments: {
                                            'id': item.id,
                                            'orderType': state.index
                                          }),
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            DateUtil.formatDefaultDate2(
                                                item.externalDate),
                                            style: TextStyle(
                                              color: Colours.text_999,
                                              fontSize: 26.sp,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ),
                                      SizedBox(
                                        height: 16.w,
                                      ),
                                      Flex(
                                        direction: Axis.horizontal,
                                        children: [
                                          Expanded(
                                            child: Text(
                                                item.costIncomeName ?? '',
                                                style: TextStyle(
                                                  color: Colours.text_333,
                                                  fontSize: 32.sp,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                          ),
                                          Expanded(
                                            child: Text(
                                                DecimalUtil.formatAmount(
                                                    item.totalAmount),
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  color: Colours.text_666,
                                                  fontSize: 32.sp,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 1.w,
                                        width: double.infinity,
                                        color: Colours.divider,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 16.w),
                                      )
                                    ],
                                  ));
                            }).toList(),
                          ),
                        )
                      ],
                    ));
              },
            ),
          );
        });
  }
}
