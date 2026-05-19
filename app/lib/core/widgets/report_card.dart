import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../constants/app_sizes.dart';
import 'app_card.dart';
import 'status_badge.dart';

class ReportCard extends StatelessWidget {
  final String title;
  final String status;
  final String location;
  final String timeAgo;
  final String? imageUrl;
  final VoidCallback onTap;

  const ReportCard({
    super.key,
    required this.title,
    required this.status,
    required this.location,
    required this.timeAgo,
    this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final titleStyle = theme.textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.w700,
      color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
    );

    final locationStyle = theme.textTheme.bodyMedium?.copyWith(
      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
    );

    final timeStyle = theme.textTheme.bodySmall?.copyWith(
      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
    );

    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // 1:1 Aspect ratio thumbnail on the left
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            child: Container(
              width: 72,
              height: 72,
              color: isDark ? AppColors.darkSurface : const Color(0xFFE5E7EB),
              child: imageUrl != null && imageUrl!.isNotEmpty
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported_outlined, size: 28),
                    )
                  : const Icon(Icons.image_outlined, size: 28),
            ),
          ),
          const SizedBox(width: 14),

          // Title, Location, and Status in center
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: titleStyle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    StatusBadge(status: status),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: locationStyle,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      timeAgo,
                      style: timeStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),

          // Chevron on the right
          Icon(
            Icons.chevron_right,
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            size: 20,
          ),
        ],
      ),
    );
  }
}
