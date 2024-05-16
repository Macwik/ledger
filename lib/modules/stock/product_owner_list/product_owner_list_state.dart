import 'package:flutter/cupertino.dart';
import 'package:ledger/entity/productOwner/supplier_dto.dart';

class ProductOwnerListState {
  ProductOwnerListState() {
    ///Initialize variables
  }

  TextEditingController productOwnerNameController = TextEditingController();

  TextEditingController productOwnerRemarkController = TextEditingController();

  bool isSelectSupplier = true;

 List<SupplierDTO>  productOwnerList = [];

  int? invalid = 0;

  String? supplierName ='';

}
