import 'package:dairy_farm_app/features/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/color.dart';
import '../../../core/theme/text_styles.dart';

// ─────────────────────────────────────────────
// 1. HEADER WIDGET
// ─────────────────────────────────────────────
class DashboardHeader extends GetView<DashboardController> {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.gradientStart,
            AppColors.gradientMiddle,
            AppColors.gradientEnd,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: logo + app name + bell
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.water_drop,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text('MilkMate', style: AppTextStyles.headlineheader),
                ],
              ),
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                      size: 26,
                    ),
                    onPressed: () {},
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          // Greeting
          Obx(
            () => Text(
              'Good Morning, ${controller.staffName.value} 👋',
              style: AppTextStyles.headline2.copyWith(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Obx(
            () => Text(
              controller.farmName.value,
              style: AppTextStyles.subtitle2.copyWith(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 2. SUMMARY CARD WIDGET
// ─────────────────────────────────────────────
class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String delta;
  final bool isDeltaPositive;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.delta,
    required this.isDeltaPositive,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 12),
          Text(title, style: AppTextStyles.caption),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(value, style: AppTextStyles.headline2),
              const SizedBox(width: 6),
              Icon(
                isDeltaPositive ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: isDeltaPositive ? AppColors.success : AppColors.error,
                size: 16,
              ),
              Text(
                delta,
                style: AppTextStyles.caption.copyWith(
                  color: isDeltaPositive ? AppColors.success : AppColors.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 3. TODAY'S SUMMARY SECTION
// ─────────────────────────────────────────────
class TodaysSummarySection extends GetView<DashboardController> {
  const TodaysSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Today's Summary Section",
            style: AppTextStyles.headline3,
          ),
        ),
        const SizedBox(height: 14),
        Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SummaryCard(
                        title: 'Milk Collected Today',
                        value: controller.milkCollected.value.toStringAsFixed(
                          0,
                        ),
                        delta:
                            '+${controller.milkCollectedDelta.value.toStringAsFixed(2)}',
                        isDeltaPositive: true,
                        icon: Icons.water_drop_outlined,
                        iconBgColor: AppColors.primaryLight.withOpacity(0.15),
                        iconColor: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: SummaryCard(
                        title: 'Milk Sold Today',
                        value:
                            '\$${controller.milkSold.value.toStringAsFixed(0)}',
                        delta:
                            '+${controller.milkSoldDelta.value.toStringAsFixed(2)}',
                        isDeltaPositive: true,
                        icon: Icons.receipt_long_outlined,
                        iconBgColor: AppColors.secondary.withOpacity(0.15),
                        iconColor: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: SummaryCard(
                        title: 'Payments Received',
                        value:
                            '\$${controller.paymentsReceived.value.toStringAsFixed(0)}',
                        delta:
                            '+${controller.paymentsReceivedDelta.value.toStringAsFixed(2)}',
                        isDeltaPositive: true,
                        icon: Icons.monetization_on_outlined,
                        iconBgColor: AppColors.secondary.withOpacity(0.12),
                        iconColor: AppColors.secondary,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: SummaryCard(
                        title: 'Expenses Added',
                        value:
                            '\$${controller.expensesAdded.value.toStringAsFixed(0)}',
                        delta:
                            '+${controller.expensesAddedDelta.value.toStringAsFixed(2)}',
                        isDeltaPositive: false,
                        icon: Icons.trending_down_rounded,
                        iconBgColor: AppColors.error.withOpacity(0.1),
                        iconColor: AppColors.error,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// 4. QUICK ACTION CARD
// ─────────────────────────────────────────────
class QuickActionCard extends StatelessWidget {
  final String title;
  final String buttonLabel;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final VoidCallback onTap;

  const QuickActionCard({
    super.key,
    required this.title,
    required this.buttonLabel,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(child: Text(title, style: AppTextStyles.headline3)),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                elevation: 0,
              ),
              child: Text(
                buttonLabel,
                style: AppTextStyles.button.copyWith(
                  color: Colors.white,
                  fontSize: 13,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 5. QUICK ACTIONS SECTION
// ─────────────────────────────────────────────
class QuickActionsSection extends GetView<DashboardController> {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('Quick Actions Section', style: AppTextStyles.headline3),
        ),
        const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: QuickActionCard(
                      title: 'Add Milk\nProduction',
                      buttonLabel: 'Add Primary',
                      icon: Icons.water_drop_outlined,
                      iconBgColor: AppColors.primary.withOpacity(0.1),
                      iconColor: AppColors.primary,
                      onTap: controller.onAddMilkProduction,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: QuickActionCard(
                      title: 'Add Milk\nSale',
                      buttonLabel: 'Add Milk Sale',
                      icon: Icons.local_drink_outlined,
                      iconBgColor: AppColors.primary.withOpacity(0.1),
                      iconColor: AppColors.primary,
                      onTap: controller.onAddMilkSale,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: QuickActionCard(
                      title: 'Add\nPayment',
                      buttonLabel: 'Add Payment',
                      icon: Icons.payments_outlined,
                      iconBgColor: AppColors.secondary.withOpacity(0.12),
                      iconColor: AppColors.secondary,
                      onTap: controller.onAddPayment,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: QuickActionCard(
                      title: 'Add\nExpense',
                      buttonLabel: 'Add Customer',
                      icon: Icons.discount_outlined,
                      iconBgColor: AppColors.error.withOpacity(0.1),
                      iconColor: AppColors.error,
                      onTap: controller.onAddExpense,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// 6. ACTIVITY TILE
// ─────────────────────────────────────────────
class ActivityTile extends StatelessWidget {
  final Map<String, String> activity;

  const ActivityTile({super.key, required this.activity});

  Color get _iconBg {
    switch (activity['type']) {
      case 'payment':
        return AppColors.secondary.withOpacity(0.12);
      case 'expense':
        return AppColors.error.withOpacity(0.1);
      default: // milkProduction, milkSale
        return AppColors.primary.withOpacity(0.12);
    }
  }

  Color get _iconColor {
    switch (activity['type']) {
      case 'payment':
        return AppColors.secondary;
      case 'expense':
        return AppColors.error;
      default:
        return AppColors.primary;
    }
  }

  IconData get _icon {
    switch (activity['type']) {
      case 'payment':
        return Icons.payments_outlined;
      case 'milkSale':
        return Icons.local_drink_outlined;
      case 'expense':
        return Icons.receipt_outlined;
      default: // milkProduction
        return Icons.water_drop_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(_icon, color: _iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity['title'] ?? '',
                  style: AppTextStyles.bodyText1.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  activity['subtitle'] ?? '',
                  style: AppTextStyles.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(activity['timeAgo'] ?? '', style: AppTextStyles.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 7. RECENT ACTIVITY SECTION
// ─────────────────────────────────────────────
class RecentActivitySection extends GetView<DashboardController> {
  const RecentActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('Recent Activity', style: AppTextStyles.headline3),
        ),
        const SizedBox(height: 10),
        Obx(
          () => Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: controller.activities
                  .asMap()
                  .entries
                  .map(
                    (entry) => Column(
                      children: [
                        ActivityTile(activity: entry.value),
                        if (entry.key < controller.activities.length - 1)
                          Divider(
                            color: AppColors.divider,
                            height: 1,
                            thickness: 0.8,
                          ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
