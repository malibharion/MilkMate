import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final isLoading = false.obs;

  // ── Profile data (flat observables) ──
  final fullName = ''.obs;
  final email = ''.obs;
  final phone = ''.obs;
  final role = ''.obs;
  final joinedDate = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  void loadProfile() {
    isLoading.value = true;

    Future.delayed(const Duration(milliseconds: 500), () {
      fullName.value = 'Ahmed Ali';
      email.value = 'ahmed.ali@milkmate.farm';
      phone.value = '+92 300 1234567';
      role.value = 'Senior Farm Staff';
      joinedDate.value = '12 Jan 2021';
      isLoading.value = false;
    });
  }

  String get initials {
    final parts = fullName.value.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return parts[0][0].toUpperCase();
  }

  void onEditProfile() {
    // Get.toNamed('/edit-profile');
  }

  void onChangePassword() {
    // Get.toNamed('/change-password');
  }

  void onNotificationPrefs() {
    // Get.toNamed('/notification-prefs');
  }

  void onAppTheme() {
    // toggle theme
  }

  void onLanguagePrefs() {
    // Get.toNamed('/language-prefs');
  }

  void onLogout() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Logout',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Color(0xFF374151),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.offAllNamed('/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2F6FE4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
