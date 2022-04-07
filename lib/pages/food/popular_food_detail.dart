import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text.dart';
import 'package:food_delivery/widgets/icons_and_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
   Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //TODO: background image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: 45.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!,)),
              ),
            ),
          ),
          //TODO: Icon widgets
          Positioned(
            top: 5.h,
            left: 3.w,
            right: 3.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap:(){

                      if(page=="cartpage"){
                        Get.toNamed(RouteHelper.getCartPage());
                      }else{
                        Get.toNamed(RouteHelper.getInitial());
                      }
                    },
                    child: AppIcon(icon: Icons.arrow_back_ios)),
               GetBuilder<PopularProductController>(builder: (controller){
                 return GestureDetector(
                   onTap:(){
                     if(controller.totalItems>=1)
                       Get.toNamed(RouteHelper.getCartPage());
                   },
                   child: Stack(
                     children: [
                       AppIcon(icon: Icons.shopping_cart_outlined),
                       Get.find<PopularProductController>().totalItems>=1?
                          Positioned(
                              right:0,
                              top: 0,
                              child: AppIcon(icon: Icons.circle,size: 3.h,iconColor: Colors.transparent,backgroundColor: AppColors.mainColor,),
                          )
                       :Container(),
                       Get.find<PopularProductController>().totalItems>=1?
                       Positioned(
                         right:1.w,
                         top: 0.5.h,
                         child: BigText(text: Get.find<PopularProductController>().totalItems.toString(),size: 8.sp,color: Colors.white,),
                       )
                           :Container(),
                     ],
                   ),
                 );
               })
              ],
            ),
          ),
          //TODO: Introcuction heading
          Positioned(
            left: 0,
            right: 0,
            top: 42.h,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 2.h),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   AppColumn(
                    text: product.name!,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  BigText(text: "Introduce"),
                  SizedBox(
                    height: 2.h,
                  ),
                   Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(
                          text: product.description!),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct){
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
                      GestureDetector(
                        onTap:(){
                          popularProduct.setQuantity(false);
                        },
                        child: Icon(
                          Icons.remove,
                          color: AppColors.signColor,
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      BigText(text: popularProduct.inCartItems.toString()),
                      SizedBox(
                        width: 2.w,
                      ),
                      GestureDetector(
                        onTap: (){
                          popularProduct.setQuantity(true);
                        },
                        child: Icon(
                          Icons.add,
                          color: AppColors.signColor,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    popularProduct.addItem(product);
                  },
                  child: Container(
                    padding:
                    EdgeInsets.only(top: 2.h, bottom: 2.h, left: 3.w, right: 3.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.mainColor,
                    ),
                    child: BigText(
                      text: "\$ ${product.price!} | Add to Cart",
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
