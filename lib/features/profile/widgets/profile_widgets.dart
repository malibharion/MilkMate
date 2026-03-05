import 'package:dairy_farm_app/features/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/color.dart';
import '../../../core/theme/text_styles.dart';

// ─────────────────────────────────────────────
// 1. HEADER
// ─────────────────────────────────────────────
class ProfileHeader extends GetView<ProfileController> {
  const ProfileHeader({super.key});

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
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: logo + edit icon
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
                      style: AppTextStyles.headlineheader.copyWith(
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: controller.onEditProfile,
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.20),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white.withOpacity(0.35)),
                    ),
                    child: const Icon(
                      Icons.edit_outlined,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Avatar + name + role
            Row(
              children: [
                // Avatar circle
                Container(
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.25),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.6),
                      width: 2.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      controller.initials,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.fullName.value,
                      style: AppTextStyles.headline2.copyWith(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      controller.role.value,
                      style: AppTextStyles.subtitle2.copyWith(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
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
// 2. PROFILE INFO CARD
// ─────────────────────────────────────────────
class ProfileInfoCard extends GetView<ProfileController> {
  const ProfileInfoCard({super.key});

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
            _InfoRow(
              icon: Icons.person_outline_rounded,
              label: 'Full Name:',
              value: controller.fullName.value,
              showDivider: true,
            ),
            _InfoRow(
              icon: Icons.email_outlined,
              label: 'Email:',
              value: controller.email.value,
              showDivider: true,
            ),
            _InfoRow(
              icon: Icons.phone_outlined,
              label: 'Phone Number:',
              value: controller.phone.value,
              showDivider: true,
            ),
            _InfoRow(
              icon: Icons.workspace_premium_outlined,
              label: 'Role / Designation:',
              value: controller.role.value,
              showDivider: true,
            ),
            _InfoRow(
              icon: Icons.calendar_today_outlined,
              label: 'Joined Date:',
              value: controller.joinedDate.value,
              showDivider: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final bool showDivider;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.09),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: AppColors.primary, size: 18),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: AppTextStyles.caption),
                    const SizedBox(height: 3),
                    Text(
                      value,
                      style: AppTextStyles.bodyText1.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            color: AppColors.divider,
            indent: 16,
            endIndent: 16,
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// 3. SETTINGS SECTION
// ─────────────────────────────────────────────
class ProfileSettingsSection extends GetView<ProfileController> {
  const ProfileSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'App Settings',
            style: AppTextStyles.caption.copyWith(fontSize: 13),
          ),
          const SizedBox(height: 10),
          Container(
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
              children: [
                _SettingsTile(
                  icon: Icons.lock_outline_rounded,
                  label: 'Change Password',
                  onTap: controller.onChangePassword,
                  showDivider: true,
                ),
                _SettingsTile(
                  icon: Icons.notifications_outlined,
                  label: 'Notifications Preferences',
                  onTap: controller.onNotificationPrefs,
                  showDivider: true,
                ),
                _SettingsTile(
                  icon: Icons.palette_outlined,
                  label: 'App Theme (Light / Dark)',
                  onTap: controller.onAppTheme,
                  showDivider: true,
                ),
                _SettingsTile(
                  icon: Icons.language_rounded,
                  label: 'Language Preferences',
                  onTap: controller.onLanguagePrefs,
                  showDivider: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool showDivider;

  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.09),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 18),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    label,
                    style: AppTextStyles.bodyText1.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textHint,
                  size: 22,
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            color: AppColors.divider,
            indent: 16,
            endIndent: 16,
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// 4. LOGOUT BUTTON
// ─────────────────────────────────────────────
class LogoutButton extends GetView<ProfileController> {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.onLogout,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 4,
                shadowColor: AppColors.primary.withOpacity(0.4),
              ),
              child: Text(
                'Logout',
                style: AppTextStyles.button.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Requires confirmation',
            style: AppTextStyles.caption.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 5. EDIT FAB
// ─────────────────────────────────────────────
class ProfileEditFab extends GetView<ProfileController> {
  const ProfileEditFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: controller.onEditProfile,
      backgroundColor: AppColors.primary,
      elevation: 6,
      child: const Icon(Icons.edit_outlined, color: Colors.white, size: 22),
    );
  }
}

// ─────────────────────────────────────────────
// 6. SHIMMER
// ─────────────────────────────────────────────
class ProfileShimmer extends StatefulWidget {
  const ProfileShimmer({super.key});

  @override
  State<ProfileShimmer> createState() => _ProfileShimmerState();
}

class _ProfileShimmerState extends State<ProfileShimmer>
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
                w: 130,
                h: 20,
                br: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 12),
            _pad(
              _S(
                x: _shimmer.value,
                w: double.infinity,
                h: 280,
                br: BorderRadius.circular(18),
              ),
            ),
            const SizedBox(height: 24),
            _pad(
              _S(
                x: _shimmer.value,
                w: 120,
                h: 18,
                br: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 12),
            _pad(
              _S(
                x: _shimmer.value,
                w: double.infinity,
                h: 240,
                br: BorderRadius.circular(18),
              ),
            ),
            const SizedBox(height: 24),
            _pad(
              _S(
                x: _shimmer.value,
                w: double.infinity,
                h: 56,
                br: BorderRadius.circular(30),
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
