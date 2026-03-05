import 'package:dairy_farm_app/core/theme/text_styles.dart';
import 'package:dairy_farm_app/features/profile/binding/profile_binding.dart';
import 'package:dairy_farm_app/features/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/color.dart';

import '../widgets/profile_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<ProfileController>()) {
      ProfileBinding().dependencies();
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      floatingActionButton: const ProfileEditFab(),
      body: SafeArea(
        child: GetBuilder<ProfileController>(
          builder: (controller) {
            return Obx(() {
              if (controller.isLoading.value) {
                return const ProfileShimmer();
              }

              return RefreshIndicator(
                color: AppColors.primary,
                onRefresh: () async => controller.loadProfile(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Header
                      const ProfileHeader(),
                      const SizedBox(height: 24),

                      // 2. Profile info section label
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Profile Info',
                          style: AppTextStyles.headline3.copyWith(fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // 3. Info card
                      const ProfileInfoCard(),
                      const SizedBox(height: 24),

                      // 4. Settings section label + cards
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Settings Section',
                          style: AppTextStyles.headline3.copyWith(fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const ProfileSettingsSection(),
                      const SizedBox(height: 28),

                      // 5. Logout
                      const LogoutButton(),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
