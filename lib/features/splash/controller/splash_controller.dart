// lib/features/splash/controller/splash_controller.dart
import 'package:dairy_farm_app/core/services/storage_services.dart';
import 'package:get/get.dart';
import '../../../app/routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigate();
  }

  Future<void> _navigate() async {
    // Show splash for 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    if (!StorageService.hasFarm) {
      Get.offAllNamed(AppPages.farmscreen);
      return;
    }

    if (!StorageService.isLoggedIn) {
      Get.offAllNamed(AppPages.login);
      return;
    }

    Get.offAllNamed(AppPages.bottomnavbar);
  }
}
