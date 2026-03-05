import 'package:dairy_farm_app/features/dashboard/binding/dashboard_binding.dart';
import 'package:dairy_farm_app/features/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/color.dart';

import '../widgets/dashboard_widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<DashboardController>()) {
      DashboardBinding().dependencies();
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: GetBuilder<DashboardController>(
          builder: (controller) {
            return Obx(() {
              if (controller.isLoading.value) {
                return const _DashboardShimmer();
              }
              return RefreshIndicator(
                color: AppColors.primary,
                onRefresh: () async => controller.loadDashboardData(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const DashboardHeader(),
                      const SizedBox(height: 24),
                      const TodaysSummarySection(),
                      const SizedBox(height: 24),
                      const QuickActionsSection(),
                      const SizedBox(height: 24),
                      const RecentActivitySection(),
                      const SizedBox(height: 30),
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

// ─────────────────────────────────────────────
// SHIMMER SKELETON
// ─────────────────────────────────────────────
class _DashboardShimmer extends StatefulWidget {
  const _DashboardShimmer();

  @override
  State<_DashboardShimmer> createState() => _DashboardShimmerState();
}

class _DashboardShimmerState extends State<_DashboardShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _shimmer;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
    _shimmer = Tween<double>(
      begin: -1.5,
      end: 2.5,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shimmer,
      builder: (context, _) {
        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header skeleton ──
              _ShimmerBox(
                shimmerX: _shimmer.value,
                width: double.infinity,
                height: 148,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),

              const SizedBox(height: 24),

              // ── Section label ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _ShimmerBox(
                  shimmerX: _shimmer.value,
                  width: 180,
                  height: 18,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(height: 14),

              // ── 2×2 summary cards ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _ShimmerBox(
                            shimmerX: _shimmer.value,
                            height: 110,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: _ShimmerBox(
                            shimmerX: _shimmer.value,
                            height: 110,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: _ShimmerBox(
                            shimmerX: _shimmer.value,
                            height: 110,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: _ShimmerBox(
                            shimmerX: _shimmer.value,
                            height: 110,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── Section label ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _ShimmerBox(
                  shimmerX: _shimmer.value,
                  width: 160,
                  height: 18,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(height: 14),

              // ── 2×2 quick action cards ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _ShimmerBox(
                            shimmerX: _shimmer.value,
                            height: 120,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: _ShimmerBox(
                            shimmerX: _shimmer.value,
                            height: 120,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: _ShimmerBox(
                            shimmerX: _shimmer.value,
                            height: 120,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: _ShimmerBox(
                            shimmerX: _shimmer.value,
                            height: 120,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── Section label ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _ShimmerBox(
                  shimmerX: _shimmer.value,
                  width: 140,
                  height: 18,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(height: 10),

              // ── Activity list card ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _ShimmerBox(
                  shimmerX: _shimmer.value,
                  height: 240,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}

// ── Single shimmer block ──
class _ShimmerBox extends StatelessWidget {
  final double shimmerX;
  final double? width;
  final double height;
  final BorderRadius borderRadius;

  const _ShimmerBox({
    required this.shimmerX,
    required this.height,
    required this.borderRadius,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: LinearGradient(
          begin: Alignment(shimmerX - 1, 0),
          end: Alignment(shimmerX + 1, 0),
          colors: const [
            Color(0xFFE8EEF8),
            Color(0xFFF4F7FF),
            Color(0xFFFFFFFF),
            Color(0xFFF4F7FF),
            Color(0xFFE8EEF8),
          ],
          stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
        ),
      ),
    );
  }
}
