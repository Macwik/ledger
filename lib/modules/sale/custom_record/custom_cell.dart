// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ledger/entity/custom/custom_dto.dart';
// import 'package:ledger/modules/sale/custom_record/custom_record_controller.dart';
// import 'package:ledger/res/colors.dart';
// import 'package:ledger/util/decimal_util.dart';
//
// const double _imgWH = 22.0; // 左侧图片宽高
// const double _titleSpace = 100.0; // 左侧title默认宽
// const double _cellHeight = 50.0; // 输入、选择样式一行的高度
// const double _leftEdge = 15.0; // 内部Widget 左边距 15
// const double _rightEdge = 10.0; // 内部Widget 左边距 10
// const double _lineLeftEdge = 15.0; // 线 左间距 默认 15
// const double _lineRightEdge = 0; // 线 右间距 默认  0
// const double _lineHeight = 0.6; // 底部线高
// const double _titleFontSize = 15.0;
// const double _textFontSize = 15.0;
//
// typedef _ClickCallBack = void Function();
//
// class CustomCell extends StatefulWidget {
//   const CustomCell({
//     super.key,
//     this.leftWidget,
//     this.text = '',
//     this.clickCallBack,
//     this.titleWidth = _titleSpace,
//     this.titleStyle,
//     this.textStyle,
//     this.hiddenLine = false,
//     this.lineLeftEdge = _lineLeftEdge,
//     this.lineRightEdge = _lineRightEdge,
//     this.bgColor,
//     this.cellHeight = _cellHeight,
//     this.leftImgWH = _imgWH,
//     this.textAlign = TextAlign.right,
//     this.customDTO,
//     this.controller,
//   });
//
//   final Widget? leftWidget; // 左侧widget ，默认隐藏
//   final String? text;
//   final CustomDTO? customDTO;
//   final _ClickCallBack? clickCallBack;
//   final double titleWidth; // 标题宽度
//   final TextStyle? titleStyle;
//   final TextStyle? textStyle;
//   final bool hiddenLine; // 隐藏底部横线
//   final double lineLeftEdge; // 底部横线左侧距离 默认_leftEdge
//   final double lineRightEdge; // 底部横线右侧距离 默认0
//   final Color? bgColor; // 背景颜色，默认白色
//   final double cellHeight; // cell高度 默认_cellHeight
//   final double leftImgWH; // 左侧图片宽高，默认_imgWH
//   final TextAlign textAlign; // 默认靠右
//   final CustomRecordController? controller;
//
//   @override
//   _CustomCellState createState() => _CustomCellState();
// }
//
// class _CustomCellState extends State<CustomCell> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _body();
//   }
//
//   _body() {
//     // 默认颜色
//     var bgColor = Colors.white;
//     var titleColor = Colors.black;
//     var titleStyle = TextStyle(fontSize: _titleFontSize, color: titleColor);
//     var textColor = Colors.black;
//     var textStyle = TextStyle(fontSize: _textFontSize, color: textColor);
//     var lineColor = Colors.transparent;
//
//     // 设置的颜色优先级高于暗黑模式
//     bgColor = bgColor;
//     titleStyle = widget.titleStyle ?? titleStyle;
//     textStyle = widget.textStyle ?? textStyle;
//
//     return Material(
//       color: bgColor,
//       child: InkWell(
//         onTap: () => widget.clickCallBack?.call(),
//         child: Container(
//           constraints: BoxConstraints(
//             minWidth: double.infinity, // 宽度尽可能大
//             minHeight: widget.cellHeight, // 最小高度为50像素
//           ),
//           padding: const EdgeInsets.fromLTRB(_leftEdge, 0, _rightEdge, 0),
//           decoration: UnderlineTabIndicator(
//             borderSide: BorderSide(
//               width: _lineHeight,
//               color: widget.hiddenLine == true ? Colors.transparent : lineColor,
//             ),
//             insets: EdgeInsets.fromLTRB(
//                 widget.lineLeftEdge, 0, widget.lineRightEdge, 0),
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               widget.leftWidget ?? Container(),
//               SizedBox(width: 10),
//               Expanded(
//                   child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                           child: Offstage(
//                         offstage:
//                             widget.customDTO?.customName?.isEmpty ?? false,
//                         child: SizedBox(
//                             // width: widget.titleWidth,
//                             child: Text(widget.customDTO?.customName ?? '',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 34.sp,
//                                   color: widget.customDTO?.invalid == 1
//                                       ? Colours.text_ccc
//                                       : Colours.text_333,
//                                 ))),
//                       )),
//                       Visibility(
//                         visible: widget.customDTO?.invalid == 1,
//                         child: Container(
//                           padding: EdgeInsets.only(
//                               top: 2.w, bottom: 2.w, left: 4.w, right: 4.w),
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: Colours.text_ccc,
//                               width: 1.0,
//                             ),
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                           child: Text('停',
//                               style: TextStyle(
//                                 color: Colours.text_999,
//                                 fontSize: 26.sp,
//                                 fontWeight: FontWeight.w500,
//                               )),
//                         ),
//                       )
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         '欠款：',
//                         style: TextStyle(
//                           color: Colours.text_ccc,
//                           fontSize: 26.sp,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       Text(
//                         DecimalUtil.formatAmount(
//                             widget.customDTO?.creditAmount),
//                         style: TextStyle(
//                           color: widget.customDTO?.invalid == 1
//                               ? Colours.text_ccc
//                               : Colours.text_666,
//                           fontSize: 26.sp,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               )),
//               Visibility(
//                   visible: widget.controller?.state.isSelectCustom != true,
//                   child: IconButton(
//                       onPressed: () => widget.controller
//                           ?.showBottomSheet(context, widget.customDTO),
//                       icon: Icon(Icons.more_vert, color: Colors.grey))),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
