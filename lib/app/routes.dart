// lib/app/routes.dart
import 'package:dairy_farm_app/features/Milk/controllers/add_milk_production_controller.dart';
import 'package:dairy_farm_app/features/Milk/controllers/add_milk_sale_controller.dart';
import 'package:dairy_farm_app/features/Milk/screens/add_milk_sale_screen,.dart';
import 'package:dairy_farm_app/features/Milk/screens/add_milk_screen.dart';
import 'package:dairy_farm_app/features/Transaction/controllers/add_expanse_controller.dart';
import 'package:dairy_farm_app/features/Transaction/controllers/add_payment_controller.dart';
import 'package:dairy_farm_app/features/Transaction/screens/add_expanse_screen.dart';
import 'package:dairy_farm_app/features/Transaction/screens/add_payment_screen.dart';
import 'package:dairy_farm_app/features/auth/bindings/login_binding.dart';
import 'package:dairy_farm_app/features/auth/screens/login_screen.dart';
import 'package:dairy_farm_app/features/bottom_navbar/binding/bottom_navbar_binding.dart';
import 'package:dairy_farm_app/features/bottom_navbar/screen/bottom_navbar_screen.dart';
import 'package:dairy_farm_app/features/customers/controller/customer_detail_controller.dart';
import 'package:dairy_farm_app/features/customers/screens/customer_detail_screen.dart';
import 'package:dairy_farm_app/features/farmscreen/binding/farmscreen_binding.dart';
import 'package:dairy_farm_app/features/farmscreen/screen/farmscreen.dart';
import 'package:dairy_farm_app/features/splash/binding/splash_binding.dart';
import 'package:dairy_farm_app/features/splash/screens/splash_screen.dart';
import 'package:get/get.dart';

class AppPages {
  static const initialRoute = '/splash';
  static const login = '/login';
  static const farmscreen = '/farmscreen';
  static const bottomnavbar = '/bottomnavbar';
  static const customerDetail = '/customer-detail';
  static const addMilkProduction = '/add-milk-production';
  static const addMilkSale = '/add-milk-sale';
  static const addExpanse = '/add-expanse';
  static const addPayment = '/add-payment';

  static final routes = [
    // ── Splash ──
    GetPage(
      name: '/splash',
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),

    // ── Farm screen ──
    GetPage(
      name: '/farmscreen',
      page: () => const Farmscreen(),
      binding: FarmscreenBinding(),
    ),

    // ── Login ──
    GetPage(
      name: '/login',
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),

    // ── Main app ──
    GetPage(
      name: '/bottomnavbar',
      page: () => const BottomNavScreen(),
      binding: BottomNavBinding(),
    ),

    // ── Customer detail ──
    GetPage(
      name: '/customer-detail',
      page: () => const CustomerDetailScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => CustomerDetailController()),
      ),
    ),

    // ── Milk ──
    GetPage(
      name: '/add-milk-production',
      page: () => const AddMilkProductionScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => AddMilkProductionController()),
      ),
    ),
    GetPage(
      name: '/add-milk-sale',
      page: () => const AddMilkSaleScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => AddMilkSaleController()),
      ),
    ),

    // ── Transactions ──
    GetPage(
      name: '/add-expanse',
      page: () => const AddExpenseScreen(),
      binding: BindingsBuilder(() => Get.lazyPut(() => AddExpenseController())),
    ),
    GetPage(
      name: '/add-payment',
      page: () => const AddPaymentScreen(),
      binding: BindingsBuilder(() => Get.lazyPut(() => AddPaymentController())),
    ),
  ];
}
