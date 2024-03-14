import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/product/product_classify_dto.dart';
import 'package:ledger/entity/product/product_dto.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/util/date_util.dart';
import 'package:ledger/util/image_util.dart';
import 'package:ledger/widget/custom_easy_refresh.dart';
import 'package:ledger/widget/empty_layout.dart';
import 'package:ledger/widget/image.dart';
import 'package:ledger/widget/lottie_indicator.dart';
import 'package:ledger/widget/permission/ledger_widget_type.dart';
import 'package:ledger/widget/permission/permission_owner_widget.dart';
import 'package:ledger/widget/will_pop.dart';

import 'retail_bill_controller.dart';

class RetailBillView extends StatelessWidget {
  RetailBillView({super.key});

  final controller = Get.find<RetailBillController>();
  final state = Get.find<RetailBillController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight:100.w,
        title: Text( '${state.ledgerName ?? ''} 开单',
            style: TextStyle(color: Colors.white,fontSize: 40.sp),),
        leading: BackButton(
          onPressed: (){
            Get.back();
          },
          color: Colors.white,
        ),
        actions:[ Visibility(
          visible: controller.state.orderType ==OrderType.SALE,
          child: Padding(
            padding: EdgeInsets.only(right: 25.0),
            child: InkWell(
                onTap: () =>Get.toNamed(RouteConfig.pendingOrder)?.then((value){
                  if(OrderType.SALE == controller.state.orderType){
                    controller.pendingOrderNum();
                  }
                }),
                child: GetBuilder<RetailBillController>(
                  id: 'sale_bill_pending_order',
                  init: controller,
                  global: false,
                  builder: (_){
                    return Row(
                      children: [
                        LoadAssetImage(
                          'pending_order',
                          format: ImageFormat.png,
                          color: ((controller.state.pendingOrderNum != 0)&&(controller.state.pendingOrderNum !=null))
                              ? Colors.white
                              : Colors.white38,
                          height: 70.w,
                          width: 70.w,
                        ),
                        Text(((controller.state.pendingOrderNum != 0)&&(controller.state.pendingOrderNum !=null))
                            ? controller.state.pendingOrderNum.toString()
                            : '',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500
                          ),),
                      ],
                    );
                  },)
            ),
          ),
        )],
      ),
      body:MyWillPop(
          onWillPop: () async {
            controller.saleBillGetBack();
            return true;
          },
          child:DefaultTabController(
        length: 3,
        child: Container(
          //color: Colors.white,
          child: Column(
            children: [
               Container(
          height: 90.w, // 调整TabBar高度
          child:
              TabBar(
                tabs: [
                  Tab(text: '销售',),
                  Tab(text: '退货',),
                  Tab(text: '退款',)
                ],
                indicatorWeight: 3.w,
                indicatorPadding: EdgeInsets.all(0),
                labelPadding: EdgeInsets.all(0),
                isScrollable: false,
                indicatorColor: Colours.primary,
                unselectedLabelColor: Colours.text_999,
                dividerHeight: 100.w,
                unselectedLabelStyle:
                const TextStyle(fontWeight: FontWeight.w500),
                labelStyle: TextStyle(fontWeight: FontWeight.w500),
                labelColor:  Colours.primary,
              )),
              Expanded(
                  child: TabBarView(children: [
                    Column(
                      children: [
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
                                      builder: (_){
                                    return InkWell(
                                        onTap: () =>
                                            controller.pickerCustom(),
                                        child:Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.person_outline_rounded,
                                                color: state.customDTO?.customName?.isEmpty??false
                                                    ?Colours.text_999
                                                    :Colors.orange[600]
                                            ),
                                            Expanded(child:Text(
                                              controller.customName(),
                                              style: TextStyle(
                                                  fontSize: 28.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: state.customDTO?.customName?.isEmpty??false
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
                                Expanded(
                                    flex: 2,
                                    child:PermissionOwnerWidget(
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
                                                      color: Colours.text_666,
                                                      fontSize: 28.sp,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ))
                                    // InkWell(
                                    //     onTap: () {
                                    //       controller.addProduct();
                                    //     },
                                    //     child: PermissionWidget(
                                    //       permissionCode: PermissionCode
                                    //           .stock_list_add_product_permission,
                                    //       child:
                                    //       Icon(
                                    //         Icons.add,
                                    //         color: Colours.text_999,
                                    //       ),
                                    //     ))
                                  )
                              ],
                            )
                        ),
                        Expanded(
                            child: GetBuilder<RetailBillController>(
                                id: 'product_classify_list',
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
                                                  child:state.productClassifyListDTO
                                                      ?.productClassifyList ==
                                                      null
                                                      ? LottieIndicator()
                                                      : state.productClassifyListDTO!
                                                      .productClassifyList!.isEmpty
                                                      ? EmptyLayout(hintText: '什么都没有')
                                                      : ListView.builder(
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.only(top: 0),
                                                    controller: state.menuController,
                                                    itemCount:state.productClassifyListDTO
                                                        ?.productClassifyList
                                                        ?.length ?? 0,
                                                    itemBuilder: (BuildContext context,
                                                        int index) {
                                                      ProductClassifyDTO classifyDTO =
                                                      state.productClassifyListDTO!.productClassifyList![index];
                                                      return GestureDetector(
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          height: state.menuItemHeight,
                                                          decoration: BoxDecoration(
                                                            color:state.selectType == classifyDTO.id
                                                                ? Colors.white
                                                                : Colours.bg,
                                                            border: Border(
                                                              left: BorderSide(
                                                                  width: 3,
                                                                  color:state.selectType == classifyDTO.id
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
                                                              color:state
                                                                  .selectType ==
                                                                  classifyDTO.id
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
                                              controller: state.refreshController,
                                              onLoad: controller.onLoad,
                                              onRefresh: controller.onRefresh,
                                              emptyWidget: state.productList == null
                                                  ? LottieIndicator()
                                                  : state.productList!.isEmpty
                                                  ? EmptyLayout(hintText: '什么都没有'.tr)
                                                  : null,
                                              child: ListView.separated(
                                                itemCount: state.productList?.length ?? 0,
                                                itemBuilder: (BuildContext context, int index) {
                                                  ProductDTO stockDTO = state.productList![index];
                                                  return InkWell(
                                                      onTap: () => controller.addToShoppingCar(stockDTO),
                                                      child: Container(
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
                                                                    visible:(( (stockDTO.productPlace !=null))&&( (stockDTO.productStandard!=null))) ,
                                                                    child:
                                                                    Container(
                                                                      padding: EdgeInsets.only(top: 16.w),
                                                                      child:  Flex(direction: Axis.horizontal,
                                                                        children: [
                                                                          Text(
                                                                              stockDTO.productPlace ??
                                                                                  '',
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
                                                                Container(
                                                                  padding: EdgeInsets.only(left: 48.w),
                                                                  child:  LoadAssetImage(
                                                                    'add_goods',
                                                                    width: 50.w,
                                                                    height: 50.w,
                                                                  ),
                                                                )
                                                              ],)
                                                          ],
                                                        ),
                                                      ));
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
                    Column(
                      children: [
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                  height: 100.w,
                                  padding: EdgeInsets.only(top: 20.w, left: 20.w, right: 20.w),
                                  margin: EdgeInsets.only(bottom: 20.w),
                                  child: SearchBar(
                                      onChanged: (value){
                                        controller.searchShoppingCar(value);
                                      },
                                      leading: Icon(
                                        Icons.search,
                                        color: Colors.grey,
                                      ),
                                      hintText: '请输入货物或供应商名称')),
                            ),
                          ],
                        ),
                        Expanded(
                            child: GetBuilder<RetailBillController>(
                                id: 'product_classify_list',
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
                                                  child:state.productClassifyListDTO
                                                      ?.productClassifyList ==
                                                      null
                                                      ? LottieIndicator()
                                                      : state.productClassifyListDTO!
                                                      .productClassifyList!.isEmpty
                                                      ? EmptyLayout(hintText: '什么都没有')
                                                      : ListView.builder(
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.only(top: 0),
                                                    controller: state.menuController,
                                                    itemCount:state.productClassifyListDTO
                                                        ?.productClassifyList
                                                        ?.length ?? 0,
                                                    itemBuilder: (BuildContext context,
                                                        int index) {
                                                      ProductClassifyDTO classifyDTO =
                                                      state.productClassifyListDTO!.productClassifyList![index];
                                                      return GestureDetector(
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          height: state.menuItemHeight,
                                                          decoration: BoxDecoration(
                                                            color:state.selectType == classifyDTO.id
                                                                ? Colors.white
                                                                : Colours.bg,
                                                            border: Border(
                                                              left: BorderSide(
                                                                  width: 3,
                                                                  color:state.selectType == classifyDTO.id
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
                                                              color:state
                                                                  .selectType ==
                                                                  classifyDTO.id
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
                                            Align(
                                                alignment: Alignment.bottomCenter,
                                                child: InkWell(
                                                  onTap: () => controller.toProductClassify(),
                                                  child: Container(
                                                    margin:
                                                    EdgeInsets.only(bottom: 8.w, left: 8.w),
                                                    decoration: (BoxDecoration(
                                                      borderRadius: BorderRadius.circular((12)),
                                                      border: Border.all(
                                                          color: Colours.text_ccc, width: 3.w),
                                                    )),
                                                    alignment: Alignment.center,
                                                    height: 120.w,
                                                    child: Text('分类管理'),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          flex:7,
                                          child: CustomEasyRefresh(
                                              controller: state.refreshController,
                                              onLoad: controller.onLoad,
                                              onRefresh: controller.onRefresh,
                                              emptyWidget: state.productList == null
                                                  ? LottieIndicator()
                                                  : state.productList!.isEmpty
                                                  ? EmptyLayout(hintText: '什么都没有'.tr)
                                                  : null,
                                              child: ListView.separated(
                                                itemCount: state.productList?.length ?? 0,
                                                itemBuilder: (BuildContext context, int index) {
                                                  ProductDTO stockDTO = state.productList![index];
                                                  return InkWell(
                                                      onTap: () => controller.addToShoppingCar(stockDTO),
                                                      child: Container(
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
                                                                    visible:(( (stockDTO.productPlace !=null))&&( (stockDTO.productStandard!=null))) ,
                                                                    child:
                                                                    Container(
                                                                      padding: EdgeInsets.only(top: 16.w),
                                                                      child:  Flex(direction: Axis.horizontal,
                                                                        children: [
                                                                          Text(
                                                                              stockDTO.productPlace ??
                                                                                  '',
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
                                                                Container(
                                                                  padding: EdgeInsets.only(left: 48.w),
                                                                  child:  LoadAssetImage(
                                                                    'add_goods',
                                                                    width: 50.w,
                                                                    height: 50.w,
                                                                  ),
                                                                )
                                                              ],)
                                                          ],
                                                        ),
                                                      ));
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

                        Container(
                          height: 100.w,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                  height: 100.w,
                                  padding: EdgeInsets.only(top: 20.w, left: 20.w, right: 20.w),
                                  margin: EdgeInsets.only(bottom: 20.w),
                                  child: SearchBar(
                                      onChanged: (value){
                                        controller.searchShoppingCar(value);
                                      },
                                      leading: Icon(
                                        Icons.search,
                                        color: Colors.grey,
                                      ),
                                      hintText: '请输入货物或供应商名称')),
                            ),
                          ],
                        ),
                        Expanded(
                            child: GetBuilder<RetailBillController>(
                                id: 'product_classify_list',
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
                                                  child:state.productClassifyListDTO
                                                      ?.productClassifyList ==
                                                      null
                                                      ? LottieIndicator()
                                                      : state.productClassifyListDTO!
                                                      .productClassifyList!.isEmpty
                                                      ? EmptyLayout(hintText: '什么都没有')
                                                      : ListView.builder(
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.only(top: 0),
                                                    controller: state.menuController,
                                                    itemCount:state.productClassifyListDTO
                                                        ?.productClassifyList
                                                        ?.length ?? 0,
                                                    itemBuilder: (BuildContext context,
                                                        int index) {
                                                      ProductClassifyDTO classifyDTO =
                                                      state.productClassifyListDTO!.productClassifyList![index];
                                                      return GestureDetector(
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          height: state.menuItemHeight,
                                                          decoration: BoxDecoration(
                                                            color:state.selectType == classifyDTO.id
                                                                ? Colors.white
                                                                : Colours.bg,
                                                            border: Border(
                                                              left: BorderSide(
                                                                  width: 3,
                                                                  color:state.selectType == classifyDTO.id
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
                                                              color:state
                                                                  .selectType ==
                                                                  classifyDTO.id
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
                                            Align(
                                                alignment: Alignment.bottomCenter,
                                                child: InkWell(
                                                  onTap: () => controller.toProductClassify(),
                                                  child: Container(
                                                    margin:
                                                    EdgeInsets.only(bottom: 8.w, left: 8.w),
                                                    decoration: (BoxDecoration(
                                                      borderRadius: BorderRadius.circular((12)),
                                                      border: Border.all(
                                                          color: Colours.text_ccc, width: 3.w),
                                                    )),
                                                    alignment: Alignment.center,
                                                    height: 120.w,
                                                    child: Text('分类管理'),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          flex:7,
                                          child: CustomEasyRefresh(
                                              controller: state.refreshController,
                                              onLoad: controller.onLoad,
                                              onRefresh: controller.onRefresh,
                                              emptyWidget: state.productList == null
                                                  ? LottieIndicator()
                                                  : state.productList!.isEmpty
                                                  ? EmptyLayout(hintText: '什么都没有'.tr)
                                                  : null,
                                              child: ListView.separated(
                                                itemCount: state.productList?.length ?? 0,
                                                itemBuilder: (BuildContext context, int index) {
                                                  ProductDTO stockDTO = state.productList![index];
                                                  return InkWell(
                                                      onTap: () => controller.addToShoppingCar(stockDTO),
                                                      child: Container(
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
                                                                    visible:(( (stockDTO.productPlace !=null))&&( (stockDTO.productStandard!=null))) ,
                                                                    child:
                                                                    Container(
                                                                      padding: EdgeInsets.only(top: 16.w),
                                                                      child:  Flex(direction: Axis.horizontal,
                                                                        children: [
                                                                          Text(
                                                                              stockDTO.productPlace ??
                                                                                  '',
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
                                                                Container(
                                                                  padding: EdgeInsets.only(left: 48.w),
                                                                  child:  LoadAssetImage(
                                                                    'add_goods',
                                                                    width: 50.w,
                                                                    height: 50.w,
                                                                  ),
                                                                )
                                                              ],)
                                                          ],
                                                        ),
                                                      ));
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

                        Container(
                          height: 100.w,
                        )
                      ],
                    ),
                  ])),
              GetBuilder<RetailBillController>(
                  id: 'shopping_car_box',
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
                                  onTap: () =>controller.toShoppingCarList(),
                                     // controller.showShoppingCarDialog(context),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.shopping_cart_outlined,
                                        color: Colours.primary,
                                      ),
                                      Expanded(child:
                                      Text('${state.shoppingCarList?.length ?? 0}',
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
                                 controller.showPaymentDialog(context);
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

      ))
    );
  }
}
