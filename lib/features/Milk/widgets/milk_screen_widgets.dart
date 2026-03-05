import 'package:dairy_farm_app/features/Milk/controllers/milk_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import '../../../core/theme/color.dart';
import '../../../core/theme/text_styles.dart';

// ─────────────────────────────────────────────
// 1. HEADER
// ─────────────────────────────────────────────
class MilkHeader extends GetView<MilkController> {
  const MilkHeader({super.key});

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
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.22),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.water_drop,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'MilkMate',
                    style: AppTextStyles.headlineheader.copyWith(fontSize: 17),
                  ),
                ],
              ),
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                      size: 24,
                    ),
                    onPressed: () {},
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                      width: 8,
                      height: 8,
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
          const SizedBox(height: 14),
          // Title row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Milk Management',
                    style: AppTextStyles.headline2.copyWith(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Track milk production and sales',
                    style: AppTextStyles.subtitle2.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: controller.onAddMilkEntry,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.22),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withOpacity(0.4)),
                  ),
                  child: const Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
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
// 2. SUMMARY CARDS (2×2)
// ─────────────────────────────────────────────
class MilkSummarySection extends GetView<MilkController> {
  const MilkSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _MilkSummaryCard(
                    icon: Icons.water_drop_outlined,
                    iconBg: AppColors.primary.withOpacity(0.10),
                    iconColor: AppColors.primary,
                    label: 'Milk Collected Today',
                    value: controller.milkCollectedToday.value.toStringAsFixed(
                      0,
                    ),
                    delta:
                        '+${controller.milkCollectedDelta.value.toStringAsFixed(2)}',
                    isPositive: true,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _MilkSummaryCard(
                    icon: Icons.receipt_long_outlined,
                    iconBg: AppColors.secondary.withOpacity(0.12),
                    iconColor: AppColors.secondary,
                    label: 'Milk Sold Today',
                    value:
                        '\$${controller.milkSoldToday.value.toStringAsFixed(0)}',
                    delta:
                        '+${controller.milkSoldDelta.value.toStringAsFixed(2)}',
                    isPositive: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _MilkSummaryCard(
                    icon: Icons.hourglass_bottom_outlined,
                    iconBg: AppColors.warning.withOpacity(0.12),
                    iconColor: AppColors.warning,
                    label: 'Pending Sales Approval',
                    value:
                        '\$${controller.pendingSalesApproval.value.toStringAsFixed(0)}',
                    delta: '',
                    isPositive: true,
                    showDelta: false,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _MilkSummaryCard(
                    icon: Icons.hourglass_top_outlined,
                    iconBg: AppColors.error.withOpacity(0.10),
                    iconColor: AppColors.error,
                    label: 'Expense Sales',
                    value:
                        '\$${controller.expenseSales.value.toStringAsFixed(0)}',
                    delta: '',
                    isPositive: false,
                    showDelta: false,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MilkSummaryCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg, iconColor;
  final String label, value, delta;
  final bool isPositive;
  final bool showDelta;

  const _MilkSummaryCard({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.delta,
    required this.isPositive,
    this.showDelta = true,
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
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 12),
          Text(label, style: AppTextStyles.caption),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  value,
                  style: AppTextStyles.headline2.copyWith(fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (showDelta) ...[
                Icon(
                  isPositive ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: isPositive ? AppColors.success : AppColors.error,
                  size: 16,
                ),
                Text(
                  delta,
                  style: AppTextStyles.caption.copyWith(
                    color: isPositive ? AppColors.success : AppColors.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 3. ANALYTICS CHART CARD
// ─────────────────────────────────────────────
class MilkAnalyticsChart extends GetView<MilkController> {
  const MilkAnalyticsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Chart area
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
              child: SizedBox(
                height: 160,
                width: double.infinity,
                child: CustomPaint(
                  painter: _MilkLineChartPainter(data: controller.chartData),
                ),
              ),
            ),
            // Day labels
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: controller.chartData
                    .map(
                      (d) => Text(
                        d['day'] as String,
                        style: AppTextStyles.caption.copyWith(fontSize: 11),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MilkLineChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;
  _MilkLineChartPainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;
    const padL = 12.0, padR = 12.0, padT = 20.0, padB = 8.0;
    final w = size.width - padL - padR;
    final h = size.height - padT - padB;

    final vals = data.map((e) => (e['liters'] as double)).toList();
    final minV = vals.reduce(math.min) - 10;
    final maxV = vals.reduce(math.max) + 10;
    final range = maxV - minV;

    Offset pt(int i, double v) {
      final x = padL + (i / (vals.length - 1)) * w;
      final y = padT + h - ((v - minV) / range) * h;
      return Offset(x, y);
    }

    // Grid lines
    for (int g = 0; g <= 3; g++) {
      canvas.drawLine(
        Offset(padL, padT + (g / 3) * h),
        Offset(padL + w, padT + (g / 3) * h),
        Paint()
          ..color = AppColors.border.withOpacity(0.5)
          ..strokeWidth = 0.8,
      );
    }

    // Fill
    final fill = Path()..moveTo(padL, padT + h);
    for (int i = 0; i < vals.length; i++) {
      final p = pt(i, vals[i]);
      if (i == 0)
        fill.lineTo(p.dx, p.dy);
      else {
        final prev = pt(i - 1, vals[i - 1]);
        final cx = (prev.dx + p.dx) / 2;
        fill.cubicTo(cx, prev.dy, cx, p.dy, p.dx, p.dy);
      }
    }
    fill.lineTo(padL + w, padT + h);
    fill.close();
    canvas.drawPath(
      fill,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primary.withOpacity(0.22),
            AppColors.primary.withOpacity(0.02),
          ],
        ).createShader(Rect.fromLTWH(0, padT, size.width, h)),
    );

    // Line
    final line = Path();
    for (int i = 0; i < vals.length; i++) {
      final p = pt(i, vals[i]);
      if (i == 0)
        line.moveTo(p.dx, p.dy);
      else {
        final prev = pt(i - 1, vals[i - 1]);
        final cx = (prev.dx + p.dx) / 2;
        line.cubicTo(cx, prev.dy, cx, p.dy, p.dx, p.dy);
      }
    }
    canvas.drawPath(
      line,
      Paint()
        ..color = AppColors.primary
        ..strokeWidth = 2.2
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    // Dots at each data point
    for (int i = 0; i < vals.length; i++) {
      final p = pt(i, vals[i]);
      canvas.drawCircle(p, 3.5, Paint()..color = AppColors.primary);
      canvas.drawCircle(p, 2.0, Paint()..color = Colors.white);
    }
  }

  @override
  bool shouldRepaint(_MilkLineChartPainter old) => old.data != data;
}

// ─────────────────────────────────────────────
// 4. QUICK ACTIONS
// ─────────────────────────────────────────────
class MilkQuickActions extends GetView<MilkController> {
  const MilkQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _QuickActionCard(
              icon: Icons.water_drop_outlined,
              iconBg: AppColors.primary.withOpacity(0.10),
              iconColor: AppColors.primary,
              title: 'Add Milk\nProduction',
              buttonLabel: 'Add Primary',
              onTap: controller.onAddMilkProduction,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: _QuickActionCard(
              icon: Icons.local_drink_outlined,
              iconBg: AppColors.primary.withOpacity(0.10),
              iconColor: AppColors.primary,
              title: 'Add Milk\nSale',
              buttonLabel: 'Add Milk Sale',
              onTap: controller.onAddMilkSale,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg, iconColor;
  final String title, buttonLabel;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.buttonLabel,
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
                  color: iconBg,
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
// 5. RECENT MILK ACTIVITY
// ─────────────────────────────────────────────
class RecentMilkActivity extends GetView<MilkController> {
  const RecentMilkActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
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
          children: controller.activities.asMap().entries.map((entry) {
            final idx = entry.key;
            final a = entry.value;
            return Column(
              children: [
                _ActivityTile(activity: a),
                if (idx < controller.activities.length - 1)
                  Divider(
                    height: 1,
                    color: AppColors.divider,
                    indent: 16,
                    endIndent: 16,
                  ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final Map<String, String> activity;
  const _ActivityTile({required this.activity});

  Color get _iconBg => activity['type'] == 'production'
      ? AppColors.primary.withOpacity(0.10)
      : AppColors.primaryLight.withOpacity(0.15);

  Color get _iconColor => AppColors.primary;

  IconData get _icon => activity['type'] == 'production'
      ? Icons.water_drop_outlined
      : Icons.local_drink_outlined;

  @override
  Widget build(BuildContext context) {
    final status = activity['status'] ?? '';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _iconBg,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(_icon, color: _iconColor, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${activity['title']} — ${activity['subtitle']}',
                        style: AppTextStyles.bodyText1.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    if (status.isNotEmpty) _StatusBadge(status: status),
                  ],
                ),
                const SizedBox(height: 3),
                Text(activity['timeAgo'] ?? '', style: AppTextStyles.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final isPending = status == 'pending';
    final bgColor = isPending
        ? AppColors.warning.withOpacity(0.15)
        : AppColors.success.withOpacity(0.12);
    final textColor = isPending ? AppColors.warning : AppColors.success;
    final label = isPending ? 'Pending' : 'Approved';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 6. SECTION HEADER
// ─────────────────────────────────────────────
class MilkSectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const MilkSectionHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.headline3.copyWith(fontSize: 18)),
          if (subtitle.isNotEmpty) ...[
            const SizedBox(height: 3),
            Text(subtitle, style: AppTextStyles.caption),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 7. SHIMMER SKELETON
// ─────────────────────────────────────────────
class MilkShimmer extends StatefulWidget {
  const MilkShimmer({super.key});

  @override
  State<MilkShimmer> createState() => _MilkShimmerState();
}

class _MilkShimmerState extends State<MilkShimmer>
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
      builder: (_, __) => SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _S(
              x: _shimmer.value,
              w: double.infinity,
              h: 160,
              br: const BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            const SizedBox(height: 24),
            _pad(
              _S(
                x: _shimmer.value,
                w: 180,
                h: 20,
                br: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _S(
                          x: _shimmer.value,
                          h: 110,
                          br: BorderRadius.circular(16),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _S(
                          x: _shimmer.value,
                          h: 110,
                          br: BorderRadius.circular(16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _S(
                          x: _shimmer.value,
                          h: 110,
                          br: BorderRadius.circular(16),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _S(
                          x: _shimmer.value,
                          h: 110,
                          br: BorderRadius.circular(16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _pad(
              _S(
                x: _shimmer.value,
                w: 200,
                h: 20,
                br: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 14),
            _pad(
              _S(
                x: _shimmer.value,
                w: double.infinity,
                h: 190,
                br: BorderRadius.circular(18),
              ),
            ),
            const SizedBox(height: 24),
            _pad(
              _S(
                x: _shimmer.value,
                w: 140,
                h: 20,
                br: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _S(
                      x: _shimmer.value,
                      h: 120,
                      br: BorderRadius.circular(16),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _S(
                      x: _shimmer.value,
                      h: 120,
                      br: BorderRadius.circular(16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _pad(
              _S(
                x: _shimmer.value,
                w: 180,
                h: 20,
                br: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 14),
            _pad(
              _S(
                x: _shimmer.value,
                w: double.infinity,
                h: 200,
                br: BorderRadius.circular(18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pad(Widget w) =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: w);
}

class _S extends StatelessWidget {
  final double x, h;
  final double? w;
  final BorderRadius br;
  const _S({required this.x, required this.h, required this.br, this.w});

  @override
  Widget build(BuildContext context) => Container(
    width: w,
    height: h,
    decoration: BoxDecoration(
      borderRadius: br,
      gradient: LinearGradient(
        begin: Alignment(x - 1, 0),
        end: Alignment(x + 1, 0),
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
