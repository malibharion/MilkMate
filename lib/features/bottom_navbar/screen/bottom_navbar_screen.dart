import 'package:dairy_farm_app/features/Milk/screens/milk_screen.dart';
import 'package:dairy_farm_app/features/Transaction/screens/transaction_screen.dart';
import 'package:dairy_farm_app/features/bottom_navbar/controller/bottom_navbar_controller.dart';
import 'package:dairy_farm_app/features/bottom_navbar/widgets/bottom_navbar_widgets.dart';
import 'package:dairy_farm_app/features/customers/screens/customer_screen.dart';
import 'package:dairy_farm_app/features/dashboard/screen/dashboard_screen.dart';
import 'package:dairy_farm_app/features/profile/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/color.dart';

class BottomNavScreen extends GetView<BottomNavController> {
  const BottomNavScreen({super.key});

  static final List<Widget> _pages = [
    const DashboardScreen(), // index 0
    const CustomersScreen(), // index 1
    const MilkScreen(), // index 2
    const TransactionsScreen(), // index 3
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: _pages,
        ),
      ),
      bottomNavigationBar: Obx(
        () => AppBottomNavBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changePage,
        ),
      ),
    );
  }
}

// ── Temporary placeholder for tabs not yet built ──
class _PlaceholderScreen extends StatelessWidget {
  final String label;
  const _PlaceholderScreen({required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
