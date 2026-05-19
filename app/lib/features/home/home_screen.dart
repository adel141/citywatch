import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/widgets/category_card.dart';
import '../../core/widgets/report_card.dart';
import '../../core/widgets/app_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // popular categories on home page
    final List<Map<String, dynamic>> homeCategories = [
      {'label': 'Pothole', 'icon': Icons.construction_outlined, 'color': AppColors.mapleRed},
      {'label': 'Streetlight', 'icon': Icons.lightbulb_outline, 'color': Colors.amber},
      {'label': 'Snow & Ice', 'icon': Icons.ac_unit_outlined, 'color': Colors.blue},
      {'label': 'Garbage', 'icon': Icons.delete_outline_rounded, 'color': Colors.green},
    ];

    // mock reports list
    final List<Map<String, dynamic>> recentReports = [
      {
        'title': 'Large pothole in center lane',
        'status': 'underReview',
        'location': '120 Queen St W, Toronto',
        'timeAgo': '2 hours ago',
        'imageUrl': 'https://images.unsplash.com/photo-1515162305285-0293e4767cc2?auto=format&fit=crop&w=150&q=80',
      },
      {
        'title': 'Flickering streetlight bulb',
        'status': 'inProgress',
        'location': '45 Yonge St, Toronto',
        'timeAgo': '5 hours ago',
        'imageUrl': 'https://images.unsplash.com/photo-1509024644558-2f56ce76c490?auto=format&fit=crop&w=150&q=80',
      },
      {
        'title': 'Illegal waste dump in park',
        'status': 'resolved',
        'location': 'High Park Trail, Toronto',
        'timeAgo': '1 day ago',
        'imageUrl': 'https://images.unsplash.com/photo-1611284446314-60a58ac0deb9?auto=format&fit=crop&w=150&q=80',
      },
    ];

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.containerMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Top Header: Welcome, Greeting, Profile ──────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back,',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Alex Mercer',
                        style: GoogleFonts.inter(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: isDark ? AppColors.darkTextPrimary : AppColors.deepNavy,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => context.go('/profile'),
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: isDark ? AppColors.darkSurface : const Color(0xFFE5E7EB),
                      child: const Icon(Icons.person, color: AppColors.civicBlue, size: 24),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ── Search Input ────────────────────────────────────────────────
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 52,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkSurface : Colors.white,
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  border: Border.all(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search_rounded,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for active reports or locations...',
                          hintStyle: TextStyle(
                            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        style: TextStyle(
                          color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ── Categories Header & See All ─────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Explore Categories',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.darkTextPrimary : AppColors.deepNavy,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.push('/categories'),
                    child: Row(
                      children: [
                        Text(
                          'See All',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.civicBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: AppColors.civicBlue,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ── Categories Grid ─────────────────────────────────────────────
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.82,
                ),
                itemCount: homeCategories.length,
                itemBuilder: (context, index) {
                  final cat = homeCategories[index];
                  return CategoryCard(
                    label: cat['label'],
                    icon: cat['icon'],
                    color: cat['color'],
                    onTap: () {
                      // Navigate to report submission pre-selected with this category
                      context.push('/report/submit?category=${cat['label']}');
                    },
                  );
                },
              ),

              const SizedBox(height: 28),

              // ── Nearby Map Preview Header ────────────────────────────────────
              Text(
                'Nearby Activity',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.deepNavy,
                ),
              ),

              const SizedBox(height: 16),

              // ── Nearby Map Preview Card ──────────────────────────────────────
              AppCard(
                onTap: () => context.go('/map'),
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    // Mock Map Rendering
                    Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF0B192E) : const Color(0xFFE2E8F0),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(AppSizes.radiusLg),
                          topRight: Radius.circular(AppSizes.radiusLg),
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Diagonal roads lines drawn as visual background decoration
                          Positioned.fill(
                            child: CustomPaint(
                              painter: _MockMapPainter(isDark: isDark),
                            ),
                          ),
                          // Stylized map pin markers
                          const Positioned(
                            top: 40,
                            left: 80,
                            child: _MapPinMarker(status: 'underReview'),
                          ),
                          const Positioned(
                            bottom: 30,
                            right: 90,
                            child: _MapPinMarker(status: 'inProgress'),
                          ),
                          const Positioned(
                            top: 60,
                            right: 140,
                            child: _MapPinMarker(status: 'resolved'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Queen Street Area',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? AppColors.darkTextPrimary : AppColors.deepNavy,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '8 Active reports within 500m',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                                ),
                              ),
                            ],
                          ),
                          const Icon(Icons.arrow_forward_rounded, color: AppColors.civicBlue),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ── Recent Activity List Header ──────────────────────────────────
              Text(
                'Recent Reports',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.deepNavy,
                ),
              ),

              const SizedBox(height: 16),

              // ── Recent Activity list ─────────────────────────────────────────
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: recentReports.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final report = recentReports[index];
                  return ReportCard(
                    title: report['title'],
                    status: report['status'],
                    location: report['location'],
                    timeAgo: report['timeAgo'],
                    imageUrl: report['imageUrl'],
                    onTap: () {
                      // Navigate to details screen (Stage 7)
                      context.push('/report/details?id=$index');
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MapPinMarker extends StatelessWidget {
  final String status;

  const _MapPinMarker({required this.status});

  @override
  Widget build(BuildContext context) {
    Color markerColor = AppColors.civicBlue;
    if (status == 'underReview') markerColor = AppColors.warningOrange;
    if (status == 'inProgress') markerColor = AppColors.assignedPurple;
    if (status == 'resolved') markerColor = AppColors.successGreen;

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: markerColor.withOpacity(0.2),
        shape: BoxShape.circle,
        border: Border.all(color: markerColor, width: 1.5),
      ),
      child: Center(
        child: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: markerColor,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class _MockMapPainter extends CustomPainter {
  final bool isDark;

  _MockMapPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = (isDark ? Colors.white24 : Colors.black12)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    // Draw mock roads as lines crossing the preview area
    canvas.drawLine(Offset(0, size.height * 0.3), Offset(size.width, size.height * 0.5), paint);
    canvas.drawLine(Offset(size.width * 0.2, 0), Offset(size.width * 0.5, size.height), paint);
    canvas.drawLine(Offset(size.width * 0.7, 0), Offset(size.width * 0.9, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
