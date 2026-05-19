import 'package:intl/intl.dart';

/// Date formatting utilities for CityWatch Canada.
class DateFormatter {
  DateFormatter._();

  /// "2 hours ago", "3 days ago", etc.
  static String timeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) {
      final m = diff.inMinutes;
      return '$m ${m == 1 ? 'minute' : 'minutes'} ago';
    }
    if (diff.inHours < 24) {
      final h = diff.inHours;
      return '$h ${h == 1 ? 'hour' : 'hours'} ago';
    }
    if (diff.inDays < 7) {
      final d = diff.inDays;
      return '$d ${d == 1 ? 'day' : 'days'} ago';
    }
    return DateFormat('MMM d, yyyy').format(dateTime);
  }

  /// "May 20, 2026"
  static String fullDate(DateTime dateTime) {
    return DateFormat('MMMM d, yyyy').format(dateTime);
  }

  /// "May 20, 2026 at 3:15 PM"
  static String fullDateTime(DateTime dateTime) {
    return DateFormat('MMMM d, yyyy \'at\' h:mm a').format(dateTime);
  }
}
