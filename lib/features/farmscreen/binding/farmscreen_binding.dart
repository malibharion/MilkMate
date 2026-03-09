// lib/features/farmscreen/binding/farmscreen_binding.dart
import 'package:get/get.dart';
import '../contrller/farmscreen_controller.dart';

class FarmscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FarmscreenController>(() => FarmscreenController());
  }
}
