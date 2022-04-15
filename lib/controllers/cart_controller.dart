import 'package:flutter/material.dart';
import 'package:food_delivery/data/repository/cart_repository.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};

  Map<int, CartModel> get items => _items;

  //only for storage and sharedprefernces
  List<CartModel> storageItems = [];

  void addItem(ProductModel product, int quantity) {
    // print("length of the item is: "+ _items.length.toString());
    var totalQuantity = 0;
    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
            id: value.id,
            name: value.name,
            img: value.img,
            price: value.price,
            quantity: value.quantity! + quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product);
      });
      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          return CartModel(
              id: product.id!,
              name: product.name!,
              img: product.img!,
              price: product.price!,
              quantity: quantity,
              isExist: true,
              time: DateTime.now().toString(),
              product: product);
        });
      } else {
        Get.snackbar("Item Count", "You should at least an item in the cart",
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
      }
    }

    cartRepo.addToCartList(getItems);

    update();
  }

  bool existingCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product) {
    var quanitity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quanitity = value.quantity!;
        }
      });
    }
    return quanitity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;

    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

    List<CartModel> getCartData(){


      setCart = cartRepo.getCartList();

      return storageItems;
    }

    set setCart(List<CartModel> items){
      storageItems = items;
      //print("length of cart items " + storageItems.length.toString());
      for(int i=0; i<storageItems.length;i++){
        _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
      }
  }

  void addToHistory(){
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear(){
    _items = {};
    update();

  }

  List<CartModel> getCartHistoryList(){
    return cartRepo.getCartHistoryList();
  }




}
