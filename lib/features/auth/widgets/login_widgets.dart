import 'dart:ui';

import 'package:flutter/material.dart';

class LoginWidgets {
  static Widget glassContainer({
    required BuildContext context,
    required Widget child,
  }) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(w * 0.05),
      decoration: BoxDecoration(
        // More whitish with slight transparency
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.5), width: 2.5),
        // Whiter gradient for more prominence
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.9),
            Colors.white.withOpacity(0.7),
            Colors.white.withOpacity(0.6),
            Colors.white.withOpacity(0.5),
          ],
          stops: const [0.0, 0.3, 0.6, 1.0],
        ),
        // Strong shadow for prominence
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 25,
            spreadRadius: 3,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: -3,
            offset: const Offset(-3, -3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 6,
            sigmaY: 6,
          ), // Slightly less blur for more clarity
          child: child,
        ),
      ),
    );
  }
}
