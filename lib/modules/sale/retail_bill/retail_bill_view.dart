import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/product/product_classify_dto.dart';
import 'package:ledger/entity/product/product_dto.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/image_util.dart';
import 'package:ledger/widget/permission/ledger_widget_type.dart';
import 'package:ledger/widget/permission/permission_owner_widget.dart';

import 'retail_bill_controller.dart';

class RetailBillView extends StatelessWidget {
  RetailBillView({super.key});

  final controller = Get.find<RetailBillController>();

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: TitleBar(
        title:  controller.state.orderType == OrderType.SALE
          ?'${controller.state.ledgerName ?? ''} 开单'
          : controller.state.orderType == OrderType.SALE_RETURN
              ?'销售退单'
              :'仅退款',
        titleColor: controller.state.orderType == OrderType.SALE
             ?Colors.black87
             :Colors.red,
        actionWidget: PermissionOwnerWidget(
            widgetType: LedgerWidgetType.Disable,
            child: InkWell(
              onTap: () => controller.pickerDate(context),
              child: GetBuilder<RetailBillController>(
                  id: 'bill_date',
                  init: controller,
                  global: false,
                  builder: (_) {
                    return Container(
                      padding: EdgeInsets.only(right: 16.w),
                      child:  Text(
                        DateUtil.formatDayMonthDate(
                            controller.state.date),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }),
            )),
      ),
      body:  DefaultTabController(
        length: 3,
        child: Container(
          //color: Colors.white,
          child: Column(
            children: [
              Expanded(
                  child:
                    Column(
                      children: [
                        //搜索
                        Container(
                            height: 100.w,
                           width: double.infinity,
                            color: Colors.white38,
                            padding: EdgeInsets.only( left: 16.w, right: 16.w),
                            child:  Flex(
                              direction:Axis.horizontal,
                              children: [
                                Expanded(
                                    flex: 3,
                                  child: GetBuilder<RetailBillController>(
                                      id: 'retail_bill_sale_custom',
                                      init: controller,
                                      global: false,
                                      builder: (_){
                                    return InkWell(
                                        onTap: () =>
                                            controller.pickerCustom(),
                                        child:Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.person_outline_rounded,
                                                color: controller.state.customDTO?.customName?.isEmpty??false
                                                    ?Colours.text_999
                                                    :Colors.orange[600]
                                            ),
                                            Expanded(child:Text(
                                              controller.customName(),
                                              style: TextStyle(
                                                  fontSize: 28.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: controller.state.customDTO?.customName?.isEmpty??false
                                                      ?Colours.text_999
                                                      :Colors.orange[600]
                                              ),
                                            ) )
                                          ],
                                        ));
                                  })
                                  ),
                                Container(
                                  height: 40.w,
                                  width: 2.w,
                                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                                  color: Colours.text_ccc,
                                ),
                                Icon(
                                  Icons.search,
                                  size: 40.w,
                                  color: Colours.text_999,),
                                Expanded(
                                    flex: 4,
                                    child:
                                TextFormField(
                                  onChanged:  (value){
                                    controller.searchShoppingCar(value);
                                  },
                                  decoration: (InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '请输入货物名')),
                                  style: TextStyle(
                                      fontSize: 28.sp,
                                      color: Colours.text_999
                                  ),)),
                                Container(
                                  height: 40.w,
                                  width: 2.w,
                                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                                  color: Colours.text_ccc,
                                ),
                               Visibility(
                                      visible: controller.state.orderType ==OrderType.SALE,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                                        child: GetBuilder<RetailBillController>(
                                              id: 'sale_bill_pending_order',
                                              init: controller,
                                              global: false,
                                              builder: (_){
                                                return  InkWell(
                                                    onTap: () =>Get.toNamed(RouteConfig.pendingOrder)?.then((value){
                                                      if(OrderType.SALE == controller.state.orderType){
                                                        controller.pendingOrderNum();
                                                      }
                                                    }),
                                                    child:Row(
                                                  children: [
                                                    LoadAssetImage(
                                                      'pending_order',
                                                      format: ImageFormat.png,
                                                      color: ((controller.state.pendingOrderNum != 0)&&(controller.state.pendingOrderNum !=null))
                                                          ? Colours.primary
                                                          : Colours.text_ccc,
                                                      height: 70.w,
                                                      width: 70.w,
                                                    ),
                                                    Text(((controller.state.pendingOrderNum != 0)&&(controller.state.pendingOrderNum !=null))
                                                        ? controller.state.pendingOrderNum.toString()
                                                        : '',
                                                      style: TextStyle(
                                                          color: Colours.primary,
                                                          fontWeight: FontWeight.w500
                                                      ),)
                                                  ],
                                                ));
                                              },)

                                      ),
                                    )
                              ],
                            )
                        ),
                        //列表
                        Expanded(
                            child: GetBuilder<RetailBillController>(
                                id: 'product_classify_list',
                                init: controller,
                                global: false,
                                builder: (_) {
                                  return Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          children: [
                                            Expanded(
                                                child: Container(
                                                  color: Colors.white30,
                                                  child:controller.state.productClassifyListDTO
                                                      ?.productClassifyList ==
                                                      null
                                                      ? LottieIndicator()
                                                      : controller.state.productClassifyListDTO!
                                                      .productClassifyList!.isEmpty
                                                      ? EmptyLayout(hintText: '什么都没有')
                                                      : ListView.builder(
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.only(top: 0),
                                                    controller: controller.state.menuController,
                                                    itemCount:controller.state.productClassifyListDTO
                                                        ?.productClassifyList
                                                        ?.length ?? 0,
                                                    itemBuilder: (BuildContext context,
                                                        int index) {
                                                      ProductClassifyDTO classifyDTO =
                                                      controller.state.productClassifyListDTO!.productClassifyList![index];
                                                      return GestureDetector(
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          height: controller.state.menuItemHeight,
                                                          decoration: BoxDecoration(
                                                            color: controller.state.selectType == classifyDTO.id
                                                                ? Colors.white
                                                                : Colours.bg,
                                                            border: Border(
                                                              left: BorderSide(
                                                                  width: 3,
                                                                  color:controller.state.selectType == classifyDTO.id
                                                                      ? Colours.primary
                                                                      : Colors.white
                                                              ),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            //左侧菜单
                                                            classifyDTO.productClassify ?? '',
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              color:controller.state.selectType == classifyDTO.id
                                                                  ? Colours.primary
                                                                  : Colours.text_999,
                                                              fontSize: 32.sp,
                                                            ),
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          controller.switchSelectType(classifyDTO.id);
                                                        },
                                                      );
                                                    },
                                                  ),
                                                )),
                                            Container(
                                              height: 2.w,
                                              color: Colours.divider,
                                            ),
                                            Align(
                                                alignment: Alignment.bottomCenter,
                                                child:IconButton(
                                                    onPressed: () => controller.toProductClassify(),
                                                    icon: Icon(Icons.settings,size: 50.w,color: Colours.text_999),
                                                   )
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          flex:7,
                                          child: CustomEasyRefresh(
                                              controller: controller.state.refreshController,
                                              onLoad: controller.onLoad,
                                              onRefresh: controller.onRefresh,
                                              emptyWidget: controller.state.productList == null
                                                  ? LottieIndicator()
                                                  : controller.state.productList!.isEmpty
                                                  ? EmptyLayout(hintText: '什么都没有'.tr)
                                                  : null,
                                              child: ListView.separated(
                                                itemCount: controller.state.productList?.length ?? 0,
                                                itemBuilder: (BuildContext context, int index) {
                                                  ProductDTO stockDTO = controller.state.productList![index];
                                                  return InkWell(
                                                      onTap: () => controller.addToShoppingCar(stockDTO),
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            width: double.infinity,
                                                            color: Colors.white,
                                                            padding: EdgeInsets.symmetric(
                                                              vertical: 16.w,
                                                              horizontal: 32.w,),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                              children: [
                                                                Container(
                                                                    padding: EdgeInsets.symmetric(vertical: 10.w),
                                                                    child: Flex(
                                                                        direction: Axis.horizontal,
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.start,
                                                                        children: [
                                                                          Expanded(
                                                                            flex: 3,
                                                                            child: Text(
                                                                                stockDTO.productName ??
                                                                                    '',
                                                                                style: TextStyle(
                                                                                  color: stockDTO
                                                                                      .invalid ==
                                                                                      1
                                                                                      ? Colours.text_ccc
                                                                                      : Colours.text_333,
                                                                                  fontSize: 32.sp,
                                                                                  fontWeight:
                                                                                  FontWeight.w500,
                                                                                )),
                                                                          ),
                                                                          Visibility(
                                                                              visible:
                                                                              stockDTO.invalid == 1,
                                                                              child: Container(
                                                                                padding: EdgeInsets.only(
                                                                                    top: 2.w,
                                                                                    bottom: 2.w,
                                                                                    left: 4.w,
                                                                                    right: 4.w),
                                                                                decoration: BoxDecoration(
                                                                                  border: Border.all(
                                                                                    color:
                                                                                    Colours.text_ccc,
                                                                                    width: 1.0,
                                                                                  ),
                                                                                  borderRadius:
                                                                                  BorderRadius
                                                                                      .circular(8.0),
                                                                                ),
                                                                                child: Text('已停用',
                                                                                    style: TextStyle(
                                                                                      color: Colours
                                                                                          .text_999,
                                                                                      fontSize: 26.sp,
                                                                                      fontWeight:
                                                                                      FontWeight.w500,
                                                                                    )),
                                                                              )),
                                                                          Expanded(
                                                                            child: Text(
                                                                                textAlign: TextAlign.end,
                                                                                controller.getSalesChannel(
                                                                                    stockDTO
                                                                                        .salesChannel),
                                                                                style: TextStyle(
                                                                                  color: stockDTO
                                                                                      .invalid ==
                                                                                      1
                                                                                      ? Colours.text_ccc
                                                                                      : Colours.text_999,
                                                                                  fontSize: 22.sp,
                                                                                  fontWeight:
                                                                                  FontWeight.w400,
                                                                                )),
                                                                          )
                                                                        ])),
                                                                Container(
                                                                  alignment:Alignment.centerLeft,
                                                                  child: Text(textAlign: TextAlign.left,
                                                                      controller.judgeUnit(
                                                                          stockDTO),
                                                                      style: TextStyle(
                                                                        color: stockDTO.invalid == 1
                                                                            ? Colours.text_ccc
                                                                            : Colours.text_999,
                                                                        fontSize: 30.sp,
                                                                        fontWeight:
                                                                        FontWeight.w500,
                                                                      )),
                                                                ),
                                                                Flex(direction: Axis.horizontal,
                                                                  children: [
                                                                    Expanded(child:
                                                                    Visibility(
                                                                        maintainSize: false,
                                                                        visible:(((stockDTO.productPlace !=null))&&( (stockDTO.productStandard!=null))),
                                                                        child:
                                                                        Container(
                                                                          padding: EdgeInsets.only(top: 16.w),
                                                                          child:  Flex(direction: Axis.horizontal,
                                                                            children: [
                                                                              Text(
                                                                                  stockDTO.productPlace ?? '',
                                                                                  style:
                                                                                  TextStyle(
                                                                                    color: stockDTO.invalid == 1
                                                                                        ? Colours.text_ccc
                                                                                        : Colours.text_999,
                                                                                    fontSize: 26.sp,
                                                                                    fontWeight:
                                                                                    FontWeight
                                                                                        .w500,
                                                                                  )),
                                                                              SizedBox(width: 32.w,),
                                                                              Expanded(child:Text(
                                                                                  stockDTO.productStandard ?? '',
                                                                                  style:
                                                                                  TextStyle(
                                                                                    color: stockDTO
                                                                                        .invalid ==
                                                                                        1
                                                                                        ? Colours
                                                                                        .text_ccc
                                                                                        : Colours
                                                                                        .text_999,
                                                                                    fontSize:
                                                                                    26.sp,
                                                                                    fontWeight:
                                                                                    FontWeight
                                                                                        .w500,
                                                                                  )) ),
                                                                            ],
                                                                          ),
                                                                        )
                                                                    )
                                                                    ),
                                                                    Visibility(
                                                                        visible: controller.state.orderType != OrderType.REFUND,
                                                                        replacement: Container(
                                                                          margin: EdgeInsets.symmetric(
                                                                              horizontal: 16.w),
                                                                          padding: EdgeInsets.symmetric(
                                                                              horizontal: 8.w, vertical: 4.w),
                                                                          decoration: (BoxDecoration(
                                                                              borderRadius:
                                                                              BorderRadius.circular((36)),
                                                                              border: Border.all(
                                                                                  color: Colours.primary,
                                                                                  width: 3.w),
                                                                              color: Colors.white)),
                                                                          child: Text(
                                                                            '+ 退款',
                                                                            style: TextStyle(
                                                                              fontSize: 28.sp,
                                                                              color: Colours.primary,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        child:Container(
                                                                          padding: EdgeInsets.only(left: 48.w),
                                                                          child:  LoadAssetImage(
                                                                            'add_goods',
                                                                            width: 50.w,
                                                                            height: 50.w,
                                                                          ),
                                                                        ) )

                                                                  ],)
                                                              ],
                                                            ),
                                                          ),
                                                          Positioned(
                                                            left: 8.w,
                                                            bottom: 8.w,
                                                            child:LoadAssetImage(
                                                            'retail_bill_checked',
                                                            format: ImageFormat.png,
                                                            //color: Colors.orange,
                                                            height: 50.w,
                                                            width: 50.w,
                                                          ),)
                                                        ],
                                                      )
                                                  );
                                                },
                                                separatorBuilder: (context, index) => Container(
                                                  height: 2.w,
                                                  color: Colours.divider,
                                                  width: double.infinity,
                                                ),
                                              ))
                                      ),
                                    ],
                                  );})),
                      ],
                    ),
                ),
              //底部栏
              GetBuilder<RetailBillController>(
                  id: 'shopping_car_box',
                  init: controller,
                  global: false,
                  builder: (_) {
                    return Container(
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(1, 1),
                            blurRadius: 3,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                      ),
                      height: 120.w,
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                            flex: 2,
                              child:
                            Visibility(
                                visible: controller.state.orderType ==OrderType.SALE,
                                child: InkWell(
                                    onTap: () =>controller.pendingOrder(),
                                    child:  Row(
                                      children: [
                                        LoadAssetImage(
                                          'pending_order',
                                          format: ImageFormat.png,
                                          color: Colours.primary,
                                          height: 70.w,
                                          width: 70.w,
                                        ),
                                        Expanded(child:
                                        Text('挂单',))
                                      ],
                                    )
                                )),
                          ),
                          Visibility(
                              visible:controller.state.orderType ==OrderType.SALE,
                              child: Container(
                                width: 2.w,
                                height: 60.w,
                                margin: EdgeInsets.symmetric(horizontal: 16.w),
                                color: Colours.divider,
                              )),
                          Expanded(
                            flex: 4,
                                child: InkWell(
                                  onTap: () =>controller.toShoppingCarList(context),
                                     // controller.showShoppingCarDialog(context),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.shopping_cart_outlined,
                                        color: Colours.primary,
                                      ),
                                      Expanded(child:
                                      Text('${controller.state.shoppingCarList?.length ?? 0}',
                                        style: TextStyle(
                                          color: Colors.red[600],
                                          fontSize: 32.sp,
                                            fontWeight: FontWeight.w500
                                        ),
                                        textAlign: TextAlign.center,
                                      )),
                                      Text(
                                        '种',
                                        style: TextStyle(
                                          color: Colours.text_666,
                                          fontSize: 28.sp,
                                            fontWeight: FontWeight.w500
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Expanded(child:
                                      Text(
                                        controller.getTotalAmount() ?? '',
                                        style: TextStyle(
                                            color: Colors.red[600],
                                            fontSize: 32.sp,
                                            fontWeight: FontWeight.w500
                                        ),
                                        textAlign: TextAlign.center,
                                      )),
                                      Text(
                                        '元',
                                        style: TextStyle(
                                          color: Colours.text_666,
                                          fontSize: 28.sp,
                                          fontWeight: FontWeight.w500
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(width: 8.w,)
                                    ],
                                  ),
                                )),
                          Expanded(
                            flex: 3,
                            child: ElevatedButton(
                              onPressed: (){
                                 controller.showPaymentDialog();
                              },
                              style: ButtonStyle(
                                maximumSize: MaterialStateProperty.all(
                                    Size(double.infinity, 60)),
                                backgroundColor:
                                MaterialStateProperty.all(Colours.primary),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                )),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '支付',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),

      )
    );
  }
}
