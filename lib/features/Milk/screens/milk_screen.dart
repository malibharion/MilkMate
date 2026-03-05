import 'package:dairy_farm_app/core/theme/text_styles.dart';
import 'package:dairy_farm_app/features/Milk/controllers/milk_screen_controller.dart';
import 'package:dairy_farm_app/features/Milk/widgets/milk_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/color.dart';
import '../bindings/milk_binding.dart';

class MilkScreen extends StatelessWidget {
  const MilkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<MilkController>()) {
      MilkBinding().dependencies();
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: GetBuilder<MilkController>(
          builder: (controller) {
            return Obx(() {
              if (controller.isLoading.value) {
                return const MilkShimmer();
              }

              return Stack(
                children: [
                  RefreshIndicator(
                    color: AppColors.primary,
                    onRefresh: () async => controller.loadData(),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 1. Header
                          const MilkHeader(),
                          const SizedBox(height: 24),

                          // 2. Today's summary label
                          const MilkSectionHeader(
                            title: "Today's Milk Summary",
                            subtitle: '',
                          ),
                          const SizedBox(height: 14),

                          // 3. Summary cards 2×2
                          const MilkSummarySection(),
                          const SizedBox(height: 24),

                          // 4. Analytics chart
                          const MilkSectionHeader(
                            title: 'Milk Production Analytics',
                            subtitle: 'Milk production over the last 7 days',
                          ),
                          const SizedBox(height: 12),
                          const MilkAnalyticsChart(),
                          const SizedBox(height: 24),

                          // 5. Quick actions
                          const MilkSectionHeader(
                            title: 'Quick Actions',
                            subtitle: '',
                          ),
                          const SizedBox(height: 14),
                          const MilkQuickActions(),
                          const SizedBox(height: 24),

                          // 6. Recent activity
                          const MilkSectionHeader(
                            title: 'Recent Milk Activity',
                            subtitle: '',
                          ),
                          const SizedBox(height: 12),
                          const RecentMilkActivity(),

                          // Bottom padding for FAB
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),

                  // ── FAB: Add Milk Entry ──
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: ElevatedButton.icon(
                      onPressed: controller.onAddMilkEntry,
                      icon: const Icon(Icons.water_drop_outlined, size: 18),
                      label: Text(
                        'Add Milk Entry',
                        style: AppTextStyles.button.copyWith(
                          color: Colors.white,
                          fontSize: 13,
                          letterSpacing: 0.3,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 6,
                        shadowColor: AppColors.primary.withOpacity(0.4),
                      ),
                    ),
                  ),
                ],
              );
            });
          },
        ),
      ),
    );
  }
}
