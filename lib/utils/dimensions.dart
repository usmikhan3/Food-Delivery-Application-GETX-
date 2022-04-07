import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageViewContainer = screenHeight / 3.45;
  static double pageViewTextContainer = screenHeight / 6.325;
  static double pageView = screenHeight / 2.371;

  //dynamic height padding and margin
  static double height10 = screenHeight / 75.9;
  static double height20 = screenHeight / 37.95;
  static double height30 = screenHeight / 25.3;
  static double height15 = screenHeight / 50.6;
  static double height45 = screenHeight / 16.86;

  //dynamic width padding and margin

  // static double width15 = screenWidth / 26.13;
  // static double width10 = screenWidth / 39.2;
  // static double width20 = screenWidth / 19.6;
  // static double width30 = screenWidth / 13.06;
  // static double width45 = screenWidth / 8.71;

  static double width15 = screenHeight / 50.6;
  static double width10 = screenHeight / 75.9;
  static double width20 = screenHeight / 37.95;
  static double width30 = screenHeight / 25.3;
  static double width45 = screenHeight / 16.86;

  //dynamix font size
  static double font20 = screenHeight / 40.95;
  static double font12 = screenHeight / 63.25;

  //dynamic radius
  static double radius20 = screenHeight / 37.95;
  static double radius30 = screenHeight / 25.3;
  static double radius15 = screenHeight / 50.6;

  //iconSize
  static double iconSize24 = screenHeight / 31.625;

  //listView size
  static double listViewImgSize = screenWidth / 3.26;
  static double listViewTextContSize = screenWidth / 3.92;
}
