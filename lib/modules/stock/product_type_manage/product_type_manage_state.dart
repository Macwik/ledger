import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ledger/entity/product/product_classify_dto.dart';
import 'package:ledger/entity/product/product_classify_list_dto.dart';
import 'package:ledger/enum/is_select.dart';

class ProductTypeManageState {
  ProductTypeManageState() {
    ///Initialize variables
  }

  List<ProductClassifyDTO>? productClassifyList;
//编辑货物分类
  TextEditingController productClassifyNameController = TextEditingController();
  TextEditingController productClassifyRemarkController = TextEditingController();

//新增货物分类
  TextEditingController addProductClassifyName = TextEditingController();
  TextEditingController addProductClassifyRemark = TextEditingController();

  IsSelectType ? isSelectType;

  final formKey = GlobalKey<FormBuilderState>();
}
