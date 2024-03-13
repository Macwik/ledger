import 'package:decimal/decimal.dart';
import 'package:ledger/entity/product/product_shopping_car_dto.dart';

class ShoppingCarListState {
  ShoppingCarListState() {
    ///Initialize variables
  }

  Decimal totalAmount = Decimal.zero;

  Decimal totalNumber = Decimal.zero;

  List<ProductShoppingCarDTO> shoppingCarList =[];
}
