// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:get/get.dart';
// import 'package:ledger/entity/product/product_shopping_car_dto.dart';
// import 'package:ledger/res/colors.dart';
// import 'package:ledger/route/route_config.dart';
// import 'package:ledger/util/date_util.dart';
// import 'package:ledger/util/decimal_util.dart';
// import 'package:ledger/util/image_util.dart';
// import 'package:ledger/widget/empty_layout.dart';
// import 'package:ledger/widget/image.dart';
// import 'package:ledger/widget/permission/ledger_widget_type.dart';
// import 'package:ledger/widget/permission/permission_owner_widget.dart';
// import 'package:ledger/widget/will_pop.dart';
//
// import 'pending_sale_bill_controller.dart';
//
// class PendingSaleBillView extends StatelessWidget {
//   PendingSaleBillView({super.key});
//
//   final controller = Get.find<PendingSaleBillController>();
//
//   @override
//   Widget build(BuildContext context) {
//     controller.initState();
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: GetBuilder<PendingSaleBillController>(
//           id: 'bill_title',
//           init: controller,
//           global: false,
//           builder: (_) {
//             return Text('${controller.state.ledgerName ?? ''} 开单',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   color: Colors.white,
//                 ));
//           },
//         ),
//         leading: BackButton(
//             onPressed: () {
//               Get.until((route) {
//                 return ((route.settings.name == RouteConfig.sale) ||
//                     (route.settings.name == RouteConfig.purchase) ||
//                     (route.settings.name == RouteConfig.main));
//               });
//             },
//             color: Colors.white),
//         backgroundColor: Colours.primary,
//         actions: [
//           Padding(
//             padding: EdgeInsets.only(right: 25.0),
//             child: InkWell(
//                 onTap: () =>
//                     Get.toNamed(RouteConfig.pendingOrder)?.then((value) {
//                       controller.pendingOrderNum();
//                     }),
//                 child: GetBuilder<PendingSaleBillController>(
//                     id: 'pending_order_count',
//                     init: controller,
//                     global: false,
//                     builder: (_) {
//                       return Row(
//                         children: [
//                           LoadAssetImage(
//                             'pending_order',
//                             format: ImageFormat.png,
//                             color: ((controller.state.pendingOrderNum != 0) &&
//                                     (controller.state.pendingOrderNum != null))
//                                 ? Colors.white
//                                 : Colors.white38,
//                             height: 70.w,
//                             width: 70.w,
//                           ),
//                           Text(
//                             ((controller.state.pendingOrderNum != 0) &&
//                                     (controller.state.pendingOrderNum != null))
//                                 ? controller.state.pendingOrderNum.toString()
//                                 : '',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         ],
//                       );
//                     })),
//           ),
//         ],
//       ),
//       body: MyWillPop(
//           onWillPop: () async {
//             Get.until((route) {
//               return ((route.settings.name == RouteConfig.sale) ||
//                   (route.settings.name == RouteConfig.purchase) ||
//                   (route.settings.name == RouteConfig.main));
//             });
//             return Future(() => true);
//           },
//           child: FormBuilder(
//               key: controller.state.formKey,
//               child: CustomScrollView(
//                 slivers: [
//                   SliverToBoxAdapter(
//                     child: Column(
//                       children: [
//                         Container(
//                             color: Colors.white,
//                             padding: EdgeInsets.only(
//                                 left: 40.w,
//                                 right: 40.w,
//                                 top: 40.w,
//                                 bottom: 20.w),
//                             child: Column(
//                               children: [
//                                 PermissionOwnerWidget(
//                                     widgetType: LedgerWidgetType.Disable,
//                                     child: Row(
//                                       children: [
//                                         Text(
//                                           '日期',
//                                           style: TextStyle(
//                                             color: Colours.text_666,
//                                             fontSize: 30.sp,
//                                             fontWeight: FontWeight.w400,
//                                           ),
//                                         ),
//                                         const Spacer(),
//                                         InkWell(
//                                           onTap: () =>
//                                               controller.pickerDate(context),
//                                           child: GetBuilder<
//                                                   PendingSaleBillController>(
//                                               id: 'bill_date',
//                                               init: controller,
//                                               global: false,
//                                               builder: (_) {
//                                                 return Text(
//                                                   DateUtil.formatDefaultDate(
//                                                       controller.state.date),
//                                                   style: TextStyle(
//                                                     color: Colours.text_333,
//                                                     fontSize: 30.sp,
//                                                     fontWeight: FontWeight.w500,
//                                                   ),
//                                                 );
//                                               }),
//                                         )
//                                       ],
//                                     )),
//                                 Container(
//                                   color: Colours.divider,
//                                   height: 1.w,
//                                   margin: EdgeInsets.only(top: 16, bottom: 16),
//                                   width: double.infinity,
//                                 ),
//                                 GetBuilder<PendingSaleBillController>(
//                                     id: 'bill_custom',
//                                     init: controller,
//                                     global: false,
//                                     builder: (_) {
//                                       return InkWell(
//                                           onTap: () =>
//                                               controller.pickerCustom(),
//                                           child: Row(
//                                             children: [
//                                               Text(
//                                                 '客户',
//                                                 style: TextStyle(
//                                                   color: Colours.text_666,
//                                                   fontSize: 30.sp,
//                                                   fontWeight: FontWeight.w400,
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                   child: Text(
//                                                 textAlign: TextAlign.right,
//                                                 controller.state.customDTO
//                                                         ?.customName ??
//                                                     '默认客户',
//                                                 style: TextStyle(
//                                                   color: Colours.text_333,
//                                                   fontSize: 30.sp,
//                                                   fontWeight: FontWeight.w500,
//                                                 ),
//                                               )),
//                                               Padding(
//                                                 padding:
//                                                     EdgeInsets.only(left: 20.w),
//                                                 child: LoadAssetImage(
//                                                   'common/arrow_right',
//                                                   width: 25.w,
//                                                   color: Colours.text_999,
//                                                 ),
//                                               ),
//                                             ],
//                                           ));
//                                     }),
//                                 Container(
//                                   color: Colours.divider,
//                                   height: 1.w,
//                                   margin: EdgeInsets.only(top: 16, bottom: 8),
//                                   width: double.infinity,
//                                 ),
//                                 Flex(
//                                   direction: Axis.horizontal,
//                                   children: [
//                                     Expanded(
//                                         child: Text(
//                                       '备注',
//                                       style: TextStyle(
//                                         color: Colours.text_666,
//                                         fontSize: 30.sp,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     )),
//                                     Expanded(
//                                         flex: 3,
//                                         child: TextFormField(
//                                           controller: controller.state
//                                               .remarkTextEditingController,
//                                           textAlign: TextAlign.right,
//                                           keyboardType:
//                                               TextInputType.streetAddress,
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.w500,
//                                               fontSize: 30.sp),
//                                           decoration: InputDecoration(
//                                               hintText: '请填写',
//                                               border: InputBorder.none,
//                                               counterText: ''),
//                                           maxLength: 32,
//                                         ))
//                                   ],
//                                 ),
//                               ],
//                             )),
//                         Container(
//                           width: double.infinity,
//                           height: 80.w,
//                           margin: EdgeInsets.only(
//                               left: 20, right: 20, top: 10, bottom: 10),
//                           child: ElevatedButton(
//                             onPressed: () => controller.addShoppingCar(),
//                             child: Text(
//                               '+ 添加货物',
//                               style: TextStyle(
//                                 fontSize: 32.sp,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                         ),
//                         // 货物详情
//                         GetBuilder<PendingSaleBillController>(
//                             id: 'sale_bill_product_title',
//                             init: controller,
//                             global: false,
//                             builder: (_) {
//                               return Visibility(
//                                   visible: controller.state.visible,
//                                   child:  Container(
//                                     padding: EdgeInsets.only(left: 40.w, right: 40.w, top: 30.w),
//                                     width: double.infinity,
//                                     color: Colors.white,
//                                     child: Row(
//                                       children: [
//                                         Container(
//                                           color: Colours.primary,
//                                           height: 38.w,
//                                           width: 8.w,
//                                         ),
//                                         Container(
//                                           color: Colors.white,
//                                           margin: EdgeInsets.only(left: 6),
//                                           child: Text(
//                                             '货物明细',
//                                             style: TextStyle(
//                                                 color: Colours.text_666,
//                                                 fontSize: 36.sp,
//                                                 fontWeight: FontWeight.w600),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ));
//                             }),
//                       ],
//                     ),
//                   ),
//                   GetBuilder<PendingSaleBillController>(
//                       id: 'pending_sale_bill_product_list',
//                       init: controller,
//                       global: false,
//                       builder: (_) {
//                         return controller.state.shoppingCarList.isEmpty
//                             ? SliverToBoxAdapter(
//                                 child: EmptyLayout(hintText: '请添加货物'),
//                               )
//                             : SliverList.separated(
//                                 separatorBuilder: (context, index) => Container(
//                                   height: 1.w,
//                                   color: Colours.divider,
//                                   width: double.infinity,
//                                 ),
//                                 itemCount:
//                                     controller.state.shoppingCarList.length,
//                                 itemBuilder: (BuildContext context, int index) {
//                                   ProductShoppingCarDTO productDTO =
//                                       controller.state.shoppingCarList[index];
//                                   return Slidable(
//                                       endActionPane: ActionPane(
//                                         motion: const ScrollMotion(),
//                                         extentRatio: 0.25,
//                                         children: [
//                                           SlidableAction(
//                                             label: '删除',
//                                             backgroundColor: Colors.red,
//                                             icon: Icons.delete_outline_rounded,
//                                             onPressed: (context) {
//                                               controller
//                                                   .toDeleteOrder(productDTO);
//                                             },
//                                           ),
//                                         ],
//                                       ),
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                             vertical: 24.w,
//                                             horizontal: 40.w),
//                                         width: double.infinity,
//                                         color: Colors.white,
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceEvenly,
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 Expanded(
//                                                     child: Text(
//                                                         productDTO
//                                                                 .productName ??
//                                                             '',
//                                                         style: TextStyle(
//                                                           color:
//                                                               Colours.text_333,
//                                                           fontSize: 32.sp,
//                                                           fontWeight:
//                                                               FontWeight.w500,
//                                                         ))),
//                                                 Text(
//                                                     '￥${DecimalUtil.formatDecimalDefault(productDTO.unitDetailDTO?.totalAmount)}',
//                                                     style: TextStyle(
//                                                       color: Colours.text_333,
//                                                       fontSize: 30.sp,
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                     )),
//                                               ],
//                                             ),
//                                             SizedBox(
//                                               height: 10.w,
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Text(
//                                                     controller.getPrice(productDTO
//                                                             .unitDetailDTO!) ??
//                                                         '',
//                                                     style: TextStyle(
//                                                       color: Colours.text_666,
//                                                       fontSize: 26.sp,
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                     )),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ));
//                                 },
//                               );
//                       }),
//                   SliverToBoxAdapter(
//                     child: Container(
//                       height: 130.w,
//                     ),
//                   )
//                 ],
//               ))),
//       //底部按钮
//       floatingActionButton: GetBuilder<PendingSaleBillController>(
//           id: 'sale_bill_btn',
//           init: controller,
//           global: false,
//           builder: (_) {
//             return Container(
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.5),
//                     offset: Offset(1, 1),
//                     blurRadius: 3,
//                   ),
//                 ],
//                 borderRadius: BorderRadius.circular(20.0),
//                 color: Colors.white,
//               ),
//               padding: EdgeInsets.all(10.w),
//               margin: EdgeInsets.symmetric(vertical: 2.w, horizontal: 10.w),
//               child: Flex(
//                 direction: Axis.horizontal,
//                 children: [
//                   Expanded(
//                     flex: 3,
//                     child: Row(
//                       children: [
//                         Visibility(
//                             child: InkWell(
//                                 onTap: () => controller.pendingOrder(),
//                                 child: Row(
//                                   children: [
//                                     LoadAssetImage(
//                                       'pending_order',
//                                       format: ImageFormat.png,
//                                       color: Colours.primary,
//                                       height: 70.w,
//                                       width: 70.w,
//                                     ),
//                                     Text('挂单')
//                                   ],
//                                 ))),
//                         Visibility(
//                             child: Container(
//                           width: 2.w,
//                           height: 80.w,
//                           margin: EdgeInsets.only(left: 16.w),
//                           color: Colours.divider,
//                         )),
//                         Container(
//                             margin: EdgeInsets.only(left: 16.w),
//                             child: Text(
//                               '应收：',
//                               style: TextStyle(
//                                   color: Colours.text_999,
//                                   fontSize: 26.sp,
//                                   fontWeight: FontWeight.w500),
//                             )),
//                         Expanded(
//                             flex: 2,
//                             child: Text(
//                               DecimalUtil.formatAmount(
//                                   controller.state.totalAmount),
//                               style: TextStyle(
//                                 color: Colors.red[600],
//                                 fontSize: 42.sp,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             )),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                       flex: 2,
//                       child: Container(
//                         height: 100.w,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             controller.state.formKey.currentState
//                                         ?.saveAndValidate() ??
//                                     false
//                                 ? controller.showPaymentDialog(context)
//                                 : null;
//                           },
//                           style: ButtonStyle(
//                             maximumSize: MaterialStateProperty.all(
//                                 Size(double.infinity, 60)),
//                             backgroundColor:
//                                 MaterialStateProperty.all(Colours.primary),
//                             shape: MaterialStateProperty.all(
//                                 RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15.0),
//                             )),
//                           ),
//                           child: Text(
//                             '支付',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 30.sp,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       )),
//                 ],
//               ),
//             );
//           }),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
// }
