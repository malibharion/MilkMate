// lib/features/farmscreen/screen/farmscreen.dart
import 'package:dairy_farm_app/core/theme/color.dart';
import 'package:dairy_farm_app/core/theme/text_styles.dart';
import 'package:dairy_farm_app/features/farmscreen/contrller/farmscreen_controller.dart';
import 'package:dairy_farm_app/shared/widgets/custom_button.dart';
import 'package:dairy_farm_app/shared/widgets/custom_textfeild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Farmscreen extends GetView<FarmscreenController> {
  const Farmscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1C6DFF), Color(0xFF3A8DFF), Color(0xFF6DB7FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            // ✅ NO reverse:true — that was the cause of keyboard dismissal
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: w * 0.05),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: h * 0.85),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: h * 0.06),

                  // ── Logo (hides smoothly when keyboard opens) ──
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
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
                            children: [
                              const Text(
                                'MILKMATE',
                                style: TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              SizedBox(height: h * 0.06),
                            ],
                          ),
                  ),

                  // ── White card ──
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(w * 0.05),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to Milk Mate',
                          style: AppTextStyles.headline1,
                        ),
                        SizedBox(height: h * 0.01),
                        Text(
                          'Lets setup your digital dairy ecosystem',
                          style: AppTextStyles.subtitle1,
                        ),
                        SizedBox(height: h * 0.03),

                        Text('Farm Name', style: AppTextStyles.label),
                        SizedBox(height: h * 0.01),

                        Obx(
                          () => CustomTextField(
                            hintText: 'Enter Farm Name',
                            controller: controller.farmNameController,
                            prefixIcon: Icon(
                              Icons.home,
                              color: AppColors.primary,
                              size: w * 0.06,
                            ),
                            errorText: controller.farmError.value.isNotEmpty
                                ? controller.farmError.value
                                : null,
                          ),
                        ),

                        SizedBox(height: h * 0.03),

                        Obx(
                          () => CustomElevatedButton(
                            onPressed: controller.isLoading.value
                                ? null
                                : controller.onContinue,
                            title: controller.isLoading.value
                                ? 'Searching...'
                                : 'Continue',
                            useGradient: true,
                            isLoading: controller.isLoading.value,
                          ),
                        ),

                        SizedBox(height: h * 0.02),
                      ],
                    ),
                  ),

                  SizedBox(height: h * 0.06),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
