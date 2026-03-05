import 'package:dairy_farm_app/features/customers/controller/customer_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import '../../../core/theme/color.dart';
import '../../../core/theme/text_styles.dart';

// ─────────────────────────────────────────────
// 1. HEADER CARD
// ─────────────────────────────────────────────
class CustomerDetailHeader extends GetView<CustomerDetailController> {
  const CustomerDetailHeader({super.key});

  Color get _avatarColor {
    final colors = [
      const Color(0xFF5A9BFF),
      const Color(0xFF9B8FEF),
      const Color(0xFFF9A94C),
      const Color(0xFF6EDC5F),
      const Color(0xFFEF6B6B),
      const Color(0xFF4ECDC4),
    ];
    final idx =
        controller.customerName.value.codeUnits.fold(0, (a, b) => a + b) %
        colors.length;
    return colors[idx];
  }

  String get _initials {
    final parts = controller.customerName.value.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return parts[0][0].toUpperCase();
  }

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
      child: Obx(
        () => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Back button
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Avatar
            Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _avatarColor,
                border: Border.all(
                  color: Colors.white.withOpacity(0.6),
                  width: 2.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  _initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Name + phone + ID
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.customerName.value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    controller.customerPhone.value,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.20),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Cust ID: ${controller.customerId.value}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Action buttons
            Column(
              children: [
                _HeaderIconBtn(
                  icon: Icons.call_outlined,
                  onTap: controller.onCall,
                ),
                const SizedBox(height: 8),
                _HeaderIconBtn(
                  icon: Icons.edit_outlined,
                  onTap: controller.onEdit,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderIconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _HeaderIconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.20),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withOpacity(0.35), width: 1),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 2. OUTSTANDING BALANCE CARD
// ─────────────────────────────────────────────
class OutstandingBalanceCard extends GetView<CustomerDetailController> {
  const OutstandingBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8E7),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFFFE0A0), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFFFE4A0),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.account_balance_wallet_outlined,
                color: Color(0xFFB8860B),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Outstanding Balance',
                    style: AppTextStyles.caption.copyWith(fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        controller.balanceDisplay,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: controller.isPositive
                              ? AppColors.success
                              : AppColors.error,
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: controller.isPositive
                              ? AppColors.success.withOpacity(0.12)
                              : AppColors.error.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          controller.balanceLabel,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: controller.isPositive
                                ? AppColors.success
                                : AppColors.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 3. SECTION HEADER
// ─────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const SectionHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.headline3.copyWith(fontSize: 18)),
          const SizedBox(height: 3),
          Text(subtitle, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 4. MILK SUPPLY CHART CARD
// ─────────────────────────────────────────────
class MilkSupplyChartCard extends GetView<CustomerDetailController> {
  const MilkSupplyChartCard({super.key});

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
            // Chart
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
              child: SizedBox(
                height: 150,
                child: CustomPaint(
                  size: Size(MediaQuery.of(context).size.width - 40, 150),
                  painter: _LineChartPainter(data: controller.milkChartData),
                ),
              ),
            ),

            // Stats row
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.border, width: 0.8),
                ),
              ),
              child: Row(
                children: [
                  _ChartStat(
                    label: 'Total milk this week:',
                    value:
                        '${controller.totalMilkWeek.value.toStringAsFixed(0)}L',
                  ),
                  _vDivider(),
                  _ChartStat(
                    label: 'Average daily',
                    value: '${controller.avgDaily.value.toStringAsFixed(1)}L',
                  ),
                  _vDivider(),
                  _ChartStat(
                    label: 'Total month',
                    value:
                        '${controller.totalMilkMonth.value.toStringAsFixed(0)}L',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _vDivider() => Container(
    width: 1,
    height: 32,
    color: AppColors.divider,
    margin: const EdgeInsets.symmetric(horizontal: 10),
  );
}

class _ChartStat extends StatelessWidget {
  final String label, value;
  const _ChartStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.caption.copyWith(fontSize: 10),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 3),
          Text(value, style: AppTextStyles.headline3.copyWith(fontSize: 15)),
        ],
      ),
    );
  }
}

// ── Line chart painter ──
class _LineChartPainter extends CustomPainter {
  final List<Map<String, double>> data;
  _LineChartPainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    const padL = 12.0, padR = 12.0, padT = 16.0, padB = 16.0;
    final w = size.width - padL - padR;
    final h = size.height - padT - padB;

    final vals = data.map((e) => e['liters']!).toList();
    final minV = vals.reduce(math.min) - 2;
    final maxV = vals.reduce(math.max) + 2;
    final range = maxV - minV;

    Offset toPoint(int i, double v) {
      final x = padL + (i / (vals.length - 1)) * w;
      final y = padT + h - ((v - minV) / range) * h;
      return Offset(x, y);
    }

    // Grid lines
    final gridPaint = Paint()
      ..color = AppColors.border.withOpacity(0.6)
      ..strokeWidth = 0.8;
    for (int g = 0; g <= 3; g++) {
      final y = padT + (g / 3) * h;
      canvas.drawLine(Offset(padL, y), Offset(padL + w, y), gridPaint);
    }

    // Fill gradient
    final fillPath = Path();
    fillPath.moveTo(padL, padT + h);
    for (int i = 0; i < vals.length; i++) {
      final p = toPoint(i, vals[i]);
      if (i == 0)
        fillPath.lineTo(p.dx, p.dy);
      else {
        final prev = toPoint(i - 1, vals[i - 1]);
        final cpX = (prev.dx + p.dx) / 2;
        fillPath.cubicTo(cpX, prev.dy, cpX, p.dy, p.dx, p.dy);
      }
    }
    fillPath.lineTo(padL + w, padT + h);
    fillPath.close();
    canvas.drawPath(
      fillPath,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primary.withOpacity(0.25),
            AppColors.primary.withOpacity(0.03),
          ],
        ).createShader(Rect.fromLTWH(0, padT, size.width, h)),
    );

    // Line
    final linePaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final linePath = Path();
    for (int i = 0; i < vals.length; i++) {
      final p = toPoint(i, vals[i]);
      if (i == 0)
        linePath.moveTo(p.dx, p.dy);
      else {
        final prev = toPoint(i - 1, vals[i - 1]);
        final cpX = (prev.dx + p.dx) / 2;
        linePath.cubicTo(cpX, prev.dy, cpX, p.dy, p.dx, p.dy);
      }
    }
    canvas.drawPath(linePath, linePaint);

    // Peak dot
    final peakIdx = vals.indexOf(vals.reduce(math.max));
    final peakPt = toPoint(peakIdx, vals[peakIdx]);
    canvas.drawCircle(peakPt, 5, Paint()..color = AppColors.primary);
    canvas.drawCircle(peakPt, 3, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(_LineChartPainter old) => old.data != data;
}

// ─────────────────────────────────────────────
// 5. PAYMENT BAR CHART CARD
// ─────────────────────────────────────────────
class PaymentBarChartCard extends GetView<CustomerDetailController> {
  const PaymentBarChartCard({super.key});

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
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: 130,
          child: CustomPaint(
            size: Size(MediaQuery.of(context).size.width - 40, 130),
            painter: _BarChartPainter(count: controller.payments.length + 4),
          ),
        ),
      ),
    );
  }
}

class _BarChartPainter extends CustomPainter {
  final int count;
  _BarChartPainter({required this.count});

  @override
  void paint(Canvas canvas, Size size) {
    final rng = math.Random(99);
    final values = List.generate(count, (_) => 0.3 + rng.nextDouble() * 0.7);
    final barW = (size.width - 24) / count - 6;
    const padB = 16.0;
    const padT = 16.0;
    final maxH = size.height - padT - padB;

    for (int i = 0; i < count; i++) {
      final bH = values[i] * maxH;
      final x = 12 + i * (barW + 6);
      final y = size.height - padB - bH;

      final rr = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, barW, bH),
        const Radius.circular(6),
      );

      // Gradient bar
      canvas.drawRRect(
        rr,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.secondary, AppColors.secondary.withOpacity(0.6)],
          ).createShader(Rect.fromLTWH(x, y, barW, bH)),
      );
    }
  }

  @override
  bool shouldRepaint(_BarChartPainter _) => false;
}

// ─────────────────────────────────────────────
// 6. PAYMENT HISTORY TILE
// ─────────────────────────────────────────────
class PaymentHistoryList extends GetView<CustomerDetailController> {
  const PaymentHistoryList({super.key});

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
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: controller.payments.asMap().entries.map((entry) {
            final idx = entry.key;
            final p = entry.value;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: const Icon(
                          Icons.payments_outlined,
                          color: AppColors.secondary,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Payment received – ${p['amount']}',
                              style: AppTextStyles.bodyText1.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              p['timeLabel'] ?? '',
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (idx < controller.payments.length - 1)
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

// ─────────────────────────────────────────────
// 7. MILK RECORDS LIST
// ─────────────────────────────────────────────
class MilkRecordsList extends GetView<CustomerDetailController> {
  const MilkRecordsList({super.key});

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
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: controller.milkRecords.asMap().entries.map((entry) {
            final idx = entry.key;
            final r = entry.value;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 13,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date',
                        style: AppTextStyles.caption.copyWith(fontSize: 10),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${r['date']}  –  ${r['liters']}L  –  Rs${r['rate']}/L  –  Rs${r['total']}',
                          style: AppTextStyles.bodyText1.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (idx < controller.milkRecords.length - 1)
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

// ─────────────────────────────────────────────
// 8. SHIMMER SKELETON
// ─────────────────────────────────────────────
class CustomerDetailShimmer extends StatefulWidget {
  const CustomerDetailShimmer({super.key});

  @override
  State<CustomerDetailShimmer> createState() => _CustomerDetailShimmerState();
}

class _CustomerDetailShimmerState extends State<CustomerDetailShimmer>
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
          children: [
            _S(
              x: _shimmer.value,
              w: double.infinity,
              h: 148,
              br: const BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            const SizedBox(height: 20),
            _pad(
              _S(
                x: _shimmer.value,
                w: double.infinity,
                h: 90,
                br: BorderRadius.circular(18),
              ),
            ),
            const SizedBox(height: 20),
            _pad(
              _S(
                x: _shimmer.value,
                w: 200,
                h: 22,
                br: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 12),
            _pad(
              _S(
                x: _shimmer.value,
                w: double.infinity,
                h: 190,
                br: BorderRadius.circular(18),
              ),
            ),
            const SizedBox(height: 20),
            _pad(
              _S(
                x: _shimmer.value,
                w: 220,
                h: 22,
                br: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 12),
            _pad(
              _S(
                x: _shimmer.value,
                w: double.infinity,
                h: 130,
                br: BorderRadius.circular(18),
              ),
            ),
            const SizedBox(height: 8),
            _pad(
              _S(
                x: _shimmer.value,
                w: double.infinity,
                h: 170,
                br: BorderRadius.circular(18),
              ),
            ),
            const SizedBox(height: 20),
            _pad(
              _S(
                x: _shimmer.value,
                w: 160,
                h: 22,
                br: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 12),
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
