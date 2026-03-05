import 'package:dairy_farm_app/app/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomersController extends GetxController {
  final searchController = TextEditingController();
  final searchQuery = ''.obs;

  final isLoading = false.obs;

  // ── Stats ──
  final totalCustomers = 0.obs;
  final activeCustomers = 0.obs;
  final pendingBalance = 0.obs;

  // ── Full customer list ──
  // Keys: name, phone, litersPerDay, balance (String, positive = '+', negative = '-')
  final _allCustomers = <Map<String, String>>[].obs;

  // ── Filtered list (bound to UI) ──
  final filteredCustomers = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCustomers();

    // Live search — filter on every keystroke
    searchController.addListener(() {
      searchQuery.value = searchController.text;
      _applyFilter();
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void loadCustomers() {
    isLoading.value = true;

    Future.delayed(const Duration(milliseconds: 600), () {
      totalCustomers.value = 259;
      activeCustomers.value = 63;
      pendingBalance.value = 3000;

      _allCustomers.assignAll([
        {
          'name': 'Ahmed Ali',
          'phone': '0300-1234567',
          'litersPerDay': '12',
          'balance': '+5000',
        },
        {
          'name': 'Sara Khan',
          'phone': '0301-9876543',
          'litersPerDay': '8',
          'balance': '-1500',
        },
        {
          'name': 'Bilal Raza',
          'phone': '0333-4561234',
          'litersPerDay': '15',
          'balance': '-3000',
        },
        {
          'name': 'Fatima Noor',
          'phone': '0321-7654321',
          'litersPerDay': '10',
          'balance': '+3000',
        },
        {
          'name': 'Usman Tariq',
          'phone': '0345-1112233',
          'litersPerDay': '6',
          'balance': '+1200',
        },
        {
          'name': 'Zara Malik',
          'phone': '0311-5556677',
          'litersPerDay': '9',
          'balance': '-800',
        },
        {
          'name': 'Hassan Butt',
          'phone': '0312-3334455',
          'litersPerDay': '20',
          'balance': '+7500',
        },
        {
          'name': 'Nadia Iqbal',
          'phone': '0323-6667788',
          'litersPerDay': '5',
          'balance': '-250',
        },
      ]);

      filteredCustomers.assignAll(_allCustomers);
      isLoading.value = false;
    });
  }

  void _applyFilter() {
    final q = searchQuery.value.toLowerCase().trim();
    if (q.isEmpty) {
      filteredCustomers.assignAll(_allCustomers);
    } else {
      filteredCustomers.assignAll(
        _allCustomers
            .where(
              (c) =>
                  (c['name'] ?? '').toLowerCase().contains(q) ||
                  (c['phone'] ?? '').toLowerCase().contains(q),
            )
            .toList(),
      );
    }
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
    _applyFilter();
  }

  void onAddCustomer() {
    // Get.toNamed(AppRoutes.addCustomer);
  }

  void onCustomerTap(Map<String, String> customer) {
    Get.toNamed(AppPages.customerDetail, arguments: customer);
  }
}
