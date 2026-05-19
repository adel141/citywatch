import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Maps report statuses to their corresponding colors.
class StatusColors {
  StatusColors._();

  static Color forStatus(String status) {
    switch (status) {
      case 'submitted':
        return AppColors.civicBlue.withAlpha(180);
      case 'underReview':
        return AppColors.civicBlue;
      case 'assigned':
        return AppColors.assignedPurple;
      case 'inProgress':
        return AppColors.warningOrange;
      case 'resolved':
        return AppColors.successGreen;
      case 'rejected':
        return AppColors.dangerRed;
      case 'closed':
        return Colors.grey;
      case 'duplicate':
        return Colors.grey.shade500;
      default:
        return Colors.grey;
    }
  }

  static Color foregroundForStatus(String status) {
    return Colors.white;
  }
}
