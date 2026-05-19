import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/status_colors.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final baseColor = StatusColors.forStatus(status);
    final textStyle = theme.textTheme.labelSmall;

    // Apply tint styling (10% opacity for background, full high-contrast color for text/border)
    // For dark mode, we can make the background slightly more visible (~20% opacity) or adjust text contrast.
    final double bgOpacity = isDark ? 0.20 : 0.12;
    final Color backgroundColor = baseColor.withOpacity(bgOpacity);
    final Color textColor = isDark ? _lighten(baseColor, 0.2) : _darken(baseColor, 0.2);

    // Format display string (e.g. underReview -> Under Review)
    final String label = _formatStatusLabel(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999), // full Pill (999px)
        border: Border.all(
          color: baseColor.withOpacity(isDark ? 0.4 : 0.2),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: textStyle?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  String _formatStatusLabel(String status) {
    if (status == 'underReview') return 'Under Review';
    if (status == 'inProgress') return 'In Progress';
    
    // Capitalize first letter
    if (status.isEmpty) return status;
    return status[0].toUpperCase() + status.substring(1);
  }

  // Color helper functions to ensure high contrast in badges
  Color _darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  Color _lighten(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }
}
