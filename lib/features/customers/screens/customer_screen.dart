import 'package:dairy_farm_app/features/customers/binding/customer_controller_binding.dart';
import 'package:dairy_farm_app/features/customers/controller/customer_controller.dart';
import 'package:dairy_farm_app/features/customers/widgets/customer_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/color.dart';
import '../../../core/theme/text_styles.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<CustomersController>()) {
      CustomersBinding().dependencies();
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: GetBuilder<CustomersController>(
          builder: (controller) {
            return Obx(() {
              if (controller.isLoading.value) {
                return const CustomersShimmer();
              }

              return Stack(
                children: [
                  RefreshIndicator(
                    color: AppColors.primary,
                    onRefresh: () async => controller.loadCustomers(),
                    child: CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        // ── Header ──
                        const SliverToBoxAdapter(child: CustomersHeader()),

                        const SliverToBoxAdapter(child: SizedBox(height: 20)),

                        // ── Search bar ──
                        const SliverToBoxAdapter(child: CustomersSearchBar()),

                        const SliverToBoxAdapter(child: SizedBox(height: 16)),

                        // ── Stats row ──
                        const SliverToBoxAdapter(child: CustomersStatsRow()),

                        const SliverToBoxAdapter(child: SizedBox(height: 20)),

                        // ── List header ──
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Obx(
                              () => Text(
                                controller.searchQuery.value.isEmpty
                                    ? 'All Customers'
                                    : 'Results (${controller.filteredCustomers.length})',
                                style: AppTextStyles.headline3,
                              ),
                            ),
                          ),
                        ),

                        const SliverToBoxAdapter(child: SizedBox(height: 10)),

                        // ── Customer list ──
                        Obx(() {
                          if (controller.filteredCustomers.isEmpty) {
                            return SliverToBoxAdapter(
                              child: CustomersEmptyState(
                                query: controller.searchQuery.value,
                              ),
                            );
                          }
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => CustomerTile(
                                customer: controller.filteredCustomers[index],
                              ),
                              childCount: controller.filteredCustomers.length,
                            ),
                          );
                        }),

                        // Bottom padding for FAB
                        const SliverToBoxAdapter(child: SizedBox(height: 100)),
                      ],
                    ),
                  ),

                  // ── FAB: Add Customer ──
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: ElevatedButton.icon(
                        onPressed: controller.onAddCustomer,
                        icon: const Icon(Icons.add_rounded, size: 20),
                        label: Text(
                          'Add Customer',
                          style: AppTextStyles.button.copyWith(
                            color: Colors.white,
                            fontSize: 14,
                            letterSpacing: 0.4,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
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
