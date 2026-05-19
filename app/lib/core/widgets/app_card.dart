import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../constants/app_sizes.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final double elevation;
  final Color? backgroundColor;
  final BorderSide? borderSide;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSizes.md),
    this.onTap,
    this.elevation = 1,
    this.backgroundColor,
    this.borderSide,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Determine shadow and border colors matching the design system
    List<BoxShadow> shadows = [];
    if (!isDark) {
      if (elevation == 1) {
        shadows = [
          BoxShadow(
            color: Colors.black.withAlpha(10), // ~4% black
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ];
      } else if (elevation == 2) {
        shadows = [
          BoxShadow(
            color: AppColors.deepNavy.withAlpha(20), // ~8% navy
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ];
      }
    }

    final cardBorder = borderSide ??
        BorderSide(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1,
        );

    final cardBg = backgroundColor ?? (isDark ? AppColors.darkCard : AppColors.lightCard);

    final cardDecoration = BoxDecoration(
      color: cardBg,
      borderRadius: BorderRadius.circular(AppSizes.radiusLg), // 16px radius for containers
      border: Border.fromBorderSide(cardBorder),
      boxShadow: shadows,
    );

    final innerChild = padding != null ? Padding(padding: padding!, child: child) : child;

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: cardDecoration,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(AppSizes.radiusLg),
              child: innerChild,
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: cardDecoration,
      child: innerChild,
    );
  }
}
