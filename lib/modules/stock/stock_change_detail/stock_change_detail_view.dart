import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/res/export.dart';

import 'stock_change_detail_controller.dart';

class StockChangeDetailView extends StatelessWidget {
  StockChangeDetailView({super.key});

  final controller = Get.find<StockChangeDetailController>();
  final state = Get.find<StockChangeDetailController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: TitleBar(
        title:'库存调整详情'),
      body:
      //第一部分:此单合计
      GetBuilder<StockChangeDetailController>(
          id: 'stock_change_detail',
          builder: (_) {
            return Column(
              children: [
                 Container(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 16, bottom: 16),
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                '提交时间',
                                style: TextStyle(
                                  color: Colours.text_666,
                                    fontSize: 32.sp,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                state.stockChangeRecordDTO?.adjustDate??'',
                                style: TextStyle(
                                  color: Colours.text_333,
                                    fontSize: 32.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.w,),
                          Row(
                            children: [
                              Text(
                                '业务员',
                                style: TextStyle(
                                  color: Colours.text_666,
                                    fontSize: 32.sp,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                state.stockChangeRecordDTO?.creatorName??'',
                                style: TextStyle(
                                  color: Colours.text_333,
                                    fontSize: 32.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                Container(
                      color: Colors.white12,
                      height: 15.w,
                      width: double.infinity,
                    ),
                Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(
                          left: 16, right: 20, top: 16,bottom: 24.w),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                color: Colours.primary,
                                height: 32.w,
                                width: 8.w,
                              ),
                              Container(
                                color: Colors.white,
                                margin: EdgeInsets.only(left: 6),
                                child: Text(
                                  '盘点详情',
                                  style: TextStyle(
                                      color: Colours.text_666,
                                      fontSize: 34.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                GetBuilder<StockChangeDetailController>(
                    id: 'stock_change_list',
                    builder: (_) {
                      return Container(
                        padding: EdgeInsets.only(
                            left: 30.w,
                            right: 30.w,
                            top: 20.w,
                            bottom: 20.w),
                        width: double.infinity,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Text( state.stockChangeRecordDTO?.productName??'-',
                                    style: TextStyle(
                                      color: Colours.text_333,
                                      fontSize: 34.sp,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 16.w,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Visibility(
                                      visible: (((state.stockChangeRecordDTO != null)) &&
                                          ((state.stockChangeRecordDTO?.productStandard?.isNotEmpty ?? false))),
                                      child:  Row(
                                          children:[
                                            Text( '规格:',
                                                style: TextStyle(
                                                  color: Colours.text_ccc,
                                                  fontSize: 30.sp,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                            SizedBox(width: 24.w,),
                                            Expanded(child:
                                            Text(state.stockChangeRecordDTO?.productStandard ?? '',
                                                style: TextStyle(
                                                  color: Colours.text_999,
                                                  fontSize: 30.sp,
                                                  fontWeight: FontWeight.w500,
                                                )))
                                          ]
                                      )),),
                                Expanded(
                                    child: Visibility(
                                        visible: (((state.stockChangeRecordDTO != null)) &&
                                            ((state.stockChangeRecordDTO?.productStandard?.isNotEmpty ?? false))),
                                        child: Row(children: [Text('产地:',
                                            style: TextStyle(
                                              color: Colours.text_ccc,
                                              fontSize: 30.sp,
                                              fontWeight: FontWeight.w500,
                                            )),
                                          SizedBox(
                                            width: 24.w,
                                          ),
                                          Expanded(
                                              child: Text(
                                                  state.stockChangeRecordDTO
                                                      ?.productPlace ??
                                                      '',
                                                  style: TextStyle(
                                                    color: Colours.text_999,
                                                    fontSize: 30.sp,
                                                    fontWeight: FontWeight.w500,
                                                  )))
                                        ])))
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
                                    Text( '盘点数:',
                                        style: TextStyle(
                                          color: Colours.text_999,
                                          fontSize: 30.sp,
                                          fontWeight: FontWeight.w500,
                                        )),
                                    SizedBox(width: 24.w,),
                                    Expanded(child:
                                    Text(controller.afterCount(state.stockChangeRecordDTO),
                                        style: TextStyle(
                                          color: Colours.text_666,
                                          fontSize: 30.sp,
                                          fontWeight: FontWeight.w500,
                                        )))
                                  ],
                                )),

                              ],
                            ),
                            SizedBox(
                              height: 16.w,
                            ),
                            Flex(
                              direction: Axis.horizontal,
                              children: [
                                Expanded(child:
                                Row(children: [
                                Text( '差    异:',
                                    style: TextStyle(
                                      color: Colours.text_999,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w500,
                                    )),
                                SizedBox(width: 24.w,),
                                Expanded(child:
                                Text(controller.getDiff(state.stockChangeRecordDTO),
                                    style: TextStyle(
                                      color: controller.beforeCountColor(state.stockChangeRecordDTO),
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w500,
                                    ))),
                              ],)),

                                  ],
                            ),

                            SizedBox(
                              height: 16.w,
                            ),
                            Row(
                              children: [
                                Text( '盘点前:',
                                    style: TextStyle(
                                      color: Colours.text_999,
                                           fontSize: 30.sp,
                                      fontWeight: FontWeight.w500,
                                    )) ,
                                SizedBox(width: 24.w,),
                                Text(controller.beforeCount(state.stockChangeRecordDTO),
                                    style: TextStyle(
                                      color: Colours.text_666,
                                           fontSize: 30.sp,
                                      fontWeight: FontWeight.w500,
                                    )) ,
                              ],
                            ),

                          ],
                        ),
                      );
                    }),

              ],
            );
          }),
      //此版本不加审核功能
      // //底部按钮
      // floatingActionButton:
      // GetBuilder<StockChangeDetailController>(
      //     id: 'stock_change_detail_btn',
      //     builder: (_) {
      //       return   Container(
      //         height: 100.w,
      //         margin: EdgeInsets.only(bottom: 3.w, right: 5.w, left: 5.w),
      //         child: Flex(
      //           direction: Axis.horizontal,
      //           children: [
      //             Expanded(
      //                 flex: 1,
      //                 child: Container(
      //                   margin: EdgeInsets.only(right: 3.w),
      //                   decoration: BoxDecoration(
      //                     boxShadow: [
      //                       BoxShadow(
      //                         color: Colors.black12.withOpacity(0.2),
      //                         offset: Offset(1, 1),
      //                         blurRadius: 2,
      //                       ),
      //                     ],
      //                     borderRadius: BorderRadius.circular(8.0),
      //                     color: Colors.white,
      //                   ),
      //                   height: 100.w,
      //                   child: ElevatedButton(
      //                     onPressed: () {},
      //                     style: ButtonStyle(
      //                       maximumSize: MaterialStateProperty.all(
      //                           Size(double.infinity, 60)),
      //                       backgroundColor:
      //                       MaterialStateProperty.all(Colors.white),
      //                       shape: MaterialStateProperty.all(
      //                           RoundedRectangleBorder(
      //                             borderRadius: BorderRadius.circular(8.0),
      //                           )),
      //                     ),
      //                     child: Text(
      //                       '作废',
      //                       style: TextStyle(
      //                         color: Colors.redAccent,
      //                         fontSize: 32.sp,
      //                       ),
      //                     ),
      //                   ),
      //                 )
      //             ),
      //             Expanded(
      //                 flex: 1,
      //                 child: Container(
      //                   height: 100.w,
      //                   decoration: BoxDecoration(
      //                     boxShadow: [
      //                       BoxShadow(
      //                         color: Colours.primary.withOpacity(0.2),
      //                         offset: Offset(1, 1),
      //                         blurRadius: 2,
      //                       ),
      //                     ],
      //                     borderRadius: BorderRadius.circular(8.0),
      //                     color: Colors.white,
      //                   ),
      //                   child: ElevatedButton(
      //                     onPressed: () {},
      //                     style: ButtonStyle(
      //                       maximumSize: MaterialStateProperty.all(
      //                           Size(double.infinity, 60)),
      //                       backgroundColor:
      //                       MaterialStateProperty.all(Colours.primary),
      //                       shape: MaterialStateProperty.all(
      //                           RoundedRectangleBorder(
      //                             borderRadius: BorderRadius.circular(8.0),
      //                           )),
      //                     ),
      //                     child: Text(
      //                       '确定',
      //                       style: TextStyle(
      //                         color: Colors.white,
      //                         fontSize: 32.sp,
      //                       ),
      //                     ),
      //                   ),
      //                 )),
      //           ],
      //         ),
      //       );
      //     }),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
