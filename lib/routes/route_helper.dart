import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/pages/food/recommnded_food_detail.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:get/get.dart';

class RouteHelper{
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendFood = "/recommended-food";
  static const String cartPage = "/cart-page";

  static String getInitial()=>'$initial';
  static String getPopularFood(int pageId,String page)=>'$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId,String page)=>'$recommendFood?pageId=$pageId&page=$page';
  static String getCartPage()=>'$cartPage';

  static List<GetPage> routes = [
    GetPage(name: initial, page:(){
      return MainFoodPage();
    },

    ),
    GetPage(name: popularFood, page:(){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
     return PopularFoodDetail(pageId:int.parse(pageId!),page:page!);
    },
      transition: Transition.circularReveal,
    ),
    GetPage(name: recommendFood, page:(){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return RecommendedFoodDetail(pageId: int.parse(pageId!),page: page!,);
    },
      transition: Transition.circularReveal,
    ),
    GetPage(name: cartPage, page:(){
      return CartPage();
    },
      transition: Transition.circularReveal,
    ),
  ];
}