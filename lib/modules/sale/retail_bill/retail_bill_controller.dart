import 'package:decimal/decimal.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/order_api.dart';
import 'package:ledger/config/api/payment_api.dart';
import 'package:ledger/config/api/product_api.dart';
import 'package:ledger/entity/payment/payment_method_dto.dart';
import 'package:ledger/entity/product/product_classify_list_dto.dart';
import 'package:ledger/entity/product/product_dto.dart';
import 'package:ledger/entity/product/product_shopping_car_dto.dart';
import 'package:ledger/entity/unit/unit_detail_dto.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/enum/sales_channel.dart';
import 'package:ledger/enum/unit_type.dart';
import 'package:ledger/http/base_page_entity.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/util/date_util.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/dialog_widget/add_stock_dialog/multi/add_stock_multi_dialog.dart';
import 'package:ledger/widget/dialog_widget/payment_dialog/payment_dialog.dart';
import 'package:ledger/widget/dialog_widget/product_unit_dialog/product_unit_dialog.dart';
import 'package:ledger/widget/loading.dart';
import 'package:ledger/widget/warning.dart';

import 'retail_bill_state.dart';

class RetailBillController extends GetxController {
  final RetailBillState state = RetailBillState();

  Future<void> initState() async {
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['orderType'] != null) {
      state.orderType = arguments['orderType'];
    }
    initPaymentMethodList();
    pendingOrderNum();
    _queryProductClassifyList();
  }

  Future<void> onRefresh() async {
    state.currentPage = 1;
    _queryData(state.currentPage).then((result) {
      if (result.success) {
        state.productList = result.d?.result;
        state.hasMore = result.d?.hasMore;
        update(['product_classify_list']);
        state.refreshController.finishRefresh();
        state.refreshController.resetFooter();
      } else {
        Toast.show(result.m.toString());
        state.refreshController.finishRefresh();
      }
    });
  }

  Future<BasePageEntity<ProductDTO>> _queryData(int currentPage) async {
    return await Http().networkPage<ProductDTO>(
        Method.post, ProductApi.stockList,
        data: {
          'page': currentPage,
          'invalid': 0,
          'productClassify': state.selectType,
          'searchContent': state.searchContent,
        });
  }

  void searchShoppingCar(String value) {
    state.searchContent = value;
    onRefresh();
  }

  void switchSelectType(int? id) {
    if (null == id) {
      return;
    }
    state.selectType = id;
    onRefresh();
  }

  toProductClassify() {
    Get.toNamed(RouteConfig.productTypeManage)
        ?.then((value) => _queryProductClassifyList());
  }

  //货物分类
  Future<void> _queryProductClassifyList() async {
    await Http()
        .network<ProductClassifyListDTO>(
        Method.post, ProductApi.product_classify_product_list)
        .then((result) {
      if (result.success) {
        state.productClassifyListDTO = result.d!;
        state.productList = result.d!.productList!;
        update(['product_classify_list']);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  Future<void> onLoad() async {
    state.currentPage += 1;
    _queryData(state.currentPage).then((result) {
      if (result.success) {
        state.productList?.addAll(result.d!.result!);
        state.hasMore = result.d?.hasMore;
        update(['product_classify_list']);
        state.refreshController.finishLoad(state.hasMore ?? false
            ? IndicatorResult.success
            : IndicatorResult.noMore);
      } else {
        Toast.show(result.m.toString());
        state.refreshController.finishLoad(IndicatorResult.fail);
      }
    });
  }

  Future<void> addToShoppingCar(ProductDTO productDTO) async {
      if(state.orderType == OrderType.ADD_STOCK){
        var unitDetailDTO = productDTO.unitDetailDTO;
        if (UnitType.SINGLE.value == unitDetailDTO?.unitType) {
          await Get.dialog(AlertDialog(
            title: Text(productDTO.productName ?? ''),
            content: SingleChildScrollView(
              child: AddStockMultiDialog(
                productDTO: productDTO,
                onClick: (result) {
                  state.productAddStockRequest = result;
                  update(['shopping_car_box']);
                  return true;
                },
              ),
            ),
          ));
        } else {
          await Get.dialog(AlertDialog(
            title: Text(
              productDTO.productName ?? '',
            ),
            content: SingleChildScrollView(
              child: AddStockMultiDialog(
                productDTO: productDTO,
                onClick: (result) {
                  state.productAddStockRequest = result;
                  update(['shopping_car_box']);
                  return true;
                },
              ),
            ),
          ));
        }
      }else{
        Get.dialog(AlertDialog(
          title: null, // 设置标题为null，
          content: SingleChildScrollView(
            child: ProductUnitDialog(
              productDTO: productDTO,
              orderType: state.orderType,
              onClick: (result) {
                state.shoppingCarList?.add(result);
                update(['shopping_car_box']);
                return true;
              },
            ),
          ),
        ));
      }
  }

  String getSalesChannel(int? channel) {
    for (var value in SalesChannel.values) {
      if (value.value == channel) {
        return value.desc;
      }
    }
    return '';
  }

  //选择日期
  Future<void> pickerDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        // 设置初始日期
        firstDate: DateTime(2000),
        // 设置日期范围的开始日期
        lastDate: DateTime.now(),
        // 设置日期范围的结束日期
        builder: (BuildContext context, Widget? child) {
          return child!;
        });
    if (picked != null) {
      state.date = picked;
      update(['bill_date']);
    }
  }

  String judgeUnit(ProductDTO? productDTO) {
    if (null == productDTO) {
      return '-';
    }
    if (productDTO.unitDetailDTO?.unitType == UnitType.SINGLE.value) {
      return '${DecimalUtil.formatDecimalNumber(productDTO.unitDetailDTO?.stock)} ${productDTO.unitDetailDTO?.unitName}';
    } else {
      return '${DecimalUtil.formatDecimalNumber(productDTO.unitDetailDTO?.masterStock )} ${productDTO.unitDetailDTO?.masterUnitName} | ${productDTO.unitDetailDTO?.slaveStock ?? '0'} ${productDTO.unitDetailDTO?.slaveUnitName}';
    }
  }

  void toShoppingCarList(){
    if (state.shoppingCarList?.isEmpty??false) {
      Toast.show('请先添加货物');
      return;
    }
    Get.toNamed(RouteConfig.shoppingCarList,arguments: {
      'shoppingCar':state.shoppingCarList,
      'totalAmount':state.totalAmount,
      'totalNumber':0});
  }
  // void showShoppingCarDialog(BuildContext context) {
  //   Get.generalDialog(
  //     barrierDismissible: true,
  //     barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
  //     barrierColor: Colors.black45,
  //     transitionDuration: const Duration(milliseconds: 200),
  //     pageBuilder: (BuildContext buildContext, Animation animation,
  //         Animation secondaryAnimation) {
  //         if (state.orderType == OrderType.REFUND) {//退款
  //           return  Column(
  //             children: [
  //               const Spacer(),
  //               Container(
  //                 decoration: BoxDecoration(
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: Colors.black.withOpacity(0.2),
  //                       offset: Offset(1, 1),
  //                       blurRadius: 3,
  //                     ),
  //                   ],
  //                   borderRadius: BorderRadius.only(
  //                       topLeft: Radius.circular(20.w),
  //                       topRight: Radius.circular(20.w)),
  //                   color: Colors.white,
  //                 ),
  //                 padding: EdgeInsets.only(left: 30.w, right: 30.w),
  //                 child: SingleChildScrollView(
  //                   child: state.shoppingCarList?.isEmpty ?? true
  //                       ? EmptyLayout(hintText: '什么都没有')
  //                       : Column(
  //                     children: [
  //                       GetBuilder<RetailBillController>(
  //                           id: '',
  //                           builder: (_) {
  //                             return Table(
  //                               // 设置表格属性
  //                               border: TableBorder(
  //                                   horizontalInside: BorderSide(
  //                                       width: 1.w, color: Colours.text_ccc),
  //                                   bottom: BorderSide(
  //                                       color: Colours.text_ccc, width: 2.0)),
  //                               children: [
  //                                 TableRow(
  //                                   children: [
  //                                     TableCell(
  //                                         child: Container(
  //                                           padding: EdgeInsets.only(
  //                                             top: 30.w,
  //                                             bottom: 30.w,
  //                                           ),
  //                                         )),
  //                                     TableCell(
  //                                       child: Container(
  //                                           padding: EdgeInsets.symmetric(
  //                                               vertical: 20.0.w),
  //                                           child: Text(
  //                                             '货品',
  //                                             style: TextStyle(
  //                                                 fontSize: 24.sp,
  //                                                 color: Colours.text_999),
  //                                           )),
  //                                     ),
  //                                     TableCell(
  //                                         child: Container(
  //                                             padding: EdgeInsets.symmetric(
  //                                                 vertical: 20.0.w),
  //                                             child: Text(
  //                                               '数量',
  //                                               style: TextStyle(
  //                                                   fontSize: 24.sp,
  //                                                   color: Colours.text_999),
  //                                             ))),
  //                                     TableCell(
  //                                         child: Container(
  //                                             padding: EdgeInsets.symmetric(
  //                                                 vertical: 20.0.w),
  //                                             child: Text(
  //                                               '重量',
  //                                               style: TextStyle(
  //                                                   fontSize: 24.sp,
  //                                                   color: Colours.text_999),
  //                                             ))),
  //                                     TableCell(
  //                                         child: Container(
  //                                             padding: EdgeInsets.symmetric(
  //                                                 vertical: 20.0.w),
  //                                             child: Text(
  //                                               '单价',
  //                                               style: TextStyle(
  //                                                   fontSize: 24.sp,
  //                                                   color: Colours.text_999),
  //                                             ))),
  //                                     TableCell(
  //                                         child: Container(
  //                                             padding: EdgeInsets.symmetric(
  //                                                 vertical: 20.0.w),
  //                                             child: Text(
  //                                               '小计',
  //                                               style: TextStyle(
  //                                                   fontSize: 24.sp,
  //                                                   color: Colours.text_999),
  //                                             ))),
  //                                   ],
  //                                 ),
  //                                 // 根据动态数据创建行
  //                                 for (var item in state.shoppingCarList!)
  //                                   TableRow(
  //                                     children: [
  //                                       TableCell(
  //                                           child: Container(
  //                                             alignment: Alignment.center,
  //                                             padding: EdgeInsets.only(
  //                                               top: 40.w,
  //                                             ),
  //                                             child: InkWell(
  //                                               onTap: () {
  //                                                 state.shoppingCarList
  //                                                     ?.remove(item);
  //                                                 update([
  //                                                   'shopping_car_add_result',
  //                                                   'shopping_car_box'
  //                                                 ]);
  //                                               },
  //                                               child: LoadSvg(
  //                                                 'svg/delete',
  //                                                 width: 40.w,
  //                                                 color: Colours.primary,
  //                                               ),
  //                                             ),
  //                                           )),
  //                                       TableCell(
  //                                           child: Container(
  //                                               padding: EdgeInsets.only(
  //                                                 top: 30.w,
  //                                                 bottom: 30.w,
  //                                               ),
  //                                               child: Text(
  //                                                 item.productName ?? '',
  //                                                 style: TextStyle(
  //                                                     fontSize: 26.sp,
  //                                                     fontWeight:
  //                                                     FontWeight.w600,
  //                                                     color:
  //                                                     Colours.text_333),
  //                                               ))),
  //                                       TableCell(
  //                                           child: Container(
  //                                               padding: EdgeInsets.only(
  //                                                   top: 30.w,
  //                                                   bottom: 30.w,
  //                                                   left: 10.w),
  //                                               child: Text(getNumber(item
  //                                                   .unitDetailDTO!) ??
  //                                                   ''))),
  //                                       TableCell(
  //                                           child: Container(
  //                                               padding: EdgeInsets.only(
  //                                                 top: 30.w,
  //                                                 bottom: 30.w,
  //                                               ),
  //                                               child: Text(getWeight(item
  //                                                   .unitDetailDTO!) ??
  //                                                   ''))),
  //                                       TableCell(
  //                                           child: Container(
  //                                               padding: EdgeInsets.only(
  //                                                 top: 30.w,
  //                                                 bottom: 30.w,
  //                                               ),
  //                                               child: Text(getPrice(item
  //                                                   .unitDetailDTO!) ??
  //                                                   ''))),
  //                                       TableCell(
  //                                           child: Container(
  //                                               padding: EdgeInsets.only(
  //                                                 top: 30.w,
  //                                                 bottom: 30.w,
  //                                               ),
  //                                               child: Text(
  //                                                 DecimalUtil.formatDecimalDefault(
  //                                                     item.unitDetailDTO
  //                                                         ?.totalAmount),
  //                                               ))),
  //                                     ],
  //                                   ),
  //                               ],
  //                             );
  //                           }),
  //                       Row(children: [
  //                         Container(
  //                             padding: EdgeInsets.only(
  //                                 left: 110.0.w, top: 20.w, bottom: 30.w),
  //                             child: Text(
  //                               '总计',
  //                               style: TextStyle(
  //                                   fontSize: 28.sp,
  //                                   fontWeight: FontWeight.w600,
  //                                   color: Colours.primary),
  //                             )),
  //                         const Spacer(),
  //                         Container(
  //                             padding: EdgeInsets.only(
  //                                 left: 20.0.w,
  //                                 right: 100.w,
  //                                 top: 20.w,
  //                                 bottom: 30.w),
  //                             child: Text(
  //                               '${getTotalAmount()}',
  //                               style: TextStyle(
  //                                   fontSize: 28.sp,
  //                                   fontWeight: FontWeight.w600,
  //                                   color: Colours.primary),
  //                             ))
  //                       ]),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               GetBuilder<RetailBillController>(
  //                 id: 'shopping_car_bottom_total',
  //                 builder: (_) {
  //                   return Container(
  //                     padding: EdgeInsets.only(right: 40.w, left: 40.w),
  //                     decoration: BoxDecoration(
  //                       boxShadow: [
  //                         BoxShadow(
  //                           color: Colors.black.withOpacity(0.2),
  //                           offset: Offset(1, 1),
  //                           blurRadius: 3,
  //                         ),
  //                       ],
  //                       //borderRadius: BorderRadius.circular(20.0),
  //                       color: Colors.white,
  //                     ),
  //                     height: 120.w,
  //                     child: Flex(
  //                       direction: Axis.horizontal,
  //                       children: [
  //                         Expanded(
  //                           flex: 5,
  //                           child: Padding(
  //                             padding: EdgeInsets.only(left: 10.w),
  //                             child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                               children: [
  //                                 Stack(
  //                                   children: [
  //                                     LoadAssetImage(
  //                                       'car',
  //                                       width: 45.w,
  //                                       height: 45.w,
  //                                     ),
  //                                     Visibility(
  //                                       visible:
  //                                       state.shoppingCarList?.isNotEmpty ??
  //                                           false,
  //                                       child: Positioned(
  //                                         top: 0,
  //                                         right: 0,
  //                                         child: Container(
  //                                             padding: EdgeInsets.all(4.w),
  //                                             decoration: BoxDecoration(
  //                                               color: Colors.red,
  //                                               shape: BoxShape.circle,
  //                                             ),
  //                                             constraints: BoxConstraints(
  //                                               minWidth: 16,
  //                                               minHeight: 16,
  //                                             ),
  //                                             child: Text(
  //                                               '${state.shoppingCarList?.length ?? 0}',
  //                                               style: TextStyle(
  //                                                 color: Colors.white,
  //                                                 fontSize: 12,
  //                                               ),
  //                                               textAlign: TextAlign.center,
  //                                             )),
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                         Expanded(
  //                           flex: 4,
  //                           child: ElevatedButton(
  //                             onPressed: () =>
  //                                 Get.back(result: state.shoppingCarList),
  //                             style: ButtonStyle(
  //                               maximumSize: MaterialStateProperty.all(
  //                                   Size(double.infinity, 60)),
  //                               backgroundColor:
  //                               MaterialStateProperty.all(Colours.primary),
  //                               shape: MaterialStateProperty.all(
  //                                   RoundedRectangleBorder(
  //                                     borderRadius: BorderRadius.circular(15.0),
  //                                   )),
  //                             ),
  //                             child: Column(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: [
  //                                 Text(
  //                                   '${getTotalAmount()}元',
  //                                   style: TextStyle(
  //                                     color: Colors.white,
  //                                     fontSize: 28.sp,
  //                                   ),
  //                                 ),
  //                                 Text(
  //                                   '确定',
  //                                   style: TextStyle(
  //                                     color: Colors.white,
  //                                     fontSize: 28.sp,
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   );
  //                 },
  //               )
  //             ],
  //           );
  //         } else {//开单
  //           return
  //             Column(
  //               children: [
  //                 const Spacer(),
  //                 Container(
  //                   decoration: BoxDecoration(
  //                     boxShadow: [
  //                       BoxShadow(
  //                         color: Colors.black.withOpacity(0.2),
  //                         offset: Offset(1, 1),
  //                         blurRadius: 3,
  //                       ),
  //                     ],
  //                     borderRadius: BorderRadius.only(
  //                         topLeft: Radius.circular(20.w),
  //                         topRight: Radius.circular(20.w)),
  //                     color: Colors.white,
  //                   ),
  //                   padding: EdgeInsets.only(left: 30.w, right: 30.w),
  //                   child: SingleChildScrollView(
  //                     child: state.shoppingCarList?.isEmpty ?? true
  //                         ? EmptyLayout(hintText: '什么都没有')
  //                         : Column(
  //                       children: [
  //                         GetBuilder<RetailBillController>(
  //                             id: '',
  //                             builder: (_) {
  //                               return Table(
  //                                 // 设置表格属性
  //                                 border: TableBorder(
  //                                     horizontalInside: BorderSide(
  //                                         width: 1.w, color: Colours.text_ccc),
  //                                     bottom: BorderSide(
  //                                         color: Colours.text_ccc, width: 2.0)),
  //                                 children: [
  //                                   TableRow(
  //                                     children: [
  //                                       TableCell(
  //                                           child: Container(
  //                                             padding: EdgeInsets.only(
  //                                               top: 30.w,
  //                                               bottom: 30.w,
  //                                             ),
  //                                           )),
  //                                       TableCell(
  //                                         child: Container(
  //                                             padding: EdgeInsets.symmetric(
  //                                                 vertical: 20.0.w),
  //                                             child: Text(
  //                                               '货品',
  //                                               style: TextStyle(
  //                                                   fontSize: 24.sp,
  //                                                   color: Colours.text_999),
  //                                             )),
  //                                       ),
  //                                       TableCell(
  //                                           child: Container(
  //                                               padding: EdgeInsets.symmetric(
  //                                                   vertical: 20.0.w),
  //                                               child: Text(
  //                                                 '数量',
  //                                                 style: TextStyle(
  //                                                     fontSize: 24.sp,
  //                                                     color: Colours.text_999),
  //                                               ))),
  //                                       TableCell(
  //                                           child: Container(
  //                                               padding: EdgeInsets.symmetric(
  //                                                   vertical: 20.0.w),
  //                                               child: Text(
  //                                                 '重量',
  //                                                 style: TextStyle(
  //                                                     fontSize: 24.sp,
  //                                                     color: Colours.text_999),
  //                                               ))),
  //                                       TableCell(
  //                                           child: Container(
  //                                               padding: EdgeInsets.symmetric(
  //                                                   vertical: 20.0.w),
  //                                               child: Text(
  //                                                 '单价',
  //                                                 style: TextStyle(
  //                                                     fontSize: 24.sp,
  //                                                     color: Colours.text_999),
  //                                               ))),
  //                                       TableCell(
  //                                           child: Container(
  //                                               padding: EdgeInsets.symmetric(
  //                                                   vertical: 20.0.w),
  //                                               child: Text(
  //                                                 '小计',
  //                                                 style: TextStyle(
  //                                                     fontSize: 24.sp,
  //                                                     color: Colours.text_999),
  //                                               ))),
  //                                     ],
  //                                   ),
  //                                   // 根据动态数据创建行
  //                                   for (var item in state.shoppingCarList!)
  //                                     TableRow(
  //                                       children: [
  //                                         TableCell(
  //                                             child: Container(
  //                                               alignment: Alignment.center,
  //                                               padding: EdgeInsets.only(
  //                                                 top: 40.w,
  //                                               ),
  //                                               child: InkWell(
  //                                                 onTap: () {
  //                                                   state.shoppingCarList
  //                                                       ?.remove(item);
  //                                                   update([
  //                                                     'shopping_car_add_result',
  //                                                     'shopping_car_box'
  //                                                   ]);
  //                                                 },
  //                                                 child: LoadSvg(
  //                                                   'svg/delete',
  //                                                   width: 40.w,
  //                                                   color: Colours.primary,
  //                                                 ),
  //                                               ),
  //                                             )),
  //                                         TableCell(
  //                                             child: Container(
  //                                                 padding: EdgeInsets.only(
  //                                                   top: 30.w,
  //                                                   bottom: 30.w,
  //                                                 ),
  //                                                 child: Text(
  //                                                   item.productName ?? '',
  //                                                   style: TextStyle(
  //                                                       fontSize: 26.sp,
  //                                                       fontWeight:
  //                                                       FontWeight.w600,
  //                                                       color:
  //                                                       Colours.text_333),
  //                                                 ))),
  //                                         TableCell(
  //                                             child: Container(
  //                                                 padding: EdgeInsets.only(
  //                                                     top: 30.w,
  //                                                     bottom: 30.w,
  //                                                     left: 10.w),
  //                                                 child: Text(getNumber(item
  //                                                     .unitDetailDTO!) ??
  //                                                     ''))),
  //                                         TableCell(
  //                                             child: Container(
  //                                                 padding: EdgeInsets.only(
  //                                                   top: 30.w,
  //                                                   bottom: 30.w,
  //                                                 ),
  //                                                 child: Text(getWeight(item
  //                                                     .unitDetailDTO!) ??
  //                                                     ''))),
  //                                         TableCell(
  //                                             child: Container(
  //                                                 padding: EdgeInsets.only(
  //                                                   top: 30.w,
  //                                                   bottom: 30.w,
  //                                                 ),
  //                                                 child: Text(getPrice(item
  //                                                     .unitDetailDTO!) ??
  //                                                     ''))),
  //                                         TableCell(
  //                                             child: Container(
  //                                                 padding: EdgeInsets.only(
  //                                                   top: 30.w,
  //                                                   bottom: 30.w,
  //                                                 ),
  //                                                 child: Text(
  //                                                   DecimalUtil.formatDecimalDefault(
  //                                                       item.unitDetailDTO
  //                                                           ?.totalAmount),
  //                                                 ))),
  //                                       ],
  //                                     ),
  //                                 ],
  //                               );
  //                             }),
  //                         Row(children: [
  //                           Container(
  //                               padding: EdgeInsets.only(
  //                                   left: 110.0.w, top: 20.w, bottom: 30.w),
  //                               child: Text(
  //                                 '总计',
  //                                 style: TextStyle(
  //                                     fontSize: 28.sp,
  //                                     fontWeight: FontWeight.w600,
  //                                     color: Colours.primary),
  //                               )),
  //                           const Spacer(),
  //                           Container(
  //                               padding: EdgeInsets.only(
  //                                   left: 20.0.w,
  //                                   right: 100.w,
  //                                   top: 20.w,
  //                                   bottom: 30.w),
  //                               child: Text(
  //                                 '${getTotalAmount()}',
  //                                 style: TextStyle(
  //                                     fontSize: 28.sp,
  //                                     fontWeight: FontWeight.w600,
  //                                     color: Colours.primary),
  //                               ))
  //                         ]),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //                 GetBuilder<RetailBillController>(
  //                   id: 'shopping_car_bottom_total',
  //                   builder: (_) {
  //                     return Container(
  //                       padding: EdgeInsets.only(right: 40.w, left: 40.w),
  //                       decoration: BoxDecoration(
  //                         boxShadow: [
  //                           BoxShadow(
  //                             color: Colors.black.withOpacity(0.2),
  //                             offset: Offset(1, 1),
  //                             blurRadius: 3,
  //                           ),
  //                         ],
  //                         //borderRadius: BorderRadius.circular(20.0),
  //                         color: Colors.white,
  //                       ),
  //                       height: 120.w,
  //                       child: Flex(
  //                         direction: Axis.horizontal,
  //                         children: [
  //                           Expanded(
  //                             flex: 5,
  //                             child: Padding(
  //                               padding: EdgeInsets.only(left: 10.w),
  //                               child: Row(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                                 children: [
  //                                   Stack(
  //                                     children: [
  //                                       LoadAssetImage(
  //                                         'car',
  //                                         width: 45.w,
  //                                         height: 45.w,
  //                                       ),
  //                                       Visibility(
  //                                         visible:
  //                                         state.shoppingCarList?.isNotEmpty ??
  //                                             false,
  //                                         child: Positioned(
  //                                           top: 0,
  //                                           right: 0,
  //                                           child: Container(
  //                                               padding: EdgeInsets.all(4.w),
  //                                               decoration: BoxDecoration(
  //                                                 color: Colors.red,
  //                                                 shape: BoxShape.circle,
  //                                               ),
  //                                               constraints: BoxConstraints(
  //                                                 minWidth: 16,
  //                                                 minHeight: 16,
  //                                               ),
  //                                               child: Text(
  //                                                 '${state.shoppingCarList?.length ?? 0}',
  //                                                 style: TextStyle(
  //                                                   color: Colors.white,
  //                                                   fontSize: 12,
  //                                                 ),
  //                                                 textAlign: TextAlign.center,
  //                                               )),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                           Expanded(
  //                             flex: 4,
  //                             child: ElevatedButton(
  //                               onPressed: () =>
  //                                   Get.back(result: state.shoppingCarList),
  //                               style: ButtonStyle(
  //                                 maximumSize: MaterialStateProperty.all(
  //                                     Size(double.infinity, 60)),
  //                                 backgroundColor:
  //                                 MaterialStateProperty.all(Colours.primary),
  //                                 shape: MaterialStateProperty.all(
  //                                     RoundedRectangleBorder(
  //                                       borderRadius: BorderRadius.circular(15.0),
  //                                     )),
  //                               ),
  //                               child: Column(
  //                                 mainAxisAlignment: MainAxisAlignment.center,
  //                                 children: [
  //                                   Text(
  //                                     '${getTotalAmount()}元',
  //                                     style: TextStyle(
  //                                       color: Colors.white,
  //                                       fontSize: 28.sp,
  //                                     ),
  //                                   ),
  //                                   Text(
  //                                     '确定',
  //                                     style: TextStyle(
  //                                       color: Colors.white,
  //                                       fontSize: 28.sp,
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     );
  //                   },
  //                 )
  //               ],
  //             );
  //         }
  //     },
  //   );
  // }

  String? getNumber(UnitDetailDTO unitDetailDTO) {
    var unitType = unitDetailDTO.unitType;
    if (UnitType.SINGLE.value == unitType) {
      return '${unitDetailDTO.number} ${unitDetailDTO.unitName}';
    } else {
      if (unitDetailDTO.selectMasterUnit ?? true) {
        if (UnitType.MULTI_WEIGHT.value == unitType) {
          return '${unitDetailDTO.slaveNumber} ${unitDetailDTO.slaveUnitName}';
        }
        return '${unitDetailDTO.masterNumber} ${unitDetailDTO.masterUnitName}';
      } else {
        return '${unitDetailDTO.slaveNumber} ${unitDetailDTO.slaveUnitName}';
      }
    }
  }

  String? getPrice(UnitDetailDTO unitDetailDTO) {
    var unitType = unitDetailDTO.unitType;
    if (UnitType.SINGLE.value == unitType) {
      if(unitDetailDTO.price ==null){
        return '';
      }else{
        return '${unitDetailDTO.price}元/${unitDetailDTO.unitName}';
      }
    } else {
      if (unitDetailDTO.selectMasterUnit ?? true) {
        if(unitDetailDTO.masterPrice==null){
          return'';
        }else{
          return '${unitDetailDTO.masterPrice}元/${unitDetailDTO.masterUnitName}';
        }
      } else {
        if(unitDetailDTO.slavePrice==null){
          return'';
        }else{
          return '${unitDetailDTO.slavePrice}元/${unitDetailDTO.slaveUnitName}';
        }
      }
    }
  }

  String? getWeight(UnitDetailDTO unitDetailDTO) {
    var unitType = unitDetailDTO.unitType;
    if (UnitType.MULTI_WEIGHT.value == unitType) {
      if (unitDetailDTO.selectMasterUnit ?? true) {
        return '${unitDetailDTO.masterNumber} ${unitDetailDTO.masterUnitName}';
      }
    }
    return '-';
  }

  String? getTotalAmount() {
    var totalAmount = Decimal.zero;
    state.shoppingCarList?.forEach((element) {
      totalAmount = totalAmount + element.unitDetailDTO!.totalAmount!;
    });
    state.totalAmount = totalAmount;
    return DecimalUtil.formatDecimalDefault(totalAmount);
  }


  Future<void> pickerCustom() async {
    var result = await Get.toNamed(RouteConfig.customRecord, arguments: {
      'initialIndex': (state.orderType == OrderType.SALE) ||
          (state.orderType == OrderType.SALE_RETURN)
          ? 0
          : 1,
      'isSelectCustom': true,
      'orderType': state.orderType
    });
    state.customDTO = result;
    update(['retail_bill_sale_custom']);
  }

  //挂单
  Future<bool> pendingOrder() async {
    if (state.shoppingCarList?.isEmpty??false) {
      Toast.show('开单商品不能为空');
      return Future(() => false);
    }
    Loading.showDuration();
    return await Http().network(Method.post, OrderApi.add_pending_order, data: {
      'customId': state.customDTO?.id,
      'orderProductRequest': state.shoppingCarList,
     // 'remark': state.remarkTextEditingController.text,  ToDO
      'orderDate': DateUtil.formatDefaultDate(state.date),
      'orderType': state.orderType?.value,
    }).then((result) {
      Loading.dismiss();
      if (result.success) {
        Toast.show('挂单成功');
        state.totalAmount  =Decimal.zero;
        state.date = DateTime.now();
        state.shoppingCarList =  [];
        state.customDTO = null;
       // state.remarkTextEditingController.text = '';  ToDO
        pendingOrderNum();
        update(['bill_custom','bill_date','sale_bill_product_title','sale_bill_product_list','sale_bill_btn']);//需要更新下挂单列表按钮颜色和数字
        return true;
      } else {
        Toast.show(result.m.toString());
        return false;
      }
    });
  }

  //拉取挂单 的数量
  void pendingOrderNum() {
    Http().network<int>(Method.post, OrderApi.pending_order_count).then((result) {
      if (result.success) {
        state.pendingOrderNum = result.d;
        update(['sale_bill_pending_order']);
      }
    });
  }

  void toDeleteOrder(ProductShoppingCarDTO productShoppingCarDTO) {
    Get.dialog(
      Warning(
          cancel: '取消',
          confirm: '确定',
          content: '确认删除此条吗？',
          onCancel: () {},
          onConfirm: () {
            state.shoppingCarList?.remove(productShoppingCarDTO);
            if (state.shoppingCarList?.isEmpty??false) {
              state.totalAmount = Decimal.zero;
            } else {
              state.totalAmount = state.shoppingCarList
                  !.map((e) => (e.unitDetailDTO?.totalAmount ?? Decimal.zero))
                  .reduce((value, element) => value + element);
            }
            update(['sale_bill_product_list', 'sale_bill_btn']);
            Toast.show('删除成功');
          }),
    );
  }
//拉支付方式
  void initPaymentMethodList() {
    Http().network<List<PaymentMethodDTO>>(Method.get, PaymentApi.LEDGER_PAYMENT_METHOD_LIST)
        .then((result) {
      if (result.success) {
        state.paymentMethods = result.d!;
      } else {
        Toast.show('网络异常');
      }
    });
  }

  //选择客户
  String customName() {
    if (state.orderType == OrderType.SALE) {
      return state.customDTO?.customName ?? '选择客户';
    } else{
      return state.customDTO?.customName ?? '请选择';
    }
  }
  //Dialog
  void showPaymentDialog(BuildContext context) {
    if (state.shoppingCarList?.isEmpty??false) {
      Toast.show('请添加货物后再试');
      return;
    }
    if (state.orderType == OrderType.SALE_RETURN) {//判断方式可能需要改 TODO
      if (state.customDTO == null) {
        Toast.show('请选择客户' );
        return;
      }
    }
      Get.bottomSheet(
          isScrollControlled: true,
          PaymentDialog(
              paymentMethods: state.paymentMethods!,
              customDTO: state.customDTO,
              orderType: state.orderType,
              totalAmount: state.totalAmount,
              onClick: (result) async {
                state.orderPayDialogResult = result;
                if (null != result?.customDTO) {
                  state.customDTO = result?.customDTO;
                }
                return await saveOrder();
              }),
          backgroundColor: Colors.white);
  }

  Future<bool> saveOrder() async {
    Loading.showDuration();
    return await Http().network(Method.post, OrderApi.add_order_page, data: {
      'customId': state.customDTO?.id,
      'creditAmount': state.orderPayDialogResult?.creditAmount,
      'discountAmount': state.orderPayDialogResult?.discountAmount,
      'orderProductRequest': state.shoppingCarList,
      'orderPaymentRequest': state.orderPayDialogResult?.orderPaymentRequest,
      //'remark': state.remarkTextEditingController.text,  ToDO
      'orderDate': DateUtil.formatDefaultDate(state.date),
      'orderType': state.orderType.value,
    }).then((result) {
      Loading.dismiss();
      if (result.success) {
        Get.offNamed(RouteConfig.saleRecord, arguments: {'orderType': state.orderType});
        return true;
      } else {
        Toast.show(result.m.toString());
        return false;
      }
    });
  }

}
