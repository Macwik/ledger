import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/image_util.dart';
import 'package:ledger/util/picker_date_utils.dart';

import 'stock_change_record_controller.dart';

class StockChangeRecordView extends StatelessWidget {
  final controller = Get.find<StockChangeRecordController>();
  final state = Get.find<StockChangeRecordController>().state;



  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
        appBar: TitleBar(
          title: '库存调整记录'.tr,
        ),
        endDrawer: Drawer(
          width: ScreenUtil().screenWidth * 0.8,
          child: Container(
              color: Colours.select_bg,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 100.w, left: 20.w, right: 20.w),
              child: Stack(children: [
                Column(
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
                    GetBuilder<StockChangeRecordController>(
                        id: 'date_range',
                        builder: (_) {
                          return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(
                                              vertical: 24.w, horizontal: 20.w)),
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          Colors.white),
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
                                    onPressed: () {
                                      PickerDateUtils.pickerDate(context,
                                              (result) {
                                            if (null != result) {
                                              if (result.compareTo(state.endDate) >
                                                  0) {
                                                Toast.show('起始时间需要小于结束时间');
                                                return;
                                              }
                                              state.startDate = result;
                                              controller.update(['date_range']);
                                            }
                                          });
                                    },
                                    child: Text(
                                      ' ${DateUtil.formatDefaultDate(state.startDate)}',
                                      style: TextStyle(
                                        color: Colours.button_text,
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  ' 至',
                                  style: TextStyle(
                                    color: Colours.text_333,
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.symmetric(
                                                  vertical: 24.w,
                                                  horizontal: 20.w)),
                                          backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white), // 背景色
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  35.0), // 圆角
                                              side: BorderSide(
                                                width: 1.0, // 边框宽度
                                                color: Colours.primary, // 边框颜色
                                              ),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          PickerDateUtils.pickerDate(context,
                                                  (result) {
                                                if (null != result) {
                                                  if (result.compareTo(
                                                      state.startDate) <
                                                      0) {
                                                    Toast.show('结束时间需要大于起始时间');
                                                    return;
                                                  }
                                                  state.endDate = result;
                                                  controller.update(['date_range']);
                                                }
                                              });
                                        },
                                        child: Text(
                                          ' ${DateUtil.formatDefaultDate(state.endDate)}',
                                          style: TextStyle(
                                            color: Colours.button_text,
                                            fontSize: 28.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ))),
                              ]);
                        }),
                    SizedBox(
                      height: 40.w,
                    ),
                    Text(
                      '业务员',
                      style: TextStyle(
                        color: Colours.text_333,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 20.w,
                    ),
                    GetBuilder<StockChangeRecordController>(
                      id: 'employee_button',
                      builder: (controller) => Wrap(
                          spacing: 12.0, // 设置标签之间的水平间距
                          runSpacing: 12.0, // 设置标签之间的垂直间距
                          children: [
                            InkWell(
                                onTap: () {
                                  state.selectEmployeeIdList = null;
                                  controller.update(['employee_button']);
                                },
                                child: Chip(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(35), // 设置圆角半径
                                    side: BorderSide(color: Colours.primary, width: 1), // 设置边框颜色和宽度
                                  ),
                                  label: Text(
                                    '全部',
                                    style: TextStyle(
                                      fontSize: 30.sp,
                                      color:
                                      state.selectEmployeeIdList == null
                                          ? Colors.white
                                          : Colours.text_333,
                                    ),
                                  ),
                                  backgroundColor:
                                  state.selectEmployeeIdList == null
                                      ? Colours.primary
                                      : Colors.white,
                                )),
                            ...List.generate(
                              controller.itemCount, // itemCount 是标签的数量
                                  (index) {
                                var employee = state.employeeList![index];
                                return Builder(
                                  builder: (BuildContext context) {
                                    return InkWell(
                                      onTap: () => controller.selectEmployee(employee.id),
                                      child: Chip(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(35), // 设置圆角半径
                                          side: BorderSide(color: Colours.primary, width: 1), // 设置边框颜色和宽度
                                        ),
                                        elevation: 2,
                                        backgroundColor: controller.isEmployeeSelect(employee.id)
                                            ? Colours.primary
                                            : Colors.white,
                                        label: Text(
                                          employee.username ?? '',
                                          style: TextStyle(
                                            fontSize: 30.sp,
                                            color:
                                            controller.isEmployeeSelect(
                                                employee.id)
                                                ? Colors.white
                                                : Colours.text_333,
                                          ),
                                        ),
                                        // 添加额外的样式、点击事件等
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ]

                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 100.w,
                  right: 20.w,
                  left: 20.w,
                  child: GetBuilder<StockChangeRecordController>(
                      id: 'screen_btn',
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
        body: Container(
          child: Column(
            children: [
              Flex(direction: Axis.horizontal,
              children: [
                Expanded(child:  Container(
                    height: 100.w,
                    padding: EdgeInsets.only(top:10.w,left: 10.w, right: 10.w),
                    child: SearchBar(
                        leading: Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: 40.w,
                        ),
                        shadowColor:MaterialStatePropertyAll<Color>(Colors.black26),
                        hintStyle: MaterialStatePropertyAll<TextStyle>(
                            TextStyle(fontSize: 34.sp,  color: Colors.black26)),
                        onChanged: (value){
                          controller.searchStockChangeRecord(value);
                        },
                        hintText: '请输入货物名称'))),
                Builder(
                  builder: (context) => GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    child:  Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LoadAssetImage(
                          'screen',
                          format: ImageFormat.png,
                          color: Colours.text_999,
                          height: 40.w,
                          width: 40.w,
                        ),// 导入的图像
                        SizedBox(width: 8.w), // 图像和文字之间的间距
                        Text('筛选',
                          style: TextStyle(fontSize: 30.sp,
                              color: Colours.text_666),),
                        SizedBox(width: 24.w,),
                      ],
                    ),
                  ),
                ),
              ],),
              Expanded(
                child: GetBuilder<StockChangeRecordController>(
                    id: 'stock_change',
                    builder: (_) {
                      return CustomEasyRefresh(
                        controller: state.refreshController,
                        onLoad: controller.onLoad,
                        onRefresh: controller.onRefresh,
                        emptyWidget: state.items == null
                            ? LottieIndicator()
                            : state.items!.isEmpty
                            ? EmptyLayout(hintText: '什么都没有'.tr)
                            : null,
                        child: ListView.separated(
                      itemBuilder: (context, index) {
                        var stockChangeRecordDTO = state.items![index];
                        return  InkWell(
                          onTap: ()=> Get.toNamed(RouteConfig.stockChangeDetail,arguments: {'stockChangeRecordDTO':stockChangeRecordDTO}),
                          child: Column(children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              color:Colors.white12,
                              padding: EdgeInsets.only(left:40.w,top: 16.w, bottom: 16.w),
                              child:  Text(stockChangeRecordDTO.adjustDate??'',
                                  style: TextStyle(
                                    color: Colours.text_ccc,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 20.w,horizontal: 40.w),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Text(stockChangeRecordDTO.productName??'',
                                          style: TextStyle(
                                            color: Colours.text_333,
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      // SizedBox(
                                      //   width: 15,
                                      // ),
                                      // Text(stockChangeRecordDTO.productPlace??'',//无产地
                                      //     style: TextStyle(
                                      //       color: Colours.text_999,
                                      //       fontSize: 22.sp,
                                      //       fontWeight: FontWeight.w500,
                                      //     )),
                                      // SizedBox(width: 5,),
                                      // Text(stockChangeRecordDTO.productStandard??'',//无规格
                                      //     style: TextStyle(
                                      //       color: Colours.text_999,
                                      //       fontSize: 22.sp,
                                      //       fontWeight: FontWeight.w500,
                                      //     )),
                                      const Spacer(),
                                      Text('自营',
                                          style: TextStyle(
                                            color: Colours.text_999,
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ],
                                  ),
                                  Container(
                                    height: 1.w,
                                    margin: EdgeInsets.only(top: 16.w,bottom: 16.w),
                                    width: double.infinity,
                                    color: Colours.divider,
                                  ),
                                  Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Expanded(child: Row(
                                        children: [
                                         Text('调整库存：',
                                              style: TextStyle(
                                                color: Colours.text_ccc,
                                                fontSize: 26.sp,
                                                fontWeight: FontWeight.w500,
                                              )),
                                          Expanded(child: Text(controller.beforeCount(stockChangeRecordDTO),
                                              style: TextStyle(
                                                color:controller.beforeCountColor(stockChangeRecordDTO),
                                                fontSize: 26.sp,
                                                fontWeight: FontWeight.w500,
                                              )), ),
                                        ],)),
                                      Expanded(child: Row(children: [
                                        Text('业务员：',
                                            style: TextStyle(
                                              color: Colours.text_ccc,
                                              fontSize: 26.sp,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        Expanded(child: Text(stockChangeRecordDTO.creatorName??'',
                                            style: TextStyle(
                                              color: Colours.text_666,
                                              fontSize: 26.sp,
                                              fontWeight: FontWeight.w500,
                                            ))),
                                      ],), )
                                    ],
                                  ),
                                  SizedBox(height: 16.w,),
                                  Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Expanded(child: Row(
                                        children: [
                                          Text('目前库存：',
                                              style: TextStyle(
                                                color: Colours.text_ccc,
                                                fontSize: 26.sp,
                                                fontWeight: FontWeight.w500,
                                              )) ,
                                        Text(controller.afterCount(stockChangeRecordDTO),
                                              style: TextStyle(
                                                color: Colours.text_999,
                                                fontSize: 26.sp,
                                                fontWeight: FontWeight.w500,
                                              ),)
                                        ],)),

                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],)

                          ) ;
                      },
                          separatorBuilder: (context, index) =>
                              Container(
                                height: 2.w,
                                color: Colors.white12,
                                width: double.infinity,
                              ),
                      itemCount: state.items?.length ?? 0,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      floatingActionButton:Container(
          width: 90.0,
          height: 66.0,
          margin: EdgeInsets.all(30.w),
          child: FloatingActionButton(
            onPressed:()=> Get.offNamed(RouteConfig.stockChangeBill),
            child: Container(

                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.add,
                      size: 30.w,),
                    Text('调整',
                      style: TextStyle(
                          fontSize: 32.sp
                      ),),
                  ],)
            ), // 按钮上显示的图标
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained ,);
  }
}
