import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList();

    Map<String, int> cartItemsPerOrder = Map();
    
    for(int i=0;i<getCartHistoryList.length;i++){
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      }else{
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    List<int> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<int> itemsPerOrder= cartOrderTimeToList();

    var listCounter = 0;

    return Scaffold(
     
      body: Column(
        children: [
          SafeArea(
            child: Container(
              height: 8.h,
              color: AppColors.mainColor,
              width: double.maxFinite,
              //padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BigText(text: "Cart History",color: Colors.white,),
                    AppIcon(icon: Icons.shopping_cart_outlined,backgroundColor: AppColors.yellowColor,)
                  ],
                ),
              ),
            ),
          ),
          
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 2.h,left: 2.w,right: 2.h),
            child: ListView(
              children: [
               for(int i =0;i<itemsPerOrder.length;i++)
                 BigText(text: "hello"),
              ],
            ),
            ),
          ),
        ],
      ),
    );
  }
}
