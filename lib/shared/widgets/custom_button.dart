import 'package:dairy_farm_app/core/theme/color.dart';
import 'package:dairy_farm_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;
  final IconData? icon; // optional icon
  final bool iconAfterTitle; // controls icon position
  final bool isOutlined; // outlined style
  final bool inRow; // new flag
  final TextStyle? customTextStyle; // new style for inRow=true
  final bool useGradient; // new flag for gradient background

  const CustomElevatedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.icon,
    this.iconAfterTitle = false,
    this.isOutlined = false,
    this.inRow = false,
    this.customTextStyle,
    this.useGradient = false, // default false for backward compatibility
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
    if (_isAnimating) return;
    setState(() => _isAnimating = true);

    // Start gradient animation on press
    _controller.forward();

    // Shrink effect
    setState(() => _scale = 0.95);
    await Future.delayed(const Duration(milliseconds: 100));

    // Restore size
    setState(() => _scale = 1.0);
    await Future.delayed(const Duration(milliseconds: 100));

    // Reverse gradient animation
    _controller.reverse();

    // Execute callback
    widget.onPressed();

    setState(() => _isAnimating = false);
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = widget.inRow
        ? widget.customTextStyle!
        : widget.isOutlined
        ? AppTextStyles.bodyText1.copyWith(color: AppColors.primary)
        : AppTextStyles.button.copyWith(color: Colors.white);

    // Determine text color based on button type
    final iconColor = widget.isOutlined ? AppColors.primary : Colors.white;

    final buttonChild = Row(
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
                onPressed: _handleTap,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.primary, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: buttonChild,
              )
            : _buildGradientButton(buttonChild),
      ),
    );
  }

  Widget _buildGradientButton(Widget child) {
    if (!widget.useGradient) {
      return ElevatedButton(
        onPressed: _handleTap,
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: child,
      );
    }

    // Gradient button with animation
    return AnimatedBuilder(
      animation: _gradientAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [
                AppColors.gradientStart,
                AppColors.gradientMiddle,
                AppColors.gradientEnd,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: _GradientRotation(_gradientAnimation.value * 0.5),
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
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
              onTap: _handleTap,
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

// Custom gradient transform for animation
class _GradientRotation extends GradientTransform {
  final double value;

  const _GradientRotation(this.value);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * value, 0, 0);
  }
}
