import 'package:decimal/decimal.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/product_api.dart';
import 'package:ledger/entity/product/product_classify_list_dto.dart';
import 'package:ledger/entity/product/product_dto.dart';
import 'package:ledger/entity/unit/unit_detail_dto.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/enum/page_to_type.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/enum/sales_channel.dart';
import 'package:ledger/enum/unit_type.dart';
import 'package:ledger/http/base_page_entity.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/dialog_widget/add_stock_dialog/add_stock_dialog.dart';
import 'package:ledger/widget/dialog_widget/product_unit_dialog/product_unit_dialog.dart';
import 'package:ledger/widget/dialog_widget/stock_change/multi/stock_change_multi_dialog.dart';
import 'package:ledger/widget/dialog_widget/stock_change/single/stock_change_single_dialog.dart';
import 'package:ledger/widget/empty_layout.dart';
import 'package:ledger/widget/image.dart';

import 'shopping_car_state.dart';

class ShoppingCarController extends GetxController {
  final GlobalKey componentKey = GlobalKey();
  final ShoppingCarState state = ShoppingCarState();

  Future<void> initState() async {
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['pageType'] != null) {
      state.pageToType = arguments['pageType'];
    }
    if ((arguments != null) && arguments['orderType'] != null) {
      state.orderType = arguments['orderType'];
    }
    _queryProductClassifyList();
  }

  String getSalesChannel(int? channel) {
    for (var value in SalesChannel.values) {
      if (value.value == channel) {
        return value.desc;
      }
    }
    return '';
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

  void showShoppingCarDialog(BuildContext context) {
    Get.generalDialog(
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Column(
          children: [
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(1, 1),
                    blurRadius: 3,
                  ),
                ],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.w),
                    topRight: Radius.circular(20.w)),
                color: Colors.white,
              ),
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              child: SingleChildScrollView(
                child: state.shoppingCarList?.isEmpty ?? true
                    ? EmptyLayout(hintText: '什么都没有')
                    : Column(
                        children: [
                          GetBuilder<ShoppingCarController>(
                              id: 'shopping_car_add_result',
                              builder: (_) {
                                return Table(
                                  // 设置表格属性
                                  border: TableBorder(
                                      horizontalInside: BorderSide(
                                          width: 1.w, color: Colours.text_ccc),
                                      bottom: BorderSide(
                                          color: Colours.text_ccc, width: 2.0)),
                                  children: [
                                    TableRow(
                                      children: [
                                        TableCell(
                                            child: Container(
                                          padding: EdgeInsets.only(
                                            top: 30.w,
                                            bottom: 30.w,
                                          ),
                                        )),
                                        TableCell(
                                          child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 20.0.w),
                                              child: Text(
                                                '货品',
                                                style: TextStyle(
                                                    fontSize: 24.sp,
                                                    color: Colours.text_999),
                                              )),
                                        ),
                                        TableCell(
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 20.0.w),
                                                child: Text(
                                                  '数量',
                                                  style: TextStyle(
                                                      fontSize: 24.sp,
                                                      color: Colours.text_999),
                                                ))),
                                        TableCell(
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 20.0.w),
                                                child: Text(
                                                  '重量',
                                                  style: TextStyle(
                                                      fontSize: 24.sp,
                                                      color: Colours.text_999),
                                                ))),
                                        TableCell(
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 20.0.w),
                                                child: Text(
                                                  '单价',
                                                  style: TextStyle(
                                                      fontSize: 24.sp,
                                                      color: Colours.text_999),
                                                ))),
                                        TableCell(
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 20.0.w),
                                                child: Text(
                                                  '小计',
                                                  style: TextStyle(
                                                      fontSize: 24.sp,
                                                      color: Colours.text_999),
                                                ))),
                                      ],
                                    ),
                                    // 根据动态数据创建行
                                    for (var item in state.shoppingCarList!)
                                      TableRow(
                                        children: [
                                          TableCell(
                                              child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.only(
                                              top: 40.w,
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                state.shoppingCarList
                                                    ?.remove(item);
                                                update([
                                                  'shopping_car_add_result',
                                                  'shopping_car_box'
                                                ]);
                                              },
                                              child: LoadSvg(
                                                'svg/delete',
                                                width: 40.w,
                                                color: Colours.primary,
                                              ),
                                            ),
                                          )),
                                          TableCell(
                                              child: Container(
                                                  padding: EdgeInsets.only(
                                                    top: 30.w,
                                                    bottom: 30.w,
                                                  ),
                                                  child: Text(
                                                    item.productName ?? '',
                                                    style: TextStyle(
                                                        fontSize: 26.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Colours.text_333),
                                                  ))),
                                          TableCell(
                                              child: Container(
                                                  padding: EdgeInsets.only(
                                                      top: 30.w,
                                                      bottom: 30.w,
                                                      left: 10.w),
                                                  child: Text(getNumber(item
                                                          .unitDetailDTO!) ??
                                                      ''))),
                                          TableCell(
                                              child: Container(
                                                  padding: EdgeInsets.only(
                                                    top: 30.w,
                                                    bottom: 30.w,
                                                  ),
                                                  child: Text(getWeight(item
                                                          .unitDetailDTO!) ??
                                                      ''))),
                                          TableCell(
                                              child: Container(
                                                  padding: EdgeInsets.only(
                                                    top: 30.w,
                                                    bottom: 30.w,
                                                  ),
                                                  child: Text(getPrice(item
                                                          .unitDetailDTO!) ??
                                                      ''))),
                                          TableCell(
                                              child: Container(
                                                  padding: EdgeInsets.only(
                                                    top: 30.w,
                                                    bottom: 30.w,
                                                  ),
                                                  child: Text(
                                                    DecimalUtil.formatDecimalDefault(
                                                        item.unitDetailDTO
                                                            ?.totalAmount),
                                                  ))),
                                        ],
                                      ),
                                  ],
                                );
                              }),
                          Row(children: [
                            Container(
                                padding: EdgeInsets.only(
                                    left: 110.0.w, top: 20.w, bottom: 30.w),
                                child: Text(
                                  '总计',
                                  style: TextStyle(
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colours.primary),
                                )),
                            const Spacer(),
                            Container(
                                padding: EdgeInsets.only(
                                    left: 20.0.w,
                                    right: 100.w,
                                    top: 20.w,
                                    bottom: 30.w),
                                child: Text(
                                  '${getTotalAmount()}',
                                  style: TextStyle(
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colours.primary),
                                ))
                          ]),
                        ],
                      ),
              ),
            ),
            GetBuilder<ShoppingCarController>(
              id: 'shopping_car_bottom_total',
              builder: (_) {
                return Container(
                  padding: EdgeInsets.only(right: 40.w, left: 40.w),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(1, 1),
                        blurRadius: 3,
                      ),
                    ],
                    //borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  height: 120.w,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Stack(
                                children: [
                                  LoadAssetImage(
                                    'car',
                                    width: 45.w,
                                    height: 45.w,
                                  ),
                                  Visibility(
                                    visible:
                                        state.shoppingCarList?.isNotEmpty ??
                                            false,
                                    child: Positioned(
                                      top: 0,
                                      right: 0,
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
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: ElevatedButton(
                          onPressed: () =>
                              Get.back(result: state.shoppingCarList),
                          style: ButtonStyle(
                            maximumSize: MaterialStateProperty.all(
                                Size(double.infinity, 60)),
                            backgroundColor:
                                MaterialStateProperty.all(Colours.primary),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            )),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${getTotalAmount()}元',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28.sp,
                                ),
                              ),
                              Text(
                                '确定',
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
              },
            )
          ],
        );
      },
    );
  }

  String? getTotalAmount() {
    var totalAmount = Decimal.zero;
    state.shoppingCarList?.forEach((element) {
      totalAmount = totalAmount + element.unitDetailDTO!.totalAmount!;
    });
    return DecimalUtil.formatDecimalDefault(totalAmount);
  }

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
      return '${unitDetailDTO.price}元/${unitDetailDTO.unitName}';
    } else {
      if (unitDetailDTO.selectMasterUnit ?? true) {
        return '${unitDetailDTO.masterPrice}元/${unitDetailDTO.masterUnitName}';
      } else {
        return '${unitDetailDTO.slavePrice}元/${unitDetailDTO.slaveUnitName}';
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

  Future<void> addToShoppingCar(ProductDTO productDTO) async {
    if(PageToType.BILL == state.pageToType){
      if(state.orderType == OrderType.ADD_STOCK){
        Get.dialog(AlertDialog(
          title: null, // 设置标题为null，
          content: SingleChildScrollView(
            child: AddStockDialog(
              productDTO: productDTO,
              onClick: (result) {
                state.addStockCarList?.add(result);
                update(['shopping_car_box']);
                return true;
              },
            ),
          ),
        ));
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
  }

  Future<void> addToAdjust(ProductDTO productDTO) async {
    var unitDetailDTO = productDTO.unitDetailDTO;
    if (UnitType.SINGLE.value == unitDetailDTO?.unitType) {
      await Get.dialog(AlertDialog(
        title: Text(productDTO.productName ?? ''),
        content: SingleChildScrollView(
          child: StockChangeSingleDialog(
            productDTO: productDTO,
            onClick: (result) {
              state.productStockAdjustRequest = result;
              return true;
            },
          ),
        ),
      )).then((value) {
        if (ProcessStatus.OK == value) {
          Get.back(result: state.productStockAdjustRequest);
        }
      });
    } else {
      await Get.dialog(AlertDialog(
        title: Text(
          productDTO.productName ?? '',
        ),
        content: SingleChildScrollView(
          child: StockChangeMultiDialog(
            productDTO: productDTO,
            onClick: (result) {
              state.productStockAdjustRequest = result;
              return true;
            },
          ),
        ),
      )).then((value) {
        if (ProcessStatus.OK == value) {
          Get.back(result: state.productStockAdjustRequest);
        }
      });
    }
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

  void addProduct() {
    Get.toNamed(RouteConfig.addProduct)?.then((result) {
      if (ProcessStatus.OK == result) {
        onRefresh();
      }
    });
  }

  void searchShoppingCar(String value) {
    state.searchContent = value;
    onRefresh();
  }

  //货物分类
  Future<void> _queryProductClassifyList() async {
    await Http()
        .network<ProductClassifyListDTO>(
            Method.post, ProductApi.product_classify_manage)
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
}
