import 'package:get/get.dart';

class DashboardController extends GetxController {
  final staffName = 'Staff'.obs;
  final farmName = 'MilkMate Dairy Farm'.obs;
  final isLoading = false.obs;

  // ── Summary values ──
  final milkCollected = 0.0.obs;
  final milkCollectedDelta = 0.0.obs;
  final milkSold = 0.0.obs;
  final milkSoldDelta = 0.0.obs;
  final paymentsReceived = 0.0.obs;
  final paymentsReceivedDelta = 0.0.obs;
  final expensesAdded = 0.0.obs;
  final expensesAddedDelta = 0.0.obs;

  // ── Recent activity list ──
  // Each map keys: title, subtitle, timeAgo, type
  // type values: 'milkProduction' | 'payment' | 'milkSale' | 'expense'
  final activities = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }

  void loadDashboardData() {
    isLoading.value = true;

    // Replace with your real API call later
    Future.delayed(const Duration(milliseconds: 600), () {
      milkCollected.value = 1320;
      milkCollectedDelta.value = 53.07;
      milkSold.value = 800;
      milkSoldDelta.value = 13.00;
      paymentsReceived.value = 750;
      paymentsReceivedDelta.value = 12.00;
      expensesAdded.value = 700;
      expensesAddedDelta.value = 13.00;

      activities.assignAll([
        {
          'title': 'Milk production added by Ahmed',
          'subtitle': 'Milk production added by Ahmed',
          'timeAgo': '1 days ago',
          'type': 'milkProduction',
        },
        {
          'title': 'Payment received from customer',
          'subtitle': 'Payment received from customer',
          'timeAgo': '3 days ago',
          'type': 'payment',
        },
        {
          'title': 'Milk sale recorded',
          'subtitle': 'Milk sale recorded for Ahmeds',
          'timeAgo': '3 days ago',
          'type': 'milkSale',
        },
        {
          'title': 'Expense added for cattle feed',
          'subtitle': 'Expense added for cattle feed',
          'timeAgo': '3 days ago',
          'type': 'expense',
        },
      ]);

      isLoading.value = false;
    });
  }

  void onAddMilkProduction() {
    // Get.toNamed(AppRoutes.addMilkProduction);
  }

  void onAddMilkSale() {
    // Get.toNamed(AppRoutes.addMilkSale);
  }

  void onAddPayment() {
    // Get.toNamed(AppRoutes.addPayment);
  }

  void onAddExpense() {
    // Get.toNamed(AppRoutes.addExpense);
  }
}
