import 'package:get/get.dart';
import 'package:amarsolution_multikart/src/features/product/model/product_details_model.dart';

class VariantSelectorBottomSheetController extends GetxController {
  final _selectedVariant = Rxn<Barcode>();
  final _selectedColor = Rxn<String>();
  final _quantity = 1.obs;

  Barcode? get selectedVariant => _selectedVariant.value;

  String? get selectedColor => _selectedColor.value;

  int get quantity => _quantity.value;

  void updateVariant(Barcode? variant){
    _selectedVariant.value = variant;
  }

  void updateColor(String color){
    _selectedColor.value = color;
  }

  void updateQuantity(int quantity){
    _quantity.value = quantity;
  }

  void clearAll(){
    _selectedVariant.value = null;
    _selectedColor.value = null;
    _quantity.value = 1;
  }
}
