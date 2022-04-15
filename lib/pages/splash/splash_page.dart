import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

 Future<void> _loadResources() async{
    await Get.find<PopularProductController>().getPopularProductList() ;
    await Get.find<RecommendedProductController>().getRecommendedProductList() ;
  }

  @override
  void initState() {
  _loadResources();
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    );

    Timer(
        Duration(seconds: 5), (){
      Get.offNamed(RouteHelper.getInitial());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
              child: Center(child: Image.asset("assets/image/logo part 1.png",width: 80.w,),),),
          Center(child: Image.asset("assets/image/logo part 2.png",width: 80.w,)),
        ],
      ),
    );
  }
}
