import 'package:flutter/cupertino.dart';
import 'package:ledger/entity/productOwner/supplier_dto.dart';

class ProductOwnerListState {
  ProductOwnerListState() {
    ///Initialize variables
  }

  TextEditingController productOwnerNameController = TextEditingController();

  bool isSelectSupplier = true;

 List<SupplierDTO>  productOwnerList = [];

}
