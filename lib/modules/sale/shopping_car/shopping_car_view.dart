import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/entity/product/product_classify_dto.dart';
import 'package:ledger/entity/product/product_dto.dart';
import 'package:ledger/enum/page_to_type.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/widget/custom_easy_refresh.dart';
import 'package:ledger/widget/empty_layout.dart';
import 'package:ledger/widget/image.dart';
import 'package:ledger/widget/lottie_indicator.dart';
import 'package:ledger/widget/permission/permission_widget.dart';

import 'shopping_car_controller.dart';

class ShoppingCarView extends StatelessWidget {
  ShoppingCarView({super.key});

  final controller = Get.find<ShoppingCarController>();
  final state = Get.find<ShoppingCarController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('货物列表'.tr,style: TextStyle(color: Colors.white),),
        leading: BackButton(
          onPressed: (){
            Get.back();
          },
          color: Colors.white,
        ),
        actions:[ Row(children: [
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: InkWell(
              onTap: () => controller.addProduct(),
              child: PermissionWidget(
                permissionCode: PermissionCode.stock_list_add_product_permission,
                child:Icon(
                Icons.add,
                color: Colors.white,
              )),
            ),
          ),
        ])],
      ),
      body: Column(
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
        child: GetBuilder<ShoppingCarController>(
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
                                  controller.switchSelectType(
                                      classifyDTO.id);
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
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10.w),
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
                                                child: toAddButtonWidget(stockDTO),
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
      floatingActionButton: GetBuilder<ShoppingCarController>(
          id: 'shopping_car_box',
          builder: (_) {
            return Container(
              margin: EdgeInsets.only(right: 40.w, left: 40.w),
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
                  Visibility(
                      visible: state.pageToType != PageToType.ADJUST,
                      child: Expanded(
                        flex: 1,
                        child: Container(
                            margin: EdgeInsets.only(left: 80.w),
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () =>
                                    controller.showShoppingCarDialog(context),
                                child: Row(
                                    children: [
                                      LoadAssetImage(
                                        'car',
                                        width: 50.w,
                                        height: 50.w,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(bottom: 40.w),
                                        child: Visibility(
                                          visible: state.shoppingCarList
                                                  ?.isNotEmpty ??
                                              false,
                                          child: Container(
                                              padding: EdgeInsets.all(4.w),
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                              ),
                                              constraints: BoxConstraints(
                                                minWidth: 16,
                                                minHeight: 16,
                                              ),
                                              child: Text(
                                                '${state.shoppingCarList?.length ?? 0}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                                textAlign: TextAlign.center,
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                      )),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () => Get.back(result: state.shoppingCarList),
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
                            controller.getTotalAmount() ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28.sp,
                            ),
                          ),
                          Text(
                            '选好了',
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
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget toAddButtonWidget(ProductDTO stockDTO) {
    if (PageToType.BILL == state.pageToType) {
     return LoadAssetImage(
          'add_goods',
          width: 50.w,
          height: 50.w,
        );
    }else{
     return  ElevatedButton(
          onPressed: () => controller.addToAdjust(stockDTO),
       style: ButtonStyle(
         padding: MaterialStateProperty.all(
             EdgeInsets.symmetric(horizontal: 12)),
         backgroundColor:
         MaterialStateProperty.all(Colors.white),
         // 背景色
         shape: MaterialStateProperty.all(
           RoundedRectangleBorder(
             borderRadius:
             BorderRadius.circular(35.0), // 圆角
             side: BorderSide(
               width: 1.0, // 边框宽度
               color: Colours.primary, // 边框颜色
             ),
           ),
         ),
       ),
          child: Text('+ 盘点'),
        );
    }
  }
}
