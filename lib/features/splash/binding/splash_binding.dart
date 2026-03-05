import 'package:dairy_farm_app/features/splash/controller/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
    print("Debug: SplashBinding dependencies called");
  }
}
