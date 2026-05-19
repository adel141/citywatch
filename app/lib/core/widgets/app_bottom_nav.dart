import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../constants/app_strings.dart';
import '../constants/app_sizes.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final VoidCallback onReportTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onReportTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final barBg = isDark ? AppColors.darkSurface : AppColors.lightCard;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final inactiveColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final activeColor = AppColors.mapleRed;

    return Container(
      height: AppSizes.bottomNavHeight + MediaQuery.paddingOf(context).bottom,
      decoration: BoxDecoration(
        color: barBg,
        border: Border(
          top: BorderSide(color: borderColor, width: 1),
        ),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withAlpha(8), // soft Y-shadow
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.paddingOf(context).bottom,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Nav items
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_filled,
                label: AppStrings.home,
                isActive: currentIndex == 0,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                onTap: () => onTap(0),
              ),
              _NavItem(
                icon: Icons.map_outlined,
                label: AppStrings.map,
                isActive: currentIndex == 1,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                onTap: () => onTap(1),
              ),
              // Spacer for the center FAB
              const SizedBox(width: AppSizes.fabSize + 16),
              _NavItem(
                icon: Icons.notifications_none_outlined,
                label: AppStrings.alerts,
                isActive: currentIndex == 2,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                onTap: () => onTap(2),
              ),
              _NavItem(
                icon: Icons.person_outline,
                label: AppStrings.profile,
                isActive: currentIndex == 3,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                onTap: () => onTap(3),
              ),
            ],
          ),

          // Protruding Central FAB
          Positioned(
            top: -20, // push up slightly
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: AppSizes.fabSize + 8,
                height: AppSizes.fabSize + 8,
                decoration: BoxDecoration(
                  color: barBg,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: borderColor,
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.all(4),
                child: FloatingActionButton(
                  onPressed: onReportTap,
                  backgroundColor: AppColors.mapleRed,
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.add,
                    size: 28,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isActive ? activeColor : inactiveColor;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
