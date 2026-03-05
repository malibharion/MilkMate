import 'package:dairy_farm_app/features/customers/controller/customer_controller.dart';
import 'package:get/get.dart';

class CustomersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomersController>(() => CustomersController());
  }
}
