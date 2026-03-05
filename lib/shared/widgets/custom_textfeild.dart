import 'package:dairy_farm_app/core/theme/color.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final double? height;
  final TextEditingController? controller;
  final FocusNode? focusNode; // ✅ Optional FocusNode
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final int? maxLines; // ✅ Optional maxLines
  final int? minLines; // ✅ Optional minLines
  final Function(String)? onChanged;
  final Function()? onTap;
  final bool readOnly;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.height,
    this.controller,
    this.focusNode, // ✅ Optional FocusNode parameter
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.maxLines = 1, // ✅ Default to 1 line
    this.minLines, // ✅ Optional minLines
    this.onChanged,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    final responsiveHeight = height ?? (maxLines == 1 ? h * 0.065 : null);
    final fontSize = h * 0.018;

    return SizedBox(
      height: responsiveHeight,
      width: w * 0.9,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode, // ✅ Use the provided FocusNode
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLines: maxLines, // ✅ Set maxLines
        minLines: minLines ?? (maxLines == 1 ? 1 : null), // ✅ Set minLines
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
            borderSide: const BorderSide(color: Colors.grey, width: 1.5),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.grey, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: AppColors.primary, width: w * 0.005),
          ),
        ),
      ),
    );
  }
}
