import 'package:dairy_farm_app/features/customers/controller/customer_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/color.dart';
import '../../../core/theme/text_styles.dart';

import '../widgets/customer_detail_widgets.dart';

class CustomerDetailScreen extends StatelessWidget {
  const CustomerDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Register if not already (e.g. deep link) — normally injected via binding
    if (!Get.isRegistered<CustomerDetailController>()) {
      Get.put(CustomerDetailController());
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: GetBuilder<CustomerDetailController>(
          builder: (controller) {
            return Obx(() {
              if (controller.isLoading.value) {
                return const CustomerDetailShimmer();
              }

              return Stack(
                children: [
                  // ── Scrollable content ──
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1. Header
                        const CustomerDetailHeader(),
                        const SizedBox(height: 20),

                        // 2. Outstanding balance
                        const OutstandingBalanceCard(),
                        const SizedBox(height: 24),

                        // 3. Milk supply history
                        const SectionHeader(
                          title: 'Milk Supply History',
                          subtitle: 'Milk supplied over the last 30 days',
                        ),
                        const SizedBox(height: 12),
                        const MilkSupplyChartCard(),
                        const SizedBox(height: 24),

                        // 4. Payment analytics
                        const SectionHeader(
                          title: 'Payment History Analytics',
                          subtitle: 'Payment Analytics',
                        ),
                        const SizedBox(height: 12),
                        const PaymentBarChartCard(),
                        const SizedBox(height: 12),
                        const PaymentHistoryList(),
                        const SizedBox(height: 24),

                        // 5. Milk records
                        const SectionHeader(
                          title: 'Milk Records List',
                          subtitle: '',
                        ),
                        const SizedBox(height: 12),
                        const MilkRecordsList(),

                        // Bottom padding for FABs
                        const SizedBox(height: 110),
                      ],
                    ),
                  ),

                  // ── Floating action buttons ──
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Add Milk Entry
                        ElevatedButton.icon(
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
                              horizontal: 20,
                              vertical: 13,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                            elevation: 6,
                            shadowColor: AppColors.primary.withOpacity(0.4),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Add Payment
                        ElevatedButton.icon(
                          onPressed: controller.onAddPayment,
                          icon: const Icon(Icons.payments_outlined, size: 18),
                          label: Text(
                            'Add Payment',
                            style: AppTextStyles.button.copyWith(
                              color: Colors.white,
                              fontSize: 13,
                              letterSpacing: 0.3,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryDark,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 13,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                            elevation: 6,
                            shadowColor: AppColors.primaryDark.withOpacity(0.4),
                          ),
                        ),
                      ],
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
