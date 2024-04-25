import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/enum/stock_list_type.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/picker_date_utils.dart';

import 'data_export_controller.dart';

class DataExportView extends StatelessWidget {
  final controller = Get.find<DataExportController>();
  final state = Get.find<DataExportController>().state;

  @override
  Widget build(BuildContext context) {
    //controller.initState();
    return Scaffold(
      appBar: TitleBar(
        title:'数据导出',),
      body: Column(children: [
            IntrinsicHeight(
              child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(
                      top: 20.w, left: 40.w, right: 40.w, bottom: 20.w),
                  child: Column(
                    children: [
                      Container(
                        height: 60.w,
                        width: double.infinity,
                        alignment: Alignment.bottomCenter,
                        child:
                        InkWell(
                          onTap: ()=> Get.toNamed(RouteConfig.myAccount),
                          child:  Row(
                          children: [
                            Expanded(
                              child: Text(
                                '导出账套',
                                style: TextStyle(
                                  color: Colours.text_666,
                                  fontSize: 30.sp,
                                ),
                              ),
                            ),
                            const Spacer(),
                            // 此处填充账套名字,默认是当前使用账套
                            Expanded(
                              child: Text(
                               '请选择',
                                textAlign: TextAlign.end,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(Icons.keyboard_arrow_right),
                            ),
                          ],
                        ),)
                      ),
                      Container(
                        color: Colours.divider,
                        margin: EdgeInsets.only(top: 10.0, bottom: 10),
                        height: 1.w,
                        width: double.infinity,
                      ),
                      Container(
                        height: 60.w,
                        width: double.infinity,
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '导出项目',
                                style: TextStyle(
                                  color: Colours.text_666,
                                  fontSize: 30.sp,
                                ),
                              ),
                            ),
                            const Spacer(),
                            // 此处填充项目名字，默认是全部
                            DropdownButton<String>(
                              //value: selectedOption,
                              //通过将其赋值给value属性，我们确保该选项被显示为默认选择。
                              //hint: Text('请选择'),
                              icon: Icon(Icons.keyboard_arrow_right),
                              // 设置箭头图标
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.black),
                              onChanged: (value) {},
                              items: <String>[
                                '全部',
                                '销售记录',
                                '采购记录',
                                '库存调整记录',
                                '客户欠款情况',
                                '供应商欠款情况',
                                '费用收入记录'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: Colours.divider,
                        margin: EdgeInsets.only(top: 10.0,bottom: 20.w),
                        height: 1.w,
                        width: double.infinity,
                      ),
                      Container(
                        height: 60.w,
                        width: double.infinity,
                        alignment: Alignment.bottomCenter,
                        child:InkWell(
                          onTap: ()=> Get.toNamed(RouteConfig.stockList, arguments: {'select': StockListType.SELECT_PRODUCT}),
                          child:  Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '导出货物',
                                  style: TextStyle(
                                    color: Colours.text_666,
                                    fontSize: 30.sp,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              // 此处填充货物名字,默认是全部
                              Expanded(
                                child: Text(
                                  'goodsName',
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Icon(Icons.keyboard_arrow_right),
                              ),
                            ],
                          ),
                        )
                      ),
                      Container(
                        color: Colours.divider,
                        margin: EdgeInsets.only(top: 10.0, bottom: 10),
                        height: 1.w,
                        width: double.infinity,
                      ),
                      Row(
                        children: [
                          Text('选择导出日期',
                            style: TextStyle(
                            color: Colours.text_666,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w500,
                          ),),
                          const Spacer(),
                        ],
                      ),
                      SizedBox(height: 30.w,),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12, horizontal: 10)),
                                  backgroundColor:
                                  MaterialStateProperty.all(
                                      Colors.white), // 背景色
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
                                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12, horizontal: 10)),
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
                          ])
                    ],
                  )),
            ),
            Spacer(
              flex: 1,
            ),
            Container(
              child: GetBuilder<DataExportController>(
                  id: 'export_btn',
                  builder: (logic) {
                    return Row(
                      children: [
                        Expanded(
                          child: ElevatedBtn(
                            margin: EdgeInsets.only(top: 80.w),
                            size: Size(double.infinity, 90.w),
                            //onPressed: (state.formKey.currentState?.isValid ?? false) ? logic.login : null,
                            radius: 15.w,
                            backgroundColor: Colors.white,
                            text: '取消',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedBtn(
                            margin: EdgeInsets.only(top: 80.w),
                            size: Size(double.infinity, 90.w),
                            //onPressed: (state.formKey.currentState?.isValid ?? false) ? logic.login : null,
                            radius: 15.w,
                            backgroundColor: Colours.primary,
                            text: '导出',
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
          ]),
    );
  }
}
