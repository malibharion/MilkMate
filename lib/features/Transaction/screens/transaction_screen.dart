import 'package:dairy_farm_app/features/Transaction/binding/transaction_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/color.dart';
import '../../../core/theme/text_styles.dart';

import '../controllers/transactions_controller.dart';
import '../widgets/transactions_widgets.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<TransactionsController>()) {
      TransactionsBinding().dependencies();
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: GetBuilder<TransactionsController>(
          builder: (controller) {
            return Obx(() {
              if (controller.isLoading.value) {
                return const TransactionsShimmer();
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
                          const TransactionsHeader(),
                          const SizedBox(height: 24),

                          // 2. Summary section label
                          const TxSectionHeader(
                            title: 'Payments Received Today',
                          ),
                          const SizedBox(height: 14),

                          // 3. 2×2 summary cards
                          const TransactionsSummary(),
                          const SizedBox(height: 24),

                          // 4. Financial activity chart
                          const TxSectionHeader(
                            title: 'Financial Activity',
                            subtitle: 'Milk production over the last 7 days',
                          ),
                          const SizedBox(height: 12),
                          const FinancialActivityChart(),
                          const SizedBox(height: 24),

                          // 5. Quick actions
                          const TxSectionHeader(title: 'Quick Actions'),
                          const SizedBox(height: 14),
                          const TransactionsQuickActions(),
                          const SizedBox(height: 24),

                          // 6. Recent transactions
                          const TxSectionHeader(title: 'Recent Transactions'),
                          const SizedBox(height: 12),
                          const RecentTransactionsList(),

                          // Bottom padding for FAB
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),

                  // ── FAB: Add Transaction ──
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: ElevatedButton.icon(
                      onPressed: controller.onAddTransaction,
                      icon: const Icon(
                        Icons.add_shopping_cart_outlined,
                        size: 18,
                      ),
                      label: Text(
                        'Add Transaction',
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
