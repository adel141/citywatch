import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../constants/app_sizes.dart';

enum AppButtonVariant { primary, secondary, text }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final IconData? icon;
  final double? width;
  final double height;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height = AppSizes.buttonHeight,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final isButtonEnabled = onPressed != null && !isLoading;

    Color backgroundColor = Colors.transparent;
    Color foregroundColor = Colors.white;
    BorderSide? borderSide;

    switch (variant) {
      case AppButtonVariant.primary:
        backgroundColor = isButtonEnabled
            ? AppColors.mapleRed
            : (isDark ? Colors.white24 : Colors.black12);
        foregroundColor = isButtonEnabled
            ? Colors.white
            : (isDark ? Colors.white38 : Colors.black38);
        break;
      case AppButtonVariant.secondary:
        backgroundColor = Colors.transparent;
        foregroundColor = isButtonEnabled
            ? (isDark ? AppColors.darkTextPrimary : AppColors.deepNavy)
            : (isDark ? Colors.white30 : Colors.black38);
        borderSide = BorderSide(
          color: isButtonEnabled
              ? (isDark ? AppColors.darkBorder : AppColors.lightBorder)
              : (isDark ? Colors.white12 : Colors.black12),
          width: 1.5,
        );
        break;
      case AppButtonVariant.text:
        backgroundColor = Colors.transparent;
        foregroundColor = isButtonEnabled
            ? AppColors.civicBlue
            : (isDark ? Colors.white30 : Colors.black38);
        break;
    }

    final content = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
            ),
          ),
          const SizedBox(width: 12),
        ] else if (icon != null) ...[
          Icon(icon, size: 20, color: foregroundColor),
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: theme.textTheme.titleMedium?.copyWith(
            color: foregroundColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
    );

    Widget buttonWidget;
    switch (variant) {
      case AppButtonVariant.primary:
        buttonWidget = ElevatedButton(
          onPressed: isButtonEnabled ? onPressed : null,
          style: buttonStyle,
          child: content,
        );
        break;
      case AppButtonVariant.secondary:
        buttonWidget = OutlinedButton(
          onPressed: isButtonEnabled ? onPressed : null,
          style: OutlinedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            side: borderSide ?? BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          child: content,
        );
        break;
      case AppButtonVariant.text:
        buttonWidget = TextButton(
          onPressed: isButtonEnabled ? onPressed : null,
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          child: content,
        );
        break;
    }

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: buttonWidget,
    );
  }
}
