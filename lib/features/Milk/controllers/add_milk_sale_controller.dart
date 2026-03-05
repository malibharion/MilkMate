import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMilkSaleController extends GetxController {
  final quantityController = TextEditingController();
  final rateController = TextEditingController();
  final notesController = TextEditingController();

  final selectedDate = DateTime.now().obs;
  final selectedCustomer = ''.obs;
  final totalAmount = 0.0.obs;
  final isLoading = false.obs;

  // ── Errors ──
  final customerError = ''.obs;
  final quantityError = ''.obs;
  final rateError = ''.obs;

  // ── Status is always Pending Approval on creation ──
  final status = 'Pending Approval'.obs;

  // ── Dummy customer list — replace with real data later ──
  final customers = <String>[
    'Ahmed Ali',
    'Sara Khan',
    'Bilal Raza',
    'Fatima Noor',
    'Usman Tariq',
    'Zara Malik',
    'Hassan Butt',
    'Nadia Iqbal',
  ];

  @override
  void onInit() {
    super.onInit();
    quantityController.addListener(_recalculate);
    rateController.addListener(_recalculate);
  }

  @override
  void onClose() {
    quantityController.dispose();
    rateController.dispose();
    notesController.dispose();
    super.onClose();
  }

  void _recalculate() {
    final q = double.tryParse(quantityController.text) ?? 0.0;
    final r = double.tryParse(rateController.text) ?? 0.0;
    totalAmount.value = q * r;
  }

  String get formattedDate {
    final now = DateTime.now();
    final d = selectedDate.value;
    final isToday =
        d.year == now.year && d.month == now.month && d.day == now.day;
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${d.day} ${months[d.month - 1]}${isToday ? ', Today' : ''}';
  }

  String get formattedTotal => '\$ ${totalAmount.value.toStringAsFixed(2)}';

  Future<void> pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF2F6FE4),
            onPrimary: Colors.white,
            surface: Colors.white,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) selectedDate.value = picked;
  }

  void selectCustomer(String name) {
    selectedCustomer.value = name;
    customerError.value = '';
  }

  bool _validate() {
    bool ok = true;
    if (selectedCustomer.value.isEmpty) {
      customerError.value = 'Please select a customer';
      ok = false;
    }
    final q = quantityController.text.trim();
    if (q.isEmpty || double.tryParse(q) == null || double.parse(q) <= 0) {
      quantityError.value = 'Enter a valid quantity';
      ok = false;
    } else {
      quantityError.value = '';
    }
    final r = rateController.text.trim();
    if (r.isEmpty || double.tryParse(r) == null || double.parse(r) <= 0) {
      rateError.value = 'Enter a valid rate';
      ok = false;
    } else {
      rateError.value = '';
    }
    return ok;
  }

  void recordSale() async {
    if (!_validate()) return;
    isLoading.value = true;

    // Replace with your real API call
    await Future.delayed(const Duration(milliseconds: 800));

    isLoading.value = false;
    Get.back();

    Get.snackbar(
      'Success',
      'Milk sale recorded successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF22C55E),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }
}
