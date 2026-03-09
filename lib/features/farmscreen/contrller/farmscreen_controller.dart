// lib/features/farmscreen/contrller/farmscreen_controller.dart
import 'package:dairy_farm_app/core/services/auth_services.dart';
import 'package:dairy_farm_app/shared/widgets/app_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes.dart';

class FarmscreenController extends GetxController {
  final farmNameController = TextEditingController();
  final isLoading = false.obs;
  final farmError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    farmNameController.addListener(() => farmError.value = '');
  }

  @override
  void onClose() {
    farmNameController.dispose();
    super.onClose();
  }

  Future<void> onContinue() async {
    farmError.value = '';
    final name = farmNameController.text.trim();

    if (name.isEmpty) {
      farmError.value = 'Please enter your farm name';
      return;
    }

    isLoading.value = true;
    final result = await AuthService.lookupFarm(name);
    isLoading.value = false;

    if (result.found) {
      AppSnackbar.success('Farm found! Please login.', title: 'Welcome');
      await Future.delayed(const Duration(milliseconds: 600));
      Get.offAllNamed(AppPages.login);
    } else {
      farmError.value = result.error ?? 'Farm not found';
      AppSnackbar.error(result.error ?? 'Farm not found', title: 'Not Found');
    }
  }
}
