import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMilkProductionController extends GetxController {
  final quantityController = TextEditingController();
  final notesController = TextEditingController();

  final selectedDate = DateTime.now().obs;
  final isLoading = false.obs;
  final quantityError = ''.obs;

  @override
  void onClose() {
    quantityController.dispose();
    notesController.dispose();
    super.onClose();
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
    final q = quantityController.text.trim();
    if (q.isEmpty) {
      quantityError.value = 'Please enter milk quantity';
      return false;
    }
    if (double.tryParse(q) == null || double.parse(q) <= 0) {
      quantityError.value = 'Enter a valid quantity';
      return false;
    }
    quantityError.value = '';
    return true;
  }

  void saveProduction() async {
    if (!_validate()) return;
    isLoading.value = true;

    // Replace with your real API call
    await Future.delayed(const Duration(milliseconds: 800));

    isLoading.value = false;
    Get.back();

    Get.snackbar(
      'Success',
      'Milk production saved successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF22C55E),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }
}
