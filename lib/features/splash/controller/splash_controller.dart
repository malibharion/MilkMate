import 'package:dairy_farm_app/app/routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("Debug: SplashController onInit called");
    _navigateToLogin();
  }

  void _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 7));

    Get.offAllNamed(AppPages.login);
  }
}
