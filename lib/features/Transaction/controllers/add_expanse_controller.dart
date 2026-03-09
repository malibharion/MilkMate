import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddExpenseController extends GetxController {
  final amountController = TextEditingController();
  final notesController = TextEditingController();

  final selectedDate = DateTime.now().obs;
  final selectedCategory = 'Feed'.obs;
  final isLoading = false.obs;
  final amountError = ''.obs;

  final categories = <Map<String, dynamic>>[
    {'label': 'Feed', 'icon': Icons.inventory_2_outlined},
    {'label': 'Medicine', 'icon': Icons.medical_services_outlined},
    {'label': 'Transport', 'icon': Icons.local_shipping_outlined},
    {'label': 'Repair', 'icon': Icons.build_outlined},
    {'label': 'Labour', 'icon': Icons.people_outline},
    {'label': 'Other', 'icon': Icons.more_horiz_rounded},
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

  void selectCategory(String cat) => selectedCategory.value = cat;

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
    final a = amountController.text.trim();
    if (a.isEmpty || double.tryParse(a) == null || double.parse(a) <= 0) {
      amountError.value = 'Enter a valid amount';
      return false;
    }
    amountError.value = '';
    return true;
  }

  void saveExpense() async {
    if (!_validate()) return;
    isLoading.value = true;

    await Future.delayed(const Duration(milliseconds: 800));

    isLoading.value = false;
    Get.back();

    Get.snackbar(
      'Success',
      'Expense saved successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF22C55E),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }
}
