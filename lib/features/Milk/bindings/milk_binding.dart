import 'package:dairy_farm_app/features/Milk/controllers/milk_screen_controller.dart';
import 'package:get/get.dart';

class MilkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MilkController>(() => MilkController());
  }
}
