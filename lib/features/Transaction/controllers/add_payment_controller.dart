import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPaymentController extends GetxController {
  final amountController = TextEditingController();
  final notesController = TextEditingController();

  final selectedDate = DateTime.now().obs;
  final selectedCustomer = ''.obs;
  final selectedMethod = ''.obs;
  final isMethodOpen = false.obs;
  final isLoading = false.obs;

  // ── Errors ──
  final customerError = ''.obs;
  final amountError = ''.obs;
  final methodError = ''.obs;

  final customers = <String>[
    'Farhan Ali',
    'Ahmed Ali',
    'Sara Khan',
    'Bilal Raza',
    'Fatima Noor',
    'Usman Tariq',
    'Zara Malik',
    'Hassan Butt',
    'Nadia Iqbal',
  ];

  final paymentMethods = <Map<String, dynamic>>[
    {'label': 'Cash', 'icon': Icons.money_outlined},
    {'label': 'Bank Transfer', 'icon': Icons.account_balance_outlined},
    {'label': 'Mobile Wallet', 'icon': Icons.phone_android_outlined},
  ];

  @override
  void onInit() {
    super.onInit();
    amountController.addListener(() => amountError.value = '');
  }

  @override
  void onClose() {
    amountController.dispose();
    notesController.dispose();
    super.onClose();
  }

  void selectCustomer(String name) {
    selectedCustomer.value = name;
    customerError.value = '';
  }

  void toggleMethodDropdown() => isMethodOpen.value = !isMethodOpen.value;

  void selectMethod(String method) {
    selectedMethod.value = method;
    methodError.value = '';
    isMethodOpen.value = false;
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

  bool _validate() {
    bool ok = true;
    if (selectedCustomer.value.isEmpty) {
      customerError.value = 'Please select a customer';
      ok = false;
    }
    final a = amountController.text.trim();
    if (a.isEmpty || double.tryParse(a) == null || double.parse(a) <= 0) {
      amountError.value = 'Enter a valid amount';
      ok = false;
    } else {
      amountError.value = '';
    }
    if (selectedMethod.value.isEmpty) {
      methodError.value = 'Please select a payment method';
      ok = false;
    }
    return ok;
  }

  void recordPayment() async {
    if (!_validate()) return;
    isLoading.value = true;

    await Future.delayed(const Duration(milliseconds: 800));

    isLoading.value = false;
    Get.back();

    Get.snackbar(
      'Success',
      'Payment recorded successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF22C55E),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }
}
