import 'package:dairy_farm_app/features/Milk/bindings/milk_binding.dart';
import 'package:dairy_farm_app/features/Transaction/binding/transaction_binding.dart';
import 'package:dairy_farm_app/features/bottom_navbar/controller/bottom_navbar_controller.dart';
import 'package:dairy_farm_app/features/customers/binding/customer_controller_binding.dart';
import 'package:dairy_farm_app/features/dashboard/binding/dashboard_binding.dart';
import 'package:dairy_farm_app/features/profile/binding/profile_binding.dart';
import 'package:get/get.dart';

class BottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavController>(() => BottomNavController());
    DashboardBinding().dependencies();
    CustomersBinding().dependencies();
    MilkBinding().dependencies();
    TransactionsBinding().dependencies();
    ProfileBinding().dependencies();
  }
}
