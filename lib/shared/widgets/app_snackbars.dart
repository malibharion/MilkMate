// lib/shared/widgets/app_snackbar.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SnackType { success, error, warning, info }

class AppSnackbar {
  AppSnackbar._();

  static void show({
    required String title,
    required String message,
    SnackType type = SnackType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    // Dismiss any existing snackbar first
    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();

    final config = _config(type);

    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: config.bg,
      colorText: Colors.white,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      borderRadius: 14,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      duration: duration,
      animationDuration: const Duration(milliseconds: 300),
      icon: Container(
        margin: const EdgeInsets.only(right: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.20),
          shape: BoxShape.circle,
        ),
        child: Icon(config.icon, color: Colors.white, size: 20),
      ),
      shouldIconPulse: false,
      titleText: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          color: Colors.white.withOpacity(0.92),
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
      ),
      boxShadows: [
        BoxShadow(
          color: config.bg.withOpacity(0.4),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  // ── Shortcuts ──
  static void success(String message, {String title = 'Success'}) =>
      show(title: title, message: message, type: SnackType.success);

  static void error(String message, {String title = 'Error'}) =>
      show(title: title, message: message, type: SnackType.error);

  static void warning(String message, {String title = 'Warning'}) =>
      show(title: title, message: message, type: SnackType.warning);

  static void info(String message, {String title = 'Info'}) =>
      show(title: title, message: message, type: SnackType.info);

  // ── Config ──
  static _SnackConfig _config(SnackType type) {
    switch (type) {
      case SnackType.success:
        return _SnackConfig(
          bg: const Color(0xFF22C55E),
          icon: Icons.check_circle_outline_rounded,
        );
      case SnackType.error:
        return _SnackConfig(
          bg: const Color(0xFFEF4444),
          icon: Icons.error_outline_rounded,
        );
      case SnackType.warning:
        return _SnackConfig(
          bg: const Color(0xFFF59E0B),
          icon: Icons.warning_amber_rounded,
        );
      case SnackType.info:
        return _SnackConfig(
          bg: const Color(0xFF2F6FE4),
          icon: Icons.info_outline_rounded,
        );
    }
  }
}

class _SnackConfig {
  final Color bg;
  final IconData icon;
  const _SnackConfig({required this.bg, required this.icon});
}
