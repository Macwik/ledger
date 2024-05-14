import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:ledger/enum/custom_type.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/modules/sale/custom_record/custom_record_controller.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/image_util.dart';

import 'custom_cell.dart';

//const double _cellHeight = 50;
//
// class LedgerContactsCell extends StatelessWidget {
//   const LedgerContactsCell({
//     super.key,
//     required this.model,
//     required this.index,
//     required this.dataArr,
//     required this.bottomContactsCountText,
//     this.onClickCell,
//     this.onClickTopCell,
//     required this.controller,
//   });
//
//   final CustomRecordController controller;
//   final CustomDTO model;
//   final int index;
//   final List dataArr;
//   final String bottomContactsCountText;
//   final Function(CustomDTO model)? onClickCell;
//   final Function(dynamic model)? onClickTopCell;

  // @override
  // Widget build(BuildContext context) {
  //   if (index == 0) return _buildHeader(context);
  //   return _buildCell();
  // }

  // Widget _buildHeader(context) {
  //   Widget searchBar = Column(children: [
  //     Flex(direction: Axis.horizontal, children: [
  //       Expanded(
  //         flex: 1,
  //         child: Container(
  //           color: Colors.white30,
  //           height: 100.w,
  //           padding: EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w),
  //           child: SearchBar(
  //             onChanged: (value) => controller.searchCustom(value),
  //             leading: Icon(
  //               Icons.search,
  //               color: Colors.grey,
  //               size: 40.w,
  //             ),
  //             shadowColor: MaterialStatePropertyAll<Color>(Colors.black26),
  //             hintStyle: MaterialStatePropertyAll<TextStyle>(
  //                 TextStyle(fontSize: 34.sp, color: Colors.black26)),
  //             hintText: '请输入客户名称',
  //             //onChanged: (value) => controller.searchCustom(value),
  //           ),
  //         ),
  //       ),
  //       Builder(
  //         builder: (context) => GestureDetector(
  //           onTap: () {
  //             Scaffold.of(context).openEndDrawer();
  //           },
  //           child: Row(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               LoadAssetImage(
  //                 'screen',
  //                 format: ImageFormat.png,
  //                 color: Colours.text_999,
  //                 height: 40.w,
  //                 width: 40.w,
  //               ), // 导入的图像
  //               SizedBox(width: 8.w), // 图像和文字之间的间距
  //               Text(
  //                 '筛选',
  //                 style: TextStyle(fontSize: 30.sp, color: Colours.text_666),
  //               ),
  //               SizedBox(
  //                 width: 24.w,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ]),
  //     Container(
  //       padding: EdgeInsets.symmetric(vertical: 8.w),
  //       width: double.infinity,
  //       color: Colors.white30,
  //       child: Row(
  //         children: [
  //           Expanded(
  //             child: Container(
  //                 //height: 90.w,
  //                 padding: EdgeInsets.only(left: 40.w),
  //                 child: Row(children: [
  //                   Text(
  //                     '欠款人数： ',
  //                     style: TextStyle(
  //                       color: Colours.text_ccc,
  //                       fontSize: 26.w,
  //                     ),
  //                   ),
  //                   Expanded(
  //                     child: Text(
  //                       controller.state.totalCreditCustom
  //                           .toString(),
  //                       style: TextStyle(
  //                           color: Colours.primary,
  //                           fontSize: 28.w,
  //                           fontWeight: FontWeight.w500),
  //                     ),
  //                   )
  //                 ])),
  //           ),
  //           Expanded(
  //             child: Container(
  //                 child: Row(children: [
  //               Text(
  //                 '欠款金额： ',
  //                 style: TextStyle(color: Colours.text_ccc, fontSize: 24.w),
  //               ),
  //               Expanded(
  //                 child: Text(
  //                   DecimalUtil.formatDecimal(
  //                       controller.state.totalCreditAmount,
  //                       scale: 0),
  //                   style: TextStyle(
  //                       color: Colours.primary,
  //                       fontSize: 28.w,
  //                       fontWeight: FontWeight.w500),
  //                 ),
  //               )
  //             ])),
  //           ),
  //         ],
  //       ),
  //     ),
  //
  //   ]);

  //   List<Widget> topWidgetList = [searchBar];
  //
  //   return Column(children: topWidgetList);
  // }

  // Cell
  // Widget _buildCell() {
  //   double cellH = _cellHeight;
  //   double leftSpace = 65.0;
  //   double imgWH = 40;
  //
  //   return Column(
  //     children: <Widget>[
  //       CustomCell(
  //         titleWidth: 200,
  //         leftImgWH: imgWH,
  //         cellHeight: cellH,
  //         lineLeftEdge: leftSpace,
  //         customDTO: model,
  //         controller: controller,
  //         // leftWidget: Container(
  //         //   height: imgWH,
  //         //   width: imgWH,
  //         //   decoration: BoxDecoration(
  //         //     color: Colors.white,
  //         //     borderRadius: BorderRadius.circular(3),
  //         //   ),
  //         //   child: Center(
  //         //     child: Text(model.customName!.substring(0, 1),
  //         //         style: const TextStyle(color: Colours.bg, fontSize: 20)),
  //         //   ),
  //         // ),
  //         clickCallBack: () => onClickCell?.call(model),
  //       ),
  //       Container(color:Colors.white38,height: 2.w,),
  //       Offstage(
  //         offstage: dataArr[dataArr.length - 1].id != model.id,
  //         child: Container(
  //           width: double.infinity,
  //           height: cellH,
  //           alignment: Alignment.center,
  //           child: Text(bottomContactsCountText,
  //               style: const TextStyle(fontSize: 16, color: Colors.grey)),
  //         ),
  //       ),
  //     ],
  //   );
  // }
//}
