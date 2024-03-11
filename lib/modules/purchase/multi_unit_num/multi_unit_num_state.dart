import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ledger/modules/purchase/multi_unit_num/option_item.dart';

class MultiUnitNumState {
  final formKeyWeight = GlobalKey<FormBuilderState>();
  final formKeyNum = GlobalKey<FormBuilderState>();


  List<OptionItem> options = [
    OptionItem(1, '箱'),
    OptionItem(2, '框'),
    OptionItem(3, '袋'),
    OptionItem(4, '盒'),
    OptionItem(5, '板'),
    OptionItem(6, '瓶'),
    OptionItem(7, '个'),
    OptionItem(8, '根'),
    OptionItem(9, '捆'),
    OptionItem(10, '份'),
    OptionItem(11, '层'),
    OptionItem(12, '桶'),
    OptionItem(13, '挂'),
    OptionItem(14, '提'),
    OptionItem(15, '篮'),
    OptionItem(16, '只'),
    OptionItem(17, '张'),
    OptionItem(18, '盘'),
    OptionItem(19, '串'),
    OptionItem(20, '条'),
    OptionItem(21, '杯'),
    OptionItem(22, '对'),
    OptionItem(23, '卷'),
  ];
  List<OptionItem> conversionOptions = [
    OptionItem(101, '斤'),
    OptionItem(102, '公斤'),
    OptionItem(103, '千克'),
    OptionItem(104, '吨'),
    OptionItem(105, '克'),
    OptionItem(106, '两'),
  ];

  OptionItem? selectedMasterOption;
  OptionItem? selectedSlaveOption;

  //单位类别  1 计重单位 | 2 计件单位
  int unitType = 1;

  TextEditingController conversionWeightController = TextEditingController();
  TextEditingController conversionNumController = TextEditingController();
}
