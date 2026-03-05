import 'package:dairy_farm_app/features/customers/controller/customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/color.dart';
import '../../../core/theme/text_styles.dart';

// ─────────────────────────────────────────────
// 1. HEADER
// ─────────────────────────────────────────────
class CustomersHeader extends GetView<CustomersController> {
  const CustomersHeader({super.key});

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
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Customers',
                    style: AppTextStyles.headline1.copyWith(
                      color: Colors.white,
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Manage dairy customers',
                    style: AppTextStyles.subtitle2.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: controller.onAddCustomer,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: Colors.white.withOpacity(0.5),
                      width: 1.2,
                    ),
                  ),
                ),
                child: Text(
                  'Add Customer',
                  style: AppTextStyles.button.copyWith(
                    color: Colors.white,
                    fontSize: 13,
                    letterSpacing: 0.3,
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
// 2. SEARCH BAR
// ─────────────────────────────────────────────
class CustomersSearchBar extends GetView<CustomersController> {
  const CustomersSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          controller: controller.searchController,
          style: AppTextStyles.bodyText1,
          decoration: InputDecoration(
            hintText: 'Search customers...',
            hintStyle: AppTextStyles.hint,
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: AppColors.textHint,
              size: 22,
            ),
            suffixIcon: Obx(
              () => controller.searchQuery.value.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Icons.close_rounded,
                        color: AppColors.textHint,
                        size: 20,
                      ),
                      onPressed: controller.clearSearch,
                    )
                  : const SizedBox.shrink(),
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 3. STATS ROW
// ─────────────────────────────────────────────
class CustomersStatsRow extends GetView<CustomersController> {
  const CustomersStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: _StatCard(
                icon: Icons.people_alt_outlined,
                iconColor: AppColors.primary,
                iconBg: AppColors.primary.withOpacity(0.10),
                label: 'Total\nCustomers',
                value: controller.totalCustomers.value.toString(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                icon: Icons.bar_chart_rounded,
                iconColor: AppColors.secondary,
                iconBg: AppColors.secondary.withOpacity(0.12),
                label: 'Active\nCustomers',
                value: controller.activeCustomers.value.toString(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                icon: Icons.account_balance_wallet_outlined,
                iconColor: AppColors.error,
                iconBg: AppColors.error.withOpacity(0.10),
                label: 'Pending Balance\nCustomers',
                value: controller.pendingBalance.value.toString(),
                showMenu: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String label;
  final String value;
  final bool showMenu;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.label,
    required this.value,
    this.showMenu = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 17),
              ),
              if (showMenu)
                Icon(
                  Icons.more_vert_rounded,
                  color: AppColors.textHint,
                  size: 18,
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(label, style: AppTextStyles.caption.copyWith(height: 1.35)),
          const SizedBox(height: 4),
          Text(value, style: AppTextStyles.headline3.copyWith(fontSize: 18)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 4. CUSTOMER LIST TILE
// ─────────────────────────────────────────────
class CustomerTile extends GetView<CustomersController> {
  final Map<String, String> customer;
  const CustomerTile({super.key, required this.customer});

  Color get _balanceColor {
    final b = customer['balance'] ?? '';
    return b.startsWith('+') ? AppColors.success : AppColors.error;
  }

  String get _formattedBalance {
    final b = customer['balance'] ?? '0';
    final isPos = b.startsWith('+');
    final num = b.replaceAll(RegExp(r'[+\-]'), '');
    return '${isPos ? '+' : '-'}${_formatNumber(num)}';
  }

  String _formatNumber(String n) {
    final v = int.tryParse(n) ?? 0;
    if (v >= 1000) {
      return '${(v / 1000).toStringAsFixed(v % 1000 == 0 ? 0 : 1)},000';
    }
    return n;
  }

  // Generate avatar colour from name
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
        (customer['name'] ?? '').codeUnits.fold(0, (a, b) => a + b) %
        colors.length;
    return colors[idx];
  }

  String get _initials {
    final parts = (customer['name'] ?? 'U').trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return parts[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.onCustomerTap(customer),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
        child: Row(
          children: [
            // Avatar
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _avatarColor,
              ),
              child: Center(
                child: Text(
                  _initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Name + phone + litres
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customer['name'] ?? '',
                    style: AppTextStyles.headline3.copyWith(fontSize: 15),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone_outlined,
                        size: 13,
                        color: AppColors.textHint,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        customer['phone'] ?? '',
                        style: AppTextStyles.caption,
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.water_drop_outlined,
                        size: 13,
                        color: AppColors.primary.withOpacity(0.7),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${customer['litersPerDay']}L/day',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Balance
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Balance:', style: AppTextStyles.caption),
                const SizedBox(height: 3),
                Text(
                  _formattedBalance,
                  style: AppTextStyles.headline3.copyWith(
                    fontSize: 15,
                    color: _balanceColor,
                    fontWeight: FontWeight.w700,
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

// ─────────────────────────────────────────────
// 5. SHIMMER SKELETON
// ─────────────────────────────────────────────
class CustomersShimmer extends StatefulWidget {
  const CustomersShimmer({super.key});

  @override
  State<CustomersShimmer> createState() => _CustomersShimmerState();
}

class _CustomersShimmerState extends State<CustomersShimmer>
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
      builder: (context, _) => SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _SBox(
              x: _shimmer.value,
              w: double.infinity,
              h: 130,
              br: const BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            const SizedBox(height: 20),
            // Search
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _SBox(
                x: _shimmer.value,
                w: double.infinity,
                h: 50,
                br: BorderRadius.circular(14),
              ),
            ),
            const SizedBox(height: 16),
            // Stats row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _SBox(
                      x: _shimmer.value,
                      h: 90,
                      br: BorderRadius.circular(14),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SBox(
                      x: _shimmer.value,
                      h: 90,
                      br: BorderRadius.circular(14),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SBox(
                      x: _shimmer.value,
                      h: 90,
                      br: BorderRadius.circular(14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // List tiles
            ...List.generate(
              5,
              (_) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 6,
                ),
                child: _SBox(
                  x: _shimmer.value,
                  w: double.infinity,
                  h: 78,
                  br: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SBox extends StatelessWidget {
  final double x, h;
  final double? w;
  final BorderRadius br;
  const _SBox({required this.x, required this.h, required this.br, this.w});

  @override
  Widget build(BuildContext context) {
    return Container(
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
}

// ─────────────────────────────────────────────
// 6. EMPTY STATE
// ─────────────────────────────────────────────
class CustomersEmptyState extends StatelessWidget {
  final String query;
  const CustomersEmptyState({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 56,
              color: AppColors.textHint.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text('No results for "$query"', style: AppTextStyles.subtitle1),
            const SizedBox(height: 6),
            Text(
              'Try a different name or phone number',
              style: AppTextStyles.caption,
            ),
          ],
        ),
      ),
    );
  }
}
