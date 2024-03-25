///  wx_contacts_cell.dart
///
///  Created by iotjin on 2019/08/14.
///  description: 微信通讯录 cell

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:ledger/modules/sale/custom_record/custom_record_controller.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/util/image_util.dart';
import 'package:ledger/widget/image.dart';

import 'jh_set_cell.dart';

const double _cellHeight = 50;

class WxContactsCell extends StatelessWidget {
  const WxContactsCell({
    super.key,
    required this.model,
    required this.index,
    required this.dataArr,
    required this.bottomContactsCountText,
    this.onClickCell,
    this.onClickTopCell,
    required this.controller,
  });

  final CustomRecordController controller;
  final CustomDTO model;
  final int index;
  final List dataArr;
  final String bottomContactsCountText;
  final Function(CustomDTO model)? onClickCell;
  final Function(dynamic model)? onClickTopCell;

  @override
  Widget build(BuildContext context) {
    if (index == 0) return _buildHeader(context);
    return _buildCell();
  }

  // 头部：新的朋友、群聊、标签、公众号
  Widget _buildHeader(context) {

    Widget searchBar = Column(children: [
      Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          flex: 1,
          child: Container(
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
              hintText: '请输入客户名称',
              //onChanged: (value) => controller.searchCustom(value),
            ),
          ),
        ),
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
      ]),
      Container(
              padding: EdgeInsets.symmetric(vertical: 8.w),
              width: double.infinity,
              color: Colors.white12,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      //height: 90.w,
                        padding: EdgeInsets.only(left: 40.w),
                        child: Row(children: [
                          Text(
                            '欠款人数： ',
                            style: TextStyle(
                              color: Colours.text_ccc,
                              fontSize: 26.w,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '1213',
                              // controller.state.totalCreditCustom
                              //     .toString(),
                              style: TextStyle(
                                  color: Colours.primary,
                                  fontSize: 28.w,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ])),
                  ),
                  Expanded(
                    child: Container(
                        child: Row(children: [
                          Text(
                            '欠款金额： ',
                            style: TextStyle(
                                color: Colours.text_ccc, fontSize: 24.w),
                          ),
                          Expanded(
                            child: Text(
                          '1000',
                              // DecimalUtil.formatDecimal(
                              //     controller.state.totalCreditAmount,
                              //     scale: 0),
                              style: TextStyle(
                                  color: Colours.primary,
                                  fontSize: 28.w,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ])),
                  ),
                ],
              ),
            ),
    ]);


    List<Widget> topWidgetList = [searchBar];

    return Column(children: topWidgetList);
  }

  // Cell
  Widget _buildCell() {
    String susTag = model.getSuspensionTag();
    double cellH = _cellHeight;
    double leftSpace = 65.0;
    double imgWH = 40;
    Widget cell = JhSetCell(
      titleWidth: 200,
      leftImgWH: imgWH,
      cellHeight: cellH,
      lineLeftEdge: leftSpace,
      customDTO: model,
      controller: controller,
      leftWidget: Container(
        height: imgWH,
        width: imgWH,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Center(
          child: Text(susTag.substring(0, 1), style: const TextStyle(color: Colors.purple, fontSize: 20)),
        ),
      ),
      clickCallBack: () => onClickCell?.call(model),
    );

    return Column(
      children: <Widget>[
        Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.2,
            children: [
              CustomSlidableAction(
                backgroundColor: Colors.black54,
                child: const Text(
                  '备注',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
                ),
                onPressed: (context) {

                },
              ),
            ],
          ),
          child: cell,
        ),
        Offstage(
          offstage: dataArr[dataArr.length - 1].id != model.id,
          child: Container(
            width: double.infinity,
            height: cellH,
            alignment: Alignment.center,
            child: Text(bottomContactsCountText, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          ),
        ),
      ],
    );
  }
}
