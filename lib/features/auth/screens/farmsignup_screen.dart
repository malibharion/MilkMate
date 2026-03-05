import 'package:dairy_farm_app/core/contants/app_images.dart';
import 'package:dairy_farm_app/core/theme/color.dart';
import 'package:dairy_farm_app/core/theme/text_styles.dart';
import 'package:dairy_farm_app/features/auth/widgets/login_widgets.dart';
import 'package:dairy_farm_app/shared/widgets/custom_button.dart';
import 'package:dairy_farm_app/shared/widgets/custom_textfeild.dart';
import 'package:flutter/material.dart';

class FarmsignupScreen extends StatefulWidget {
  const FarmsignupScreen({super.key});

  @override
  State<FarmsignupScreen> createState() => _FarmsignupScreenState();
}

class _FarmsignupScreenState extends State<FarmsignupScreen> {
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
            // ✅ NO reverse:true — that was pushing everything down
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // ✅ vertically centered
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ── Animated logo + title block ──────────────────────
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
                                // Logo
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Image.asset(
                                      AppImages().loginLogo,
                                      width: w * 0.42,
                                      height: w * 0.42,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 1), // ✅ almost no gap
                                // App name
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

                                const SizedBox(height: 4), // ✅ tiny gap
                                // Subtitle
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

                                SizedBox(height: h * 0.02), // gap before card
                              ],
                            ),
                    ),

                    // ── Glass card ────────────────────────────────────────
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                      child: LoginWidgets.glassContainer(
                        context: context,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                  'Welcome',
                                  style: AppTextStyles.headline2.copyWith(
                                    fontSize: h * 0.032,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: h * 0.006),

                            Padding(
                              padding: EdgeInsets.only(left: w * 0.045),
                              child: Text(
                                'Signup and Register your farm',
                                style: AppTextStyles.caption.copyWith(
                                  fontSize: h * 0.016,
                                ),
                              ),
                            ),

                            SizedBox(height: h * 0.025),
                            Text('Farm Name', style: AppTextStyles.label),
                            SizedBox(height: h * 0.008),
                            CustomTextField(
                              hintText: 'Enter your farm name',
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(height: h * 0.018),
                            Text('Mobile Number', style: AppTextStyles.label),
                            SizedBox(height: h * 0.008),
                            CustomTextField(
                              hintText: 'Enter Your Mobile Number',
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(height: h * 0.018),
                            Text('Email Address', style: AppTextStyles.label),
                            SizedBox(height: h * 0.008),
                            CustomTextField(
                              hintText: 'Enter your email',
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: AppColors.primary,
                              ),
                            ),

                            SizedBox(height: h * 0.018),

                            Text('Password', style: AppTextStyles.label),
                            SizedBox(height: h * 0.008),
                            CustomTextField(
                              hintText: 'Enter your password',
                              obscureText: true,
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: AppColors.primary,
                              ),
                            ),

                            SizedBox(height: h * 0.018),

                            CustomElevatedButton(
                              onPressed: () {},
                              title: 'Signup',
                              useGradient: true,
                            ),

                            SizedBox(height: h * 0.018),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account?",
                                  style: AppTextStyles.bodyText2,
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: w * 0.02,
                                    ),
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    'Sign IN',
                                    style: AppTextStyles.bodyText2.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),

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
