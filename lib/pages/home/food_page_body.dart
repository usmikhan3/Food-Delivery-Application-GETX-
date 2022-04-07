import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icons_and_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  _FoodPageBodyState createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPagevalue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPagevalue = pageController.page!;
        print("current value is " + _currentPagevalue.toString());
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //TODO: slider section
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return popularProducts.isLoaded?Container(
            //color: Colors.red,
            height: 40.h,
            child: PageView.builder(
              controller: pageController,
              itemCount: popularProducts.popularProductList.length,
              itemBuilder: (context, position) {
                return _buildPageItem(position, popularProducts.popularProductList[position]);
              },
            ),
          )
              :Center(
            child: CircularProgressIndicator(),
          );
        }),
        //TODO: dots
       GetBuilder<PopularProductController>(builder: (popularProducts){
         return  DotsIndicator(
           dotsCount: popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length,
           position: _currentPagevalue,
           decorator: DotsDecorator(
               size: const Size.square(9.0),
               activeSize: const Size(18.0, 9.0),
               //color: Colors.black87, // Inactive color
               activeColor: AppColors.mainColor,
               activeShape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(5.0))),
         );
       }),

        //popular Text
        SizedBox(
          height: 3.h,
        ),
        //TODO: recommended heading
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(
                  text: "Food pairing",
                  color: Colors.black26,
                ),
              ),
            ],
          ),
        ),

        //TODO:recommended List of food and images
        GetBuilder<RecommendedProductController>(
             builder: (recommendedProduct){
               print(recommendedProduct.recommendedProductList);
          return recommendedProduct.isLoaded ?
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recommendedProduct.recommendedProductList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  Get.toNamed(RouteHelper.getRecommendedFood(index,"home"));
                },
                child: Container(
                  margin: EdgeInsets.only(
                    left: 4.w,
                    right: 4.w,
                    bottom: 3.h,
                  ),
                  child: Row(
                    children: [
                      //image container
                      Container(
                        width: 30.w,
                        height: 16.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white38,
                          image:  DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+recommendedProduct.recommendedProductList[index].img!),
                          ),
                        ),
                      ),

                      //text container
                      Expanded(
                        child: Container(
                          height: 15.h,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              )),
                          child: Padding(
                            padding: EdgeInsets.only(left: 3.w, right: 2.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BigText(text: recommendedProduct.recommendedProductList[index].name!),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                SmallText(
                                  text:'With Chinese Characteristics',
                                  //recommendedProduct.recommendedProductList[index].description!,
                                  color: Colors.black54,

                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: const [
                                    IconAndTextWidget(
                                      icon: Icons.circle_sharp,
                                      text: "Normal",
                                      iconColor: AppColors.iconColor1,
                                    ),
                                    IconAndTextWidget(
                                      icon: Icons.location_on,
                                      text: "1.7Km",
                                      iconColor: AppColors.mainColor,
                                    ),
                                    IconAndTextWidget(
                                      icon: Icons.access_time_rounded,
                                      text: "32 min",
                                      iconColor: AppColors.iconColor2,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ):Center(child: CircularProgressIndicator(),);
        })
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currentPagevalue.floor()) {
      var currentScale =
          1 - (_currentPagevalue - index) * (1 - _scaleFactor);
      var currentTrans = _height = (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _currentPagevalue.floor() + 1) {
      var currentScale = _scaleFactor +
          (_currentPagevalue - index + 1) * (1 - _scaleFactor);
      var currentTrans = _height = (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _currentPagevalue.floor() - 1) {
      var currentScale =
          1 - (_currentPagevalue - index) * (1 - _scaleFactor);
      var currentTrans = _height = (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else {
      var currentScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor), 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getPopularFood(index,"home"));
              },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven ? Colors.yellow : Colors.blue,
                image:  DecorationImage(
                    image: NetworkImage(
                      AppConstants.BASE_URL+AppConstants.UPLOAD_URL +popularProduct.img!,
                    ),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 2.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    //blurRadius: 5,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    //blurRadius: 5,
                    offset: Offset(5, 0),
                  )
                ],
              ),
              child: Container(
                  padding: EdgeInsets.only(
                      top: 1.h,
                      left: 2.w,
                      right: 2.w,
                  bottom: 1.h,),
                  child:  AppColumn(text: popularProduct.name!)),
            ),
          ),
        ],
      ),
    );
  }
}
