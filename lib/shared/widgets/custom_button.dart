// lib/shared/widgets/custom_button.dart
import 'package:dairy_farm_app/core/theme/color.dart';
import 'package:dairy_farm_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final String title;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool iconAfterTitle;
  final bool isOutlined;
  final bool inRow;
  final TextStyle? customTextStyle;
  final bool useGradient;
  final bool isLoading;

  const CustomElevatedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.icon,
    this.iconAfterTitle = false,
    this.isOutlined = false,
    this.inRow = false,
    this.customTextStyle,
    this.useGradient = false,
    this.isLoading = false,
  }) : assert(
         inRow == false || customTextStyle != null,
         'If inRow is true, you must provide customTextStyle',
       );

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  bool _isAnimating = false;
  late AnimationController _controller;
  late Animation<double> _gradientAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _gradientAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() async {
    if (_isAnimating || widget.isLoading || widget.onPressed == null) return;
    setState(() => _isAnimating = true);

    _controller.forward();
    setState(() => _scale = 0.95);
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() => _scale = 1.0);
    await Future.delayed(const Duration(milliseconds: 100));
    _controller.reverse();

    widget.onPressed!();
    setState(() => _isAnimating = false);
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.isLoading || widget.onPressed == null;

    final textStyle = widget.inRow
        ? widget.customTextStyle!
        : widget.isOutlined
        ? AppTextStyles.bodyText1.copyWith(color: AppColors.primary)
        : AppTextStyles.button.copyWith(color: Colors.white);

    final iconColor = widget.isOutlined ? AppColors.primary : Colors.white;

    // ── Button child ──
    final buttonChild = widget.isLoading
        ? const _ThreeDots()
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null && !widget.iconAfterTitle) ...[
                Icon(widget.icon, color: iconColor, size: 20),
                const SizedBox(width: 8),
              ],
              Text(widget.title, style: textStyle),
              if (widget.icon != null && widget.iconAfterTitle) ...[
                const SizedBox(width: 8),
                Icon(widget.icon, color: iconColor, size: 20),
              ],
            ],
          );

    return SizedBox(
      width: double.infinity,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: widget.isOutlined
            ? OutlinedButton(
                onPressed: isDisabled ? null : _handleTap,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.primary, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: buttonChild,
              )
            : _buildGradientButton(buttonChild, isDisabled),
      ),
    );
  }

  Widget _buildGradientButton(Widget child, bool isDisabled) {
    if (!widget.useGradient) {
      return ElevatedButton(
        onPressed: isDisabled ? null : _handleTap,
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: isDisabled
              ? AppColors.primaryLight.withOpacity(0.5)
              : AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: child,
      );
    }

    return AnimatedBuilder(
      animation: _gradientAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: isDisabled
                ? LinearGradient(
                    colors: [
                      AppColors.primaryLight.withOpacity(0.5),
                      AppColors.primaryLight.withOpacity(0.3),
                    ],
                  )
                : LinearGradient(
                    colors: const [
                      AppColors.gradientStart,
                      AppColors.gradientMiddle,
                      AppColors.gradientEnd,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    transform: _GradientRotation(
                      _gradientAnimation.value * 0.5,
                    ),
                  ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: isDisabled
                ? []
                : [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: isDisabled ? null : _handleTap,
              borderRadius: BorderRadius.circular(30),
              splashColor: Colors.white.withOpacity(0.2),
              highlightColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: child,
              ),
            ),
          ),
        );
      },
      child: child,
    );
  }
}

// ─────────────────────────────────────────────
// THREE DOTS LOADER
// ─────────────────────────────────────────────
class _ThreeDots extends StatefulWidget {
  const _ThreeDots();

  @override
  State<_ThreeDots> createState() => _ThreeDotsState();
}

class _ThreeDotsState extends State<_ThreeDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (i) {
          // Each dot is offset by 200ms
          final delay = i * 0.25;
          return AnimatedBuilder(
            animation: _ctrl,
            builder: (_, __) {
              // Shift the animation phase per dot
              final t = (_ctrl.value + delay) % 1.0;
              // Bounce: goes up then comes back
              final offset = t < 0.5
                  ? Curves.easeOut.transform(t * 2) * -6.0
                  : Curves.easeIn.transform((t - 0.5) * 2) * -6.0 + 6.0 - 6.0;
              final scale =
                  0.7 +
                  0.3 *
                      (t < 0.5
                          ? Curves.easeOut.transform(t * 2)
                          : 1.0 - Curves.easeIn.transform((t - 0.5) * 2));

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Transform.translate(
                  offset: Offset(0, offset),
                  child: Transform.scale(
                    scale: scale,
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// GRADIENT TRANSFORM
// ─────────────────────────────────────────────
class _GradientRotation extends GradientTransform {
  final double value;
  const _GradientRotation(this.value);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * value, 0, 0);
  }
}
