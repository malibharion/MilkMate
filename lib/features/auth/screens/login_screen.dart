// lib/features/auth/screens/login_screen.dart
import 'package:dairy_farm_app/core/contants/app_images.dart';
import 'package:dairy_farm_app/core/services/storage_services.dart';
import 'package:dairy_farm_app/core/theme/color.dart';
import 'package:dairy_farm_app/core/theme/text_styles.dart';

import 'package:dairy_farm_app/features/auth/controllers/login_controller.dart';
import 'package:dairy_farm_app/features/auth/widgets/login_widgets.dart';
import 'package:dairy_farm_app/shared/widgets/custom_button.dart';
import 'package:dairy_farm_app/shared/widgets/custom_textfeild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1C6DFF), Color(0xFF3A8DFF), Color(0xFF6DB7FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    // ── Logo block (hides on keyboard open) ──
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: SizeTransition(
                          sizeFactor: animation,
                          axisAlignment: -1,
                          child: child,
                        ),
                      ),
                      child: isKeyboardOpen
                          ? const SizedBox.shrink(key: ValueKey('hidden'))
                          : Column(
                              key: const ValueKey('shown'),
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Image.asset(
                                    AppImages().loginLogo,
                                    width: w * 0.42,
                                    height: w * 0.42,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Center(
                                  child: Text(
                                    'MilkMate',
                                    style: AppTextStyles.bodyText1.copyWith(
                                      fontSize: h * 0.042,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Center(
                                  child: Text(
                                    'Your Dairy Management Solution',
                                    style: AppTextStyles.bodyText1.copyWith(
                                      fontSize: h * 0.018,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white.withOpacity(0.85),
                                      letterSpacing: 0.4,
                                    ),
                                  ),
                                ),
                                SizedBox(height: h * 0.02),
                              ],
                            ),
                    ),

                    // ── Glass card ──
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                      child: LoginWidgets.glassContainer(
                        context: context,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            // Title row
                            Row(
                              children: [
                                Container(
                                  width: 4,
                                  height: h * 0.05,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                SizedBox(width: w * 0.03),
                                Text(
                                  'Welcome Back',
                                  style: AppTextStyles.headline2.copyWith(
                                    fontSize: h * 0.032,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: h * 0.006),

                            // Farm name chip
                            Padding(
                              padding: EdgeInsets.only(left: w * 0.045),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Sign in to ${StorageService.farmName ?? 'your farm'}',
                                      style: AppTextStyles.caption.copyWith(
                                        fontSize: h * 0.016,
                                      ),
                                    ),
                                  ),
                                  // Change farm button
                                  GestureDetector(
                                    onTap: controller.onChangeFarm,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary.withOpacity(0.10),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: AppColors.primary.withOpacity(0.3)),
                                      ),
                                      child: Text(
                                        'Change Farm',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: h * 0.025),

                            // ── Email field ──
                            Text('Email Address', style: AppTextStyles.label),
                            SizedBox(height: h * 0.008),
                            Obx(() => CustomTextField(
                                  hintText:      'Enter your email',
                                  keyboardType:  TextInputType.emailAddress,
                                  controller:    controller.emailController,
                                  errorText:     controller.emailError.value.isNotEmpty
                                      ? controller.emailError.value
                                      : null,
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color: AppColors.primary,
                                  ),
                                )),

                            SizedBox(height: h * 0.018),

                            // ── Password field ──
                            Text('Password', style: AppTextStyles.label),
                            SizedBox(height: h * 0.008),
                            Obx(() => CustomTextField(
                                  hintText:     'Enter your password',
                                  controller:   controller.passwordController,
                                  obscureText:  controller.obscurePassword.value,
                                  errorText:    controller.passwordError.value.isNotEmpty
                                      ? controller.passwordError.value
                                      : null,
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: AppColors.primary,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: controller.togglePassword,
                                    child: Icon(
                                      controller.obscurePassword.value
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                )),

                            // Forgot password
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: h * 0.005),
                                ),
                                child: Text(
                                  'Forgot Password?',
                                  style: AppTextStyles.bodyText2.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: h * 0.005),

                            // ── Login button ──
                            Obx(() => CustomElevatedButton(
                                  onPressed: controller.isLoading.value
                                      ? null
                                      : controller.onLogin,
                                  title: controller.isLoading.value
                                      ? 'Signing in...'
                                      : 'Login',
                                  useGradient: true,
                                  isLoading: controller.isLoading.value,
                                )),

                            SizedBox(height: h * 0.005),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: h * 0.03),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}