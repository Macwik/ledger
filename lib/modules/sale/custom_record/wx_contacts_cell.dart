///  wx_contacts_cell.dart
///
///  Created by iotjin on 2019/08/14.
///  description: 微信通讯录 cell

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
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
  });

  final CustomDTO model;
  final int index;
  final List dataArr;
  final String bottomContactsCountText;
  final Function(dynamic model)? onClickCell;
  final Function(dynamic model)? onClickTopCell;

  @override
  Widget build(BuildContext context) {
    if (index == 0) return _buildHeader(context);
    return _buildCell();
  }

  // 头部：新的朋友、群聊、标签、公众号
  Widget _buildHeader(context) {

    // Widget topCell(context, itemData) {
    //   double cellH = 55.0;
    //   double leftSpace = 65.0;
    //   double imgWH = 40;
    //
    //   return JhSetCell(
    //     leftImgWH: imgWH,
    //     cellHeight: cellH,
    //     lineLeftEdge: leftSpace,
    //     title: itemData['title'],
    //     hiddenArrow: true,
    //     leftWidget: Container(
    //       height: imgWH,
    //       width: imgWH,
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(3),
    //         image: DecorationImage(
    //           fit: BoxFit.fitHeight,
    //           image: AssetImage(
    //             itemData['imgUrl'],
    //           ),
    //         ),
    //       ),
    //     ),
    //     clickCallBack: () => onClickTopCell?.call(itemData),
    //   );
    // }


    Widget searchBar = Flex(
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
      ],
    );


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
      title: model.customName ?? '',
      hiddenArrow: true,
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
      clickCallBack: () => onClickCell?.call(model.toJson()),
    );

    return Column(
      children: <Widget>[
//        Offstage(
//          offstage: !model.isShowSuspension,
//          child: _buildSusWidget(susTag),
//        ),
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
