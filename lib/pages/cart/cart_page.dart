import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 7.h,
              left: 3.w,
              right: 3.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: 3.h,
                    size: 5.h,
                  ),
                  SizedBox(
                    width: 25.w,
                  ),
                  GestureDetector(

                      onTap:(){
                        Get.toNamed(RouteHelper.getInitial());
                        print("home");
                      },

                    child: AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: 3.h,
                      size: 5.h,
                    ),
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: 3.h,
                    size: 5.h,
                  ),
                ],
              )),
          Positioned(
            top: 15.h,
            left: 3.w,
            right: 3.w,
            bottom: 0,
            child: Container(
              //color: Colors.red,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(

                  builder: (controller){
                    var _cartList = controller.getItems;
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.getItems.length,
                        itemBuilder: (_, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 1.h),
                            height: 15.h,
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap:(){
                                    var popularIndex = Get.find<PopularProductController>()
                                        .popularProductList
                                        .indexOf(_cartList[index].product!);

                                    if(popularIndex>=0){
                                        Get.toNamed(RouteHelper.getPopularFood(popularIndex,"cartpage"));
                                    }else{
                                      var recommendedIndex = Get.find<RecommendedProductController>()
                                          .recommendedProductList
                                          .indexOf(_cartList[index].product!);
                                      Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,"cartpage"));
                                    }

                                  },
                                  child: Container(
                                    width: 25.w,
                                    height: 15.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image:NetworkImage(

                                              AppConstants.BASE_URL + AppConstants.UPLOAD_URL + controller.getItems[index].img.toString()
                                            )
                                        )
                                    ),
                                  ),
                                ),
                                SizedBox(width: 2.w,),
                                Expanded(
                                  child: Container(
                                    height: 15.h,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BigText(text: controller.getItems[index].name.toString(),color:Colors.black54),
                                        SmallText(text: "Spicy"),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(text: "\$ ${controller.getItems[index].price}",color:Colors.redAccent),
                                            Container(
                                              padding:
                                              EdgeInsets.only(top: 1.5.h, bottom: 1.5.h, left: 3.w, right: 3.w),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap:(){
                                                      controller.addItem(_cartList[index].product!, -1);
                                                    },
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: AppColors.signColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  BigText(
                                                      text:_cartList[index].quantity.toString()
                                                    //popularProduct.inCartItems.toString()
                                                  ),
                                                  SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  GestureDetector(
                                                    onTap: (){
                                                      controller.addItem(_cartList[index].product!, 1);

                                                    },
                                                    child: Icon(
                                                      Icons.add,
                                                      color: AppColors.signColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),

                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  },
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: GetBuilder<CartController>(
        builder: (controller){
          return Container(
            height: 12.h,
            padding: EdgeInsets.only(
              top: 2.h,
              bottom: 2.h,
              left: 3.w,
              right: 3.w,
            ),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: AppColors.buttonBackgroundColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                  EdgeInsets.only(top: 2.h, bottom: 2.h, left: 3.w, right: 3.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [

                      SizedBox(
                        width: 2.w,
                      ),
                      BigText(text:"\$ " +  controller.totalAmount.toString()),
                      SizedBox(
                        width: 2.w,
                      ),

                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    print("press checkout");
                    controller.addToHistory();
                  },
                  child: Container(
                    padding:
                    EdgeInsets.only(top: 2.h, bottom: 2.h, left: 3.w, right: 3.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.mainColor,
                    ),
                    child: BigText(
                      text: "Check Out",
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
