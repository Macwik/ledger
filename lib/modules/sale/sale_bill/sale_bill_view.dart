import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/product/product_shopping_car_dto.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/image_util.dart';
import 'package:ledger/widget/permission/ledger_widget_type.dart';
import 'package:ledger/widget/permission/permission_owner_widget.dart';
import 'package:ledger/widget/will_pop.dart';

import 'sale_bill_controller.dart';

class SaleBillView extends StatelessWidget {
  SaleBillView({super.key});

  final controller = Get.find<SaleBillController>();

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: GetBuilder<SaleBillController>(
          id: 'bill_title',
          init: controller,
          global: false,
          builder: (_) {
            return Text(
              controller.saleBill(),
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: (controller.state.orderType == OrderType.SALE) ||
                          (controller.state.orderType == OrderType.PURCHASE)||
                      (controller.state.orderType ==OrderType.ADD_STOCK)
                      ? Colors.white
                      : Colors.red[700]),
            );
          },
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
              child: GetBuilder<SaleBillController>(
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
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            controller.saleBillGetBack();
          },
        ),
      ),
      body: MyWillPop(
          onWillPop: () async {
            controller.saleBillGetBack();
            return true;
          },
          child: FormBuilder(
              key: controller.state.formKey,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Container(
                            color: Colors.white,
                            padding: EdgeInsets.only(
                                left: 40.w,
                                right: 40.w,
                                top: 40.w,
                                bottom: 20.w),
                            child: Column(
                              children: [
                                PermissionOwnerWidget(
                                    widgetType: LedgerWidgetType.Disable,
                                    child: Row(
                                      children: [
                                        Text(
                                          '日期',
                                          style: TextStyle(
                                            color: Colours.text_666,
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const Spacer(),
                                        InkWell(
                                          onTap: () => controller.pickerDate(context),
                                          child: GetBuilder<SaleBillController>(
                                              id: 'bill_date',
                                              init: controller,
                                              global: false,
                                              builder: (_) {
                                                return Text(
                                                  DateUtil.formatDefaultDate(
                                                      controller.state.date),
                                                  style: TextStyle(
                                                    color: Colours.text_333,
                                                    fontSize: 30.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                );
                                              }),
                                        )
                                      ],
                                    )),
                                Container(
                                  color: Colours.divider,
                                  height: 1.w,
                                  margin: EdgeInsets.only(top: 16, bottom: 16),
                                  width: double.infinity,
                                ),
                                GetBuilder<SaleBillController>(
                                    id: 'bill_custom',
                                    init: controller,
                                    global: false,
                                    builder: (_) {
                                      return InkWell(
                                          onTap: () =>
                                              controller.pickerCustom(),
                                          child: Row(
                                            children: [
                                              Text(
                                                (controller.state.orderType == OrderType.SALE) ||
                                                        (controller.state.orderType == OrderType.SALE_RETURN)
                                                    ? '客户'
                                                    : '供应商',
                                                style: TextStyle(
                                                  color: Colours.text_666,
                                                  fontSize: 30.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Expanded(
                                                  child: Text(
                                                textAlign: TextAlign.right,
                                                controller.customName(),
                                                style: TextStyle(
                                                  color: controller
                                                              .state
                                                              .customDTO
                                                              ?.customName !=
                                                          null
                                                      ? Colours.text_333
                                                      : Colours.text_333,
                                                  fontSize: 30.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20.w),
                                                child: LoadAssetImage(
                                                  'common/arrow_right',
                                                  width: 25.w,
                                                  color: Colours.text_999,
                                                ),
                                              ),
                                            ],
                                          ));
                                    }),
                                Container(
                                  color: Colours.divider,
                                  height: 1.w,
                                  margin: EdgeInsets.only(top: 16),
                                  width: double.infinity,
                                ),
                                Visibility(
                                    visible: (controller.state.orderType == OrderType.PURCHASE)||
                                        (controller.state.orderType == OrderType.ADD_STOCK),
                                    child:
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    InkWell(
                                      onTap: () =>
                                          controller.explainBatchNumber(),
                                      child: Row(
                                        children: [
                                          Text(
                                            '批次号',
                                            style: TextStyle(
                                              color: Colours.text_666,
                                              fontSize: 30.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          LoadAssetImage(
                                            'ic_home_question',
                                            color: Colors.black45,
                                            width: 24.w,
                                            height: 24.w,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                          textAlign: TextAlign.right,
                                          controller: controller.state.textEditingController,
                                          maxLength: 15,
                                          decoration: InputDecoration(
                                            counterText: '',
                                              hintText: '请输入采购批次号',
                                              border: InputBorder.none),
                                          style: TextStyle(fontSize: 30.sp),
                                          keyboardType: TextInputType.text,
                                          validator: (value) {
                                            if((controller.state.orderType == OrderType.PURCHASE)||
                                                (controller.state.orderType == OrderType.ADD_STOCK)) {
                                              var text = controller.state.textEditingController.text;
                                              if (text.isEmpty) {
                                                return '批次号不能为空';
                                              }
                                            }
                                            return null;
                                          }),
                                    ),
                                    Row(
                                      children: [
                                        GetBuilder<SaleBillController>(
                                            id: 'bill_checkbox',
                                            init: controller,
                                            global: false,
                                            builder: (_) {
                                              return Checkbox(
                                                value: controller.state.checked,
                                                activeColor: Colours.primary,
                                                onChanged: (value) {
                                                  controller
                                                      .generateBatchNumber(
                                                          value);
                                                },
                                              );
                                            }),
                                        Text(
                                          '自定义',
                                          style: TextStyle(
                                            color: Colours.text_666,
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )),
                                Visibility(
                                    visible: (controller.state.orderType == OrderType.PURCHASE)||
                                        (controller.state.orderType == OrderType.ADD_STOCK),
                                    child:
                                Container(
                                  color: Colours.divider,
                                  height: 1.w,
                                  //margin: EdgeInsets.only( bottom: 8),
                                  width: double.infinity,
                                )),
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Expanded(
                                        child: Text(
                                      '备注',
                                      style: TextStyle(
                                        color: Colours.text_666,
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )),
                                    Expanded(
                                        flex: 3,
                                        child: TextFormField(
                                          controller: controller.state.remarkTextEditingController,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 30.sp
                                          ),
                                          keyboardType: TextInputType.streetAddress,
                                          decoration: InputDecoration(
                                              hintText: '请填写',
                                              border: InputBorder.none,
                                              counterText: ''
                                          ),
                                          maxLength: 32,
                                        ))
                                  ],
                                ),
                              ],
                            )),
                        Container(
                          width: double.infinity,
                          height: 80.w,
                          margin: EdgeInsets.symmetric(horizontal: 32.w ,vertical: 16.w),
                          child: ElevatedButton(
                            onPressed: () => controller.addShoppingCar(),
                            child: Text(
                              '+ 添加货物',
                              style: TextStyle(
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        // 货物详情
                        GetBuilder<SaleBillController>(
                            id: 'sale_bill_product_title',
                            init: controller,
                            global: false,
                            builder: (_) {
                              return Visibility(
                                  visible: controller.state.visible,
                                  child:   Container(
                                    padding: EdgeInsets.only(left: 40.w, right: 40.w, top: 30.w),
                                    width: double.infinity,
                                    color: Colors.white,
                                    child: Row(
                                      children: [
                                        Container(
                                          color: Colours.primary,
                                          height: 38.w,
                                          width: 8.w,
                                        ),
                                        Container(
                                          color: Colors.white,
                                          margin: EdgeInsets.only(left: 6),
                                          child: Text(
                                            '货物明细',
                                            style: TextStyle(
                                                color: Colours.text_666,
                                                fontSize: 36.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),);
                            }),
                      ],
                    ),
                  ),
                  GetBuilder<SaleBillController>(
                      id: 'sale_bill_product_list',
                      init: controller,
                      global: false,
                      builder: (_) {
                        return controller.state.shoppingCarList.isEmpty
                            ? SliverToBoxAdapter(
                                child: EmptyLayout(hintText: '请添加货物'),
                              )
                            : SliverList.separated(
                                separatorBuilder: (context, index) => Container(
                                  height: 1.w,
                                  color: Colours.divider,
                                  width: double.infinity,
                                ),
                                itemCount:
                                    controller.state.shoppingCarList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  ProductShoppingCarDTO productDTO =
                                      controller.state.shoppingCarList[index];
                                  return Slidable(
                                      endActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        extentRatio: 0.25,
                                        children: [
                                          SlidableAction(
                                            label: '删除',
                                            backgroundColor: Colors.red,
                                            icon: Icons.delete_outline_rounded,
                                            onPressed: (context) {
                                              controller.toDeleteOrder(productDTO);
                                            },
                                          ),
                                        ],
                                      ),
                                      child: Visibility(
                                        visible: controller.state.orderType != OrderType.ADD_STOCK,
                                          //入库时候展示内容
                                          replacement:Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical:32.w,
                                                horizontal: 40.w),
                                            width: double.infinity,
                                            color: Colors.white,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                        productDTO.productName ?? '',
                                                        style: TextStyle(
                                                          color: Colours.text_333,
                                                          fontSize: 32.sp,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                        ))),
                                              Text(controller.getAddStockNum(productDTO.unitDetailDTO!) ?? '',
                                                    style: TextStyle(
                                                      color: Colours.text_333,
                                                      fontSize: 30.sp,
                                                      fontWeight: FontWeight.w500,
                                                    )),
                                              ],
                                            ),
                                          ) ,
                                          //开单时候展示内容
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 24.w,
                                                horizontal: 40.w),
                                            width: double.infinity,
                                            color: Colors.white,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: Text(
                                                            productDTO.productName ?? '',
                                                            style: TextStyle(
                                                              color: Colours.text_333,
                                                              fontSize: 32.sp,
                                                              fontWeight:
                                                              FontWeight.w500,
                                                            ))),
                                                    Text(
                                                        DecimalUtil.formatAmount(productDTO.unitDetailDTO?.totalAmount),
                                                        style: TextStyle(
                                                          color: Colours.text_333,
                                                          fontSize: 30.sp,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                        )),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10.w,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(controller.getPrice(productDTO.unitDetailDTO!) ?? '',
                                                        style: TextStyle(
                                                          color: Colours.text_666,
                                                          fontSize: 26.sp,
                                                          fontWeight: FontWeight.w500,
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ))
                                      );
                                },
                              );
                      }),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 130.w,
                    ),
                  )
                ],
              ))),
      //底部按钮

      floatingActionButton: GetBuilder<SaleBillController>(
          id: 'sale_bill_btn',
          init: controller,
          global: false,
          builder: (_) {
            return Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: Offset(1, 1),
                    blurRadius: 3,
                  ),
                ],
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(10.w),
              margin: EdgeInsets.symmetric(vertical: 2.w, horizontal: 10.w),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
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
                              Text('挂单')
                            ],
                          )
                        )),
                        Visibility(
                            visible:controller.state.orderType ==OrderType.SALE,
                            child: Container(
                          width: 2.w,
                          height: 80.w,
                          margin: EdgeInsets.only(left: 16.w),
                          color: Colours.divider,
                        )),
                        Visibility(
                            visible: controller.state.orderType != OrderType.ADD_STOCK,
                            child: Container(
                            margin: EdgeInsets.only(left: 16.w),
                            child:
                            Text(
                              controller.totalAmount(),
                              style: TextStyle(
                                  color: Colours.text_999,
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.w500
                              ),
                            ))),
                        Visibility(
                      visible: controller.state.orderType != OrderType.ADD_STOCK,
                      child:
                        Expanded(
                            flex: 2,
                            child: Text(
                               DecimalUtil.formatAmount(controller.state.totalAmount),
                              style: TextStyle(
                                color: Colors.red[600],
                                fontSize: 42.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ))),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        height: 100.w,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.state.formKey.currentState
                                        ?.saveAndValidate() ?? false
                                ? controller.showPaymentDialog(context)
                                : null;
                          },
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
                          child: Text(
                            controller.state.orderType == OrderType.ADD_STOCK
                            ?'确认入库'
                            :'支付',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
