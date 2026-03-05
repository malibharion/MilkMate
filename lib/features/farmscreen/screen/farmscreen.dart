import 'package:dairy_farm_app/app/routes.dart';
import 'package:dairy_farm_app/core/theme/color.dart';
import 'package:dairy_farm_app/core/theme/text_styles.dart';
import 'package:dairy_farm_app/features/farmscreen/widgets/farmscreen_widgets.dart';
import 'package:dairy_farm_app/shared/widgets/custom_button.dart';
import 'package:dairy_farm_app/shared/widgets/custom_textfeild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Farmscreen extends StatefulWidget {
  const Farmscreen({super.key});

  @override
  State<Farmscreen> createState() => _FarmscreenState();
}

class _FarmscreenState extends State<Farmscreen> {
  final TextEditingController _farmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
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
            reverse: true,
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.05,
                vertical: h * 0.12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Vertical spacing before logo
                  if (!isKeyboardOpen) SizedBox(height: h * 0.08),

                  // MILKMATE logo
                  if (!isKeyboardOpen)
                    Text(
                      'MILKMATE',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),

                  if (!isKeyboardOpen) SizedBox(height: h * 0.08),

                  // Card container
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
                        CustomTextField(
                          hintText: 'Enter Farm Name',
                          prefixIcon: Icon(
                            Icons.home,
                            color: AppColors.primary,
                            size: w * 0.06,
                          ),
                          controller: _farmController,
                        ),
                        SizedBox(height: h * 0.03),
                        CustomElevatedButton(
                          onPressed: () {
                            Get.toNamed(AppPages.login);
                          },
                          title: 'Continue',
                          useGradient: true,
                        ),
                        SizedBox(height: h * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: AppTextStyles.bodyText1,
                            ),
                            TextButton(
                              onPressed: () {
                                Get.toNamed(AppPages.signupScreen);
                              },
                              child: Text(
                                'Sign Up',
                                style: AppTextStyles.bodyText1.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Extra spacing at bottom if keyboard not open
                  if (!isKeyboardOpen) SizedBox(height: h * 0.08),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
