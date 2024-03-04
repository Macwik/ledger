import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:ledger/entity/product/product_classify_dto.dart';
import 'package:ledger/entity/product/product_detail_dto.dart';
import 'package:ledger/entity/unit/unit_detail_dto.dart';

class ProductDetailState {
  final formKey = GlobalKey<FormBuilderState>();

  int? selectedSalesType = 0 ;

  bool isEdit = false;


  //商品类型选择
  int? productType;
  String? productTypeDesc;

  //供应商选择
  int? supplierId;
  String? supplier;

//单位
  UnitDetailDTO? unitDetailDTO;

  CustomDTO? customDTO;

  ProductDetailDTO? productDetailDTO;

  TextEditingController nameController= TextEditingController();
  TextEditingController standardController= TextEditingController();
  TextEditingController priceController= TextEditingController();
  TextEditingController addressController= TextEditingController();
  TextEditingController remarkController = TextEditingController();

  int? id;

  ProductClassifyDTO? productClassifyDTO ;

  String? productClassifyName;

  int? productClassifyId;
}
