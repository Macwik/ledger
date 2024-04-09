import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/entity/product/product_classify_dto.dart';
import 'package:ledger/entity/product/product_dto.dart';
import 'package:ledger/enum/stock_list_type.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/image_util.dart';
import 'package:ledger/widget/permission/permission_widget.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'stock_list_controller.dart';

class StockListView extends StatelessWidget {
  StockListView({super.key});

  final controller = Get.find<StockListController>();

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      appBar: TitleBar(
        title: '货物列表'.tr,
        actionWidget: PermissionWidget(
            permissionCode: PermissionCode.stock_list_add_product_permission,
            child: InkWell(
                onTap: () {
                  controller.toAddProduct();
                },
                child: Container(
                    margin: EdgeInsets.only(right: 32.w),
                    child: Icon(
                      Icons.add,
                      color: Colours.primary,
                    )))),
      ),
      endDrawer: Drawer(
        width: ScreenUtil().screenWidth * 0.8,
        backgroundColor: Colours.bg,
        child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 100.w, left: 20.w, right: 20.w),
            child: Stack(children: [
              GetBuilder<StockListController>(
                  id: 'switch',
                  init: controller,
                  global: false,
                  builder: (_) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: IconButton(
                                      onPressed: () => Get.back(),
                                      icon: Icon(
                                        Icons.close_sharp,
                                        size: 40.w,
                                      )),
                                )),
                            Text(
                              '筛选',
                              style: TextStyle(
                                color: Colours.text_333,
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Expanded(flex: 1, child: Container())
                          ],
                        ),
                        SizedBox(
                          height: 40.w,
                        ),
                        Text(
                          '不启用是否显示',
                          style: TextStyle(
                            color: Colours.text_333,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              controller.state.invalid == null ? '全部' : '启用',
                              style: TextStyle(color: Colours.text_999),
                            ),
                            Switch(
                                trackOutlineColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return Colours.primary; // 设置轨道边框颜色
                                  }
                                  return Colors.grey; // 默认的轨道边框颜色
                                }),
                                inactiveThumbColor: Colors.grey[300],
                                value: controller.state.invalid == null,
                                onChanged: (value) {
                                  controller.state.invalid = value ? null : 0;
                                  controller.update(['switch']);
                                })
                          ],
                        )
                      ],
                    );
                  }),
              Positioned(
                bottom: 100.w,
                right: 20.w,
                left: 20.w,
                child: GetBuilder<StockListController>(
                    id: 'screen_btn',
                    init: controller,
                    global: false,
                    builder: (logic) {
                      return Row(
                        children: [
                          Expanded(
                            child: ElevatedBtn(
                              elevation: 2,
                              margin: EdgeInsets.only(top: 80.w),
                              size: Size(double.infinity, 90.w),
                              onPressed: () => controller.clearCondition(),
                              radius: 15.w,
                              backgroundColor: Colors.white,
                              text: '重置',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            child: ElevatedBtn(
                              elevation: 2,
                              margin: EdgeInsets.only(top: 80.w),
                              size: Size(double.infinity, 90.w),
                              onPressed: () => controller.confirmCondition(),
                              radius: 15.w,
                              backgroundColor: Colours.primary,
                              text: '确定',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      );
                    }),
              )
            ])),
      ),
      body: VisibilityDetector(
          key: Key('StockListVisibilityKey'),
          onVisibilityChanged: (VisibilityInfo visibilityInfo) {
            if (visibilityInfo.visibleFraction > 0.2) {
              controller.onRefresh();
            }
          },
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        height: 100.w,
                        padding:
                            EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w),
                        child: SearchBar(
                            leading: Icon(
                              Icons.search,
                              color: Colors.grey,
                              size: 40.w,
                            ),
                            shadowColor:
                                MaterialStatePropertyAll<Color>(Colors.black26),
                            hintStyle: MaterialStatePropertyAll<TextStyle>(
                                TextStyle(
                                    fontSize: 34.sp, color: Colors.black26)),
                            onChanged: (value) {
                              controller.searchStockList(value);
                            },
                            hintText: '请输入货物或供应商名称')),
                  ),
                  Builder(
                    builder: (context) => GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          LoadAssetImage(
                            'screen',
                            format: ImageFormat.png,
                            color: Colours.text_999,
                            height: 40.w,
                            width: 40.w,
                          ), // 导入的图像
                          SizedBox(width: 8.w), // 图像和文字之间的间距
                          Text(
                            '筛选',
                            style: TextStyle(
                                fontSize: 30.sp, color: Colours.text_666),
                          ),
                          SizedBox(
                            width: 24.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.w,
              ),
              Expanded(
                child: GetBuilder<StockListController>(
                    id: 'product_classify_list',
                    init: controller,
                    global: false,
                    builder: (_) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Expanded(
                                    child: Container(
                                  color: Colors.white30,
                                  child: controller.state.productClassifyListDTO
                                              ?.productClassifyList ==
                                          null
                                      ? LottieIndicator()
                                      : controller.state.productClassifyListDTO!
                                              .productClassifyList!.isEmpty
                                          ? EmptyLayout(hintText: '什么都没有')
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              padding: EdgeInsets.only(top: 0),
                                              controller: controller
                                                  .state.menuController,
                                              itemCount: controller
                                                      .state
                                                      .productClassifyListDTO
                                                      ?.productClassifyList
                                                      ?.length ??
                                                  0,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                ProductClassifyDTO classifyDTO =
                                                    controller
                                                        .state
                                                        .productClassifyListDTO!
                                                        .productClassifyList![index];
                                                return GestureDetector(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: controller
                                                        .state.menuItemHeight,
                                                    decoration: BoxDecoration(
                                                      color: controller.state
                                                                  .selectType ==
                                                              classifyDTO.id
                                                          ? Colors.white
                                                          : Colours.bg,
                                                      border: Border(
                                                        left: BorderSide(
                                                            width: 3,
                                                            color: controller
                                                                        .state
                                                                        .selectType ==
                                                                    classifyDTO
                                                                        .id
                                                                ? Colours
                                                                    .primary
                                                                : Colors.white),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      //左侧菜单
                                                      classifyDTO
                                                              .productClassify ??
                                                          '',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: controller.state
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
                                    child: IconButton(
                                      onPressed: () =>
                                          controller.toProductClassify(),
                                      icon: Icon(Icons.settings,
                                          size: 50.w, color: Colours.text_999),
                                    )),
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 7,
                              child: Container(
                                color: Colors.white,
                                child: GetBuilder<StockListController>(
                                    id: 'stock_list',
                                    init: controller,
                                    global: false,
                                    builder: (_) {
                                      return CustomEasyRefresh(
                                          controller: controller
                                              .state.refreshController,
                                          onLoad: controller.onLoad,
                                          onRefresh: controller.onRefresh,
                                          emptyWidget:
                                              controller.state.productList ==
                                                      null
                                                  ? LottieIndicator()
                                                  : controller.state
                                                          .productList!.isEmpty
                                                      ? EmptyLayout(
                                                          hintText: '什么都没有'.tr)
                                                      : null,
                                          child: ListView.separated(
                                            padding: EdgeInsets.only(top: 0),
                                            itemBuilder: (context, index) {
                                              ProductDTO stockDTO = controller
                                                  .state.productList![index];
                                              return InkWell(
                                                  onTap: () {
                                                    controller.productDetail(
                                                        stockDTO);
                                                  },
                                                  child: Container(
                                                      width: double.infinity,
                                                      color: Colors.white,
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: 24.w,horizontal: 32.w
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                      stockDTO.productName ??
                                                                          '',
                                                                      style:
                                                                          TextStyle(
                                                                        color: stockDTO.invalid ==
                                                                                1
                                                                            ? Colours.text_ccc
                                                                            : Colours.text_333,
                                                                        fontSize:
                                                                            32.sp,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      )),
                                                                ),
                                                                Visibility(
                                                                    visible:
                                                                        stockDTO.invalid ==
                                                                            1,
                                                                    child:
                                                                        Container(
                                                                      padding: EdgeInsets.only(
                                                                          top: 2
                                                                              .w,
                                                                          bottom: 2
                                                                              .w,
                                                                          left: 4
                                                                              .w,
                                                                          right:
                                                                              4.w),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              Colours.text_ccc,
                                                                          width:
                                                                              1.0,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                      ),
                                                                      child: Text(
                                                                          '已停用',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colours.text_999,
                                                                            fontSize:
                                                                                26.sp,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          )),
                                                                    )),
                                                                Expanded(
                                                                  child: Text(
                                                                      textAlign:
                                                                          TextAlign
                                                                              .end,
                                                                      controller.getSalesChannel(
                                                                          stockDTO
                                                                              .salesChannel),
                                                                      style:
                                                                          TextStyle(
                                                                        color: stockDTO.invalid ==
                                                                                1
                                                                            ? Colours.text_ccc
                                                                            : Colours.text_999,
                                                                        fontSize:
                                                                            22.sp,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      )),
                                                                )
                                                              ]),
                                                          SizedBox(
                                                            height: 16.w,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(child: Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                    controller.judgeUnit(stockDTO),
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
                                                                      30.sp,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                    )),
                                                              )),
                                                              Visibility(
                                                                  visible:controller.state.select != StockListType.SELECT_PRODUCT,
                                                                  child: Container(
                                                                    width: 60.w,
                                                                    height: 60.w,
                                                                    child: IconButton(
                                                                        padding: EdgeInsets.zero,
                                                                        onPressed: () => controller.showBottomSheet(
                                                                            context,
                                                                            stockDTO),
                                                                        icon: Icon(
                                                                            Icons.more_horiz,
                                                                            size: 40.sp,
                                                                            color: Colours.text_666)),
                                                                  )),
                                                            ],
                                                          ),
                                                      Offstage(
                                                        offstage: !((stockDTO.productPlace?.isNotEmpty ?? false) &&
                                                            (stockDTO.productStandard?.isNotEmpty ?? false)),
                                                        child: SizedBox(
                                                            height: 10.w,
                                                          )),
                                                          Offstage(
                                                            offstage: !((stockDTO.productPlace?.isNotEmpty ?? false) &&
                                                                (stockDTO.productStandard?.isNotEmpty ?? false)),
                                                            child: Flex(
                                                                direction: Axis.horizontal,
                                                                    children: [
                                                                      Text(
                                                                          stockDTO.productPlace ?? '',
                                                                          style:
                                                                              TextStyle(
                                                                            color: stockDTO.invalid == 1
                                                                                ? Colours.text_ccc
                                                                                : Colours.text_999,
                                                                            fontSize:
                                                                                26.sp,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          )),
                                                                      SizedBox(
                                                                        width:
                                                                            32.w,
                                                                      ),
                                                                      Expanded(
                                                                          child: Text(
                                                                              stockDTO.productStandard ?? '',
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                color: stockDTO.invalid == 1 ? Colours.text_ccc : Colours.text_999,
                                                                                fontSize: 26.sp,
                                                                                fontWeight: FontWeight.w500,
                                                                              ))),
                                                                    ]),
                                                              )
                                                        ],
                                                      )));
                                            },
                                            itemCount: controller.state
                                                    .productList?.length ??
                                                0,
                                            separatorBuilder:
                                                (context, index) => Container(
                                              height: 2.w,
                                              color: Colours.divider,
                                              width: double.infinity,
                                            ),
                                          ));
                                    }),
                              ))
                        ],
                      );
                    }),
              ),
              GetBuilder(
                  id: 'stock_list_bottom',
                  init: controller,
                  global: false,
                  builder: (_){
                return Offstage(
                    offstage: Get.routing.current == RouteConfig.main,
                    child: Align(
                        child: Container(
                            width: double.infinity,
                            height: 120.w,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: Offset(1, 1),
                                  blurRadius: 3,
                                ),
                              ],
                              //borderRadius: BorderRadius.circular(12.0),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                    child: InkWell(
                                        onTap: () {
                                          controller.toAddProduct();
                                        },
                                        child: PermissionWidget(
                                            permissionCode: PermissionCode.purchase_add_stock_order_permission,
                                            child: Container(
                                                padding:
                                                EdgeInsets.only(top: 16.w),
                                                alignment: Alignment.center,
                                                child: Column(
                                                  children: [
                                                    LoadSvg(
                                                      'svg/ic_stock_list_add_stock',
                                                      width: 40.w,
                                                      color: Colors.blue[500],
                                                    ),
                                                    Text(
                                                      '直接入库',
                                                      style: TextStyle(
                                                        fontSize: 28.sp,
                                                        color: Colors.blue[500],
                                                      ),
                                                    )
                                                  ],
                                                ))))),
                                Container(
                                  height: 100.w,
                                  width: 1.w,
                                  color: Colours.divider,
                                ),
                                Expanded(
                                    child: InkWell(
                                        onTap: () => Get.toNamed(
                                            RouteConfig.stockChangeRecord),
                                        child: PermissionWidget(
                                            permissionCode: PermissionCode
                                                .stock_stock_change_record_permission,
                                            child: Container(
                                              padding: EdgeInsets.only(top: 16.w),
                                              alignment: Alignment.center,
                                              child: Column(
                                                children: [
                                                  LoadSvg(
                                                    'svg/ic_to_stock_change',
                                                    width: 40.w,
                                                    color: Colors.blue[500],
                                                  ),
                                                  Text(
                                                    '调整库存',
                                                    style: TextStyle(
                                                      fontSize: 28.sp,
                                                      color: Colors.blue[500],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ))))
                              ],
                            ))));
              })

            ],
          )),
    );
  }
}
