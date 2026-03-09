// lib/features/auth/controllers/login_controller.dart
import 'package:dairy_farm_app/core/services/auth_services.dart';
import 'package:dairy_farm_app/shared/widgets/app_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final obscurePassword = true.obs;
  final emailError = ''.obs;
  final passwordError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(() => emailError.value = '');
    passwordController.addListener(() => passwordError.value = '');
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePassword() => obscurePassword.value = !obscurePassword.value;

  bool _validate() {
    bool ok = true;
    final email = emailController.text.trim();
    final pass = passwordController.text;

    if (email.isEmpty || !GetUtils.isEmail(email)) {
      emailError.value = 'Enter a valid email';
      ok = false;
    }
    if (pass.isEmpty || pass.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
      ok = false;
    }
    return ok;
  }

  Future<void> onLogin() async {
    if (!_validate()) return;

    isLoading.value = true;

    final result = await AuthService.login(
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    isLoading.value = false;

    if (result.success) {
      AppSnackbar.success('Welcome back!', title: 'Login Successful');
      await Future.delayed(const Duration(milliseconds: 500));
      Get.offAllNamed(AppPages.bottomnavbar);
    } else {
      AppSnackbar.error(result.error ?? 'Something went wrong');
    }
  }

  void onChangeFarm() {
    Get.offAllNamed(AppPages.farmscreen);
  }
}
