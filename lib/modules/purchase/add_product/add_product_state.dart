import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:ledger/entity/product/product_classify_dto.dart';
import 'package:ledger/entity/unit/unit_detail_dto.dart';

class AddProductState {
  UnitDetailDTO? unitDetailDTO;

  //选择商品分类
  ProductClassifyDTO? productClassifyDTO;

  CustomDTO? customDTO;
  int saleChannel = 0;

  final formKey = GlobalKey<FormBuilderState>();

  final TextEditingController textEditingController = TextEditingController();

  final TextEditingController remarkTextEditingController =
      TextEditingController();

  final TextEditingController priceTextEditingController =
      TextEditingController();

  final TextEditingController productPlaceTextEditingController =
      TextEditingController();

  final TextEditingController standardTextEditingController =
      TextEditingController();
}
