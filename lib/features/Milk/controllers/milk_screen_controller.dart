import 'package:dairy_farm_app/app/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MilkController extends GetxController {
  final isLoading = false.obs;

  // ── Today's Summary ──
  final milkCollectedToday = 0.0.obs;
  final milkCollectedDelta = 0.0.obs;
  final milkSoldToday = 0.0.obs;
  final milkSoldDelta = 0.0.obs;
  final pendingSalesApproval = 0.0.obs;
  final expenseSales = 0.0.obs;

  // ── Chart: last 7 days production ──
  // Each map: day (label), liters
  final chartData = <Map<String, dynamic>>[].obs;

  // ── Recent milk activity ──
  // Keys: title, subtitle, timeAgo, status ('', 'pending', 'approved')
  final activities = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    isLoading.value = true;

    Future.delayed(const Duration(milliseconds: 600), () {
      milkCollectedToday.value = 1320;
      milkCollectedDelta.value = 53.07;
      milkSoldToday.value = 800;
      milkSoldDelta.value = 13.00;
      pendingSalesApproval.value = 70;
      expenseSales.value = 100;

      chartData.assignAll([
        {'day': 'Mon', 'liters': 85.0},
        {'day': 'Tue', 'liters': 60.0},
        {'day': 'Wed', 'liters': 110.0},
        {'day': 'Thu', 'liters': 75.0},
        {'day': 'Fri', 'liters': 130.0},
        {'day': 'Sat', 'liters': 95.0},
        {'day': 'Sun', 'liters': 115.0},
      ]);

      activities.assignAll([
        {
          'title': 'Milk Production Added',
          'subtitle': '120L – Today',
          'timeAgo': '1 days ago',
          'status': '',
          'type': 'production',
        },
        {
          'title': 'Milk Sale to Ahmed',
          'subtitle': '40L – Pending Approval',
          'timeAgo': '3 days ago',
          'status': 'pending',
          'type': 'sale',
        },
        {
          'title': 'Milk Sale to Ali',
          'subtitle': '30L – Approved',
          'timeAgo': '3 days ago',
          'status': 'approved',
          'type': 'sale',
        },
      ]);

      isLoading.value = false;
    });
  }

  void onAddMilkProduction() {
    Get.toNamed(AppPages.addMilkProduction);
  }

  void onAddMilkSale() {
    Get.toNamed(AppPages.addMilkSale);
  }

  void onAddMilkEntry() {
    // Get.toNamed(AppRoutes.addMilkEntry);
  }
}
