// lib/shared/widgets/custom_textfeild.dart
import 'package:dairy_farm_app/core/theme/color.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final double? height;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final Function(String)? onChanged;
  final Function()? onTap;
  final bool readOnly;
  final String? errorText; // ← NEW

  const CustomTextField({
    super.key,
    required this.hintText,
    this.height,
    this.controller,
    this.focusNode,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.maxLines = 1,
    this.minLines,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.errorText, // ← NEW
  });

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    final hasError = errorText != null && errorText!.isNotEmpty;
    final responsiveHeight = height ?? (maxLines == 1 ? h * 0.065 : null);
    final fontSize = h * 0.018;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: responsiveHeight,
          width: w * 0.9,
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            obscureText: obscureText,
            keyboardType: keyboardType,
            maxLines: maxLines,
            minLines: minLines ?? (maxLines == 1 ? 1 : null),
            onChanged: onChanged,
            onTap: onTap,
            readOnly: readOnly,
            style: TextStyle(fontSize: fontSize),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.black54,
                fontSize: fontSize * 0.95,
              ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: w * 0.04,
                vertical: maxLines == 1 ? responsiveHeight! * 0.25 : h * 0.02,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: hasError ? AppColors.error : Colors.grey,
                  width: 1.5,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: hasError ? AppColors.error : Colors.grey,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: hasError ? AppColors.error : AppColors.primary,
                  width: w * 0.005,
                ),
              ),
            ),
          ),
        ),

        // ── Inline error text ──
        if (hasError) ...[
          const SizedBox(height: 5),
          Row(
            children: [
              const SizedBox(width: 4),
              Icon(
                Icons.error_outline_rounded,
                color: AppColors.error,
                size: 13,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  errorText!,
                  style: TextStyle(
                    color: AppColors.error,
                    fontSize: h * 0.014,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
