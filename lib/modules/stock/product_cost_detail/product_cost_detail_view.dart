import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/widget/custom_easy_refresh.dart';
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
        length:  2,
        child: Column(
          children: [
            Container(
                color: Colors.white,
                height: 90.w, // 调整TabBar高度
                child: TabBar(
                  controller: controller.tabController,
                  tabs: [
                    Tab(text:'费用',),
                    Tab(text:'收入',),
                  ],
                  indicatorWeight: 3.w,
                  indicatorPadding: EdgeInsets.all(0),
                  labelPadding: EdgeInsets.all(0),
                  isScrollable: false,
                  indicatorColor: Colours.primary,
                  unselectedLabelColor: Colours.text_999,
                  unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.w500),
                  labelStyle: TextStyle(fontWeight: FontWeight.w500),
                  labelColor: Colours.primary,
                )),
            //  }),
            Expanded(
                child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      widgetSaleRecord(),
                      widgetSaleRecord(),
                    ]))
          ],
        ),
      ),
    );
  }

  widgetSaleRecord() {
   return  GetBuilder<ProductCostDetailController>(
         id: 'product_cost_detail',
         builder: (_) {
           return CustomEasyRefresh(
             // controller: state.refreshController,
             // onLoad: onLoad,
             // onRefresh: onRefresh,
             // emptyWidget: state.list == null
             //     ? LottieIndicator()
             //     : state.list?.isEmpty ?? true
             //     ? EmptyLayout(hintText: '什么都没有'.tr)
             //     : null,
             child: ListView.separated(
               itemBuilder: (context, index) {
                // var salePurchaseOrderDTO = state.list![index];
                 return InkWell(
                   onTap: () => Get.toNamed(RouteConfig.costDetail,arguments: {}),
                   child: Column(
                     children: [
                       Container(
                         width: double.infinity,
                         padding: EdgeInsets.symmetric(
                             vertical: 16.w, horizontal: 40.w),
                         color: Colors.white12,
                         child: Row(
                           children: [
                             Text('第一车',
                               style: TextStyle(
                                 color: Colours.text_999,
                                 fontSize: 28.sp,
                                 fontWeight: FontWeight.w500,
                               ),
                             ),
                             const Spacer(),
                             Text('合计：',
                               style: TextStyle(
                                 color: Colours.text_ccc,
                                 fontSize: 24.sp,
                                 fontWeight: FontWeight.w500,
                               ),
                             ),
                             Text('￥222',
                               style: TextStyle(
                                 color: Colours.primary,
                                 fontSize: 32.sp,
                                 fontWeight: FontWeight.w500,
                               ),
                             ),
                           ],
                         )

                       ),
                       Container(
                         color: Colors.white,
                         padding: EdgeInsets.only(
                             left: 40.w,
                             right: 40.w,
                             top: 20.w,
                             bottom: 20.w),
                         child: Column(
                           mainAxisAlignment:
                           MainAxisAlignment.spaceEvenly,
                           children: [
                             Flex(
                               direction: Axis.horizontal,
                               children: [
                                 Expanded(
                                   child: Text(
                                      '2024-09-08',
                                       style: TextStyle(
                                         color: Colours.text_999,
                                         fontSize: 28.sp,
                                         fontWeight: FontWeight.w400,
                                       )),
                                 ),
                                 Visibility(
                                    // visible: salePurchaseOrderDTO.invalid == 1,
                                     child: Container(
                                       padding: EdgeInsets.only(
                                           top: 2.w,
                                           bottom: 2.w,
                                           left: 4.w,
                                           right: 4.w),
                                       decoration: BoxDecoration(
                                         border: Border.all(
                                           color: Colours.text_999,
                                           width: 1.0,
                                         ),
                                         borderRadius:
                                         BorderRadius.circular(8.0),
                                       ),
                                       child: Text('已作废',
                                           style: TextStyle(
                                             color: Colours.text_999,
                                             fontSize: 26.sp,
                                             fontWeight: FontWeight.w500,
                                           )),
                                     )),
                               ],
                             ),
                             SizedBox(height: 24.w,),
                             Flex(
                               direction: Axis.horizontal,
                               children: [
                                 Expanded(
                                   child: Text(
                                      '管理费',
                                       style: TextStyle(
                                         color: Colours.text_333,
                                         fontSize: 32.sp,
                                         fontWeight: FontWeight.w500,
                                       )),
                                 ),
                                 Expanded(
                                     child: Text('￥2000',
                                         textAlign: TextAlign.right,
                                         style: TextStyle(
                                           color: Colours.text_333,
                                           fontSize: 32.sp,
                                           fontWeight: FontWeight.w500,
                                         )),),
                               ],
                             ),
                           ],
                         ),
                       )
                     ],
                   ),
                 );
               },
               separatorBuilder: (context, index) => Container(
                 height: 2.w,
                 color: Colors.white12,
                 width: double.infinity,
               ),
               itemCount: 5,
             ),
           );
         });
  }
}
