import 'package:flutter/cupertino.dart';
import 'package:ledger/entity/product/product_classify_dto.dart';
import 'package:ledger/entity/product/product_classify_list_dto.dart';
import 'package:ledger/enum/is_select.dart';

class ProductTypeManageState {
  ProductTypeManageState() {
    ///Initialize variables
  }
  ProductClassifyListDTO? productClassifyListDTO;

  List<ProductClassifyDTO>? productClassifyList;
//编辑货物分类
  TextEditingController productClassifyNameController = TextEditingController();
  TextEditingController productClassifyRemarkController = TextEditingController();

//新增货物分类
  TextEditingController addProductClassifyName = TextEditingController();
  TextEditingController addProductClassifyRemark = TextEditingController();

  IsSelectType ? isSelectType;
}
