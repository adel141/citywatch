import 'package:flutter/material.dart';

/// Centralized color tokens for CityWatch Canada.
///
/// These values are derived from the Stitch design exports and the
/// ANTIGRAVITY_STITCH_BUILD_PROMPT color tokens.
class AppColors {
  AppColors._();

  // ── Brand ──────────────────────────────────────────────────────────────────
  static const Color mapleRed = Color(0xFFD62828);
  static const Color deepNavy = Color(0xFF0B1F3A);
  static const Color civicBlue = Color(0xFF2563EB);

  // ── Status ─────────────────────────────────────────────────────────────────
  static const Color successGreen = Color(0xFF16A34A);
  static const Color warningOrange = Color(0xFFF59E0B);
  static const Color dangerRed = Color(0xFFDC2626);
  static const Color assignedPurple = Color(0xFF7C3AED);

  // ── Light Theme ────────────────────────────────────────────────────────────
  static const Color lightBackground = Color(0xFFF7F9FC);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFE5E7EB);
  static const Color lightTextPrimary = Color(0xFF111827);
  static const Color lightTextSecondary = Color(0xFF6B7280);

  // ── Dark Theme ─────────────────────────────────────────────────────────────
  static const Color darkBackground = Color(0xFF07111F);
  static const Color darkSurface = Color(0xFF0F1E33);
  static const Color darkCard = Color(0xFF16263D);
  static const Color darkBorder = Color(0xFF26384F);
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFFCBD5E1);
}
