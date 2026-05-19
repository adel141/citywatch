import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:citywatch_canada/core/theme/app_colors.dart';
import 'package:citywatch_canada/core/constants/app_strings.dart';


/// Splash / Welcome screen – the first screen the user sees.
///
/// Matches the Stitch splash_screen design: centered logo area,
/// "CityWatch Canada" title, tagline, continue button, and trust badge.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ── Top bar: "Secured by GovID" + Privacy / Terms ──────────────
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  Icon(
                    Icons.verified_user_outlined,
                    size: 16,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    AppStrings.securedByGovId,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                  const Spacer(),
                  _TopLink(label: AppStrings.privacy, isDark: isDark),
                  const SizedBox(width: 16),
                  _TopLink(label: AppStrings.terms, isDark: isDark),
                ],
              ),
            ),

            // ── Centered content ───────────────────────────────────────────
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo container
                      _LogoCard(isDark: isDark, size: size),

                      const SizedBox(height: 32),

                      // Title
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'CityWatch ',
                              style: GoogleFonts.inter(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                color: isDark
                                    ? AppColors.darkTextPrimary
                                    : AppColors.deepNavy,
                              ),
                            ),
                            TextSpan(
                              text: 'Canada',
                              style: GoogleFonts.inter(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                color: AppColors.mapleRed,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Tagline
                      Text(
                        AppStrings.tagline,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),

                      const SizedBox(height: 36),

                      // Continue button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.go('/welcome');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppStrings.continueText,
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.arrow_forward, size: 20),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Trust badge
                      Text(
                        AppStrings.trustedBy,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Bottom skyline decoration ──────────────────────────────────
            _SkylineDecoration(isDark: isDark),
          ],
        ),
      ),
    );
  }
}

// ─── Private widgets ──────────────────────────────────────────────────────────

class _TopLink extends StatelessWidget {
  const _TopLink({required this.label, required this.isDark});
  final String label;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: open privacy/terms pages
      },
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: isDark
              ? AppColors.darkTextSecondary
              : AppColors.lightTextSecondary,
        ),
      ),
    );
  }
}

/// Rounded card containing the logo graphic.
class _LogoCard extends StatelessWidget {
  const _LogoCard({required this.isDark, required this.size});
  final bool isDark;
  final Size size;

  @override
  Widget build(BuildContext context) {
    final cardSize = (size.shortestSide * 0.46).clamp(140.0, 260.0);

    return Container(
      width: cardSize,
      height: cardSize,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withAlpha(15),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
      ),
      child: Center(
        child: _LogoGraphic(size: cardSize * 0.65),
      ),
    );
  }
}

/// Paints the CityWatch Canada logo using Canvas:
/// city skyline silhouette, location-pin arc, and a maple leaf.
class _LogoGraphic extends StatelessWidget {
  const _LogoGraphic({required this.size});
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _LogoPainter(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 4),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'CityWatch ',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.deepNavy,
                    ),
                  ),
                  TextSpan(
                    text: 'Canada',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.mapleRed,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}

/// Custom painter that draws the logo: skyline + pin + maple-leaf.
class _LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height * 0.42;

    // ── Maple leaf (simplified) ───────────────────────────────────────────
    final leafPaint = Paint()..color = AppColors.mapleRed;
    final leafSize = size.width * 0.22;
    _drawMapleLeaf(canvas, Offset(cx, cy - leafSize * 0.3), leafSize, leafPaint);

    // ── Location-pin arc ─────────────────────────────────────────────────
    final arcPaint = Paint()
      ..color = AppColors.deepNavy
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.045
      ..strokeCap = StrokeCap.round;

    final arcRadius = size.width * 0.26;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy + arcRadius * 0.1), radius: arcRadius),
      2.5, // start angle
      -1.85, // sweep (upward arc)
      false,
      arcPaint,
    );
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy + arcRadius * 0.1), radius: arcRadius),
      0.65, // start angle
      1.85, // sweep
      false,
      arcPaint,
    );

    // Pin tip
    final tipPaint = Paint()..color = AppColors.deepNavy;
    final tipPath = Path()
      ..moveTo(cx, cy + arcRadius * 1.28)
      ..lineTo(cx - size.width * 0.032, cy + arcRadius * 1.05)
      ..lineTo(cx + size.width * 0.032, cy + arcRadius * 1.05)
      ..close();
    canvas.drawPath(tipPath, tipPaint);

    // ── City skyline silhouette ──────────────────────────────────────────
    final skyPaint = Paint()..color = AppColors.deepNavy;
    final baseY = size.height * 0.78;
    final skyPath = Path();

    // Draw a simplified Toronto-like skyline
    skyPath.moveTo(0, baseY);
    // Left buildings
    skyPath.lineTo(size.width * 0.05, baseY);
    skyPath.lineTo(size.width * 0.05, baseY - size.height * 0.06);
    skyPath.lineTo(size.width * 0.10, baseY - size.height * 0.06);
    skyPath.lineTo(size.width * 0.10, baseY - size.height * 0.10);
    skyPath.lineTo(size.width * 0.15, baseY - size.height * 0.10);
    skyPath.lineTo(size.width * 0.15, baseY - size.height * 0.04);
    // CN Tower area
    skyPath.lineTo(size.width * 0.22, baseY - size.height * 0.04);
    skyPath.lineTo(size.width * 0.24, baseY - size.height * 0.22);
    skyPath.lineTo(size.width * 0.245, baseY - size.height * 0.28);
    skyPath.lineTo(size.width * 0.248, baseY - size.height * 0.22);
    skyPath.lineTo(size.width * 0.26, baseY - size.height * 0.04);
    // Middle buildings
    skyPath.lineTo(size.width * 0.32, baseY - size.height * 0.04);
    skyPath.lineTo(size.width * 0.32, baseY - size.height * 0.12);
    skyPath.lineTo(size.width * 0.38, baseY - size.height * 0.12);
    skyPath.lineTo(size.width * 0.38, baseY - size.height * 0.16);
    skyPath.lineTo(size.width * 0.44, baseY - size.height * 0.16);
    skyPath.lineTo(size.width * 0.44, baseY - size.height * 0.08);
    skyPath.lineTo(size.width * 0.50, baseY - size.height * 0.08);
    skyPath.lineTo(size.width * 0.50, baseY - size.height * 0.14);
    skyPath.lineTo(size.width * 0.56, baseY - size.height * 0.14);
    skyPath.lineTo(size.width * 0.56, baseY - size.height * 0.06);
    // Right buildings
    skyPath.lineTo(size.width * 0.62, baseY - size.height * 0.06);
    skyPath.lineTo(size.width * 0.62, baseY - size.height * 0.18);
    skyPath.lineTo(size.width * 0.68, baseY - size.height * 0.18);
    skyPath.lineTo(size.width * 0.68, baseY - size.height * 0.10);
    skyPath.lineTo(size.width * 0.74, baseY - size.height * 0.10);
    skyPath.lineTo(size.width * 0.74, baseY - size.height * 0.06);
    skyPath.lineTo(size.width * 0.82, baseY - size.height * 0.06);
    skyPath.lineTo(size.width * 0.82, baseY - size.height * 0.12);
    skyPath.lineTo(size.width * 0.88, baseY - size.height * 0.12);
    skyPath.lineTo(size.width * 0.88, baseY - size.height * 0.04);
    skyPath.lineTo(size.width * 0.95, baseY - size.height * 0.04);
    skyPath.lineTo(size.width * 0.95, baseY);
    skyPath.lineTo(size.width, baseY);
    skyPath.lineTo(size.width, baseY + 2);
    skyPath.lineTo(0, baseY + 2);
    skyPath.close();

    canvas.drawPath(skyPath, skyPaint);
  }

  void _drawMapleLeaf(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path();
    final s = size;
    final x = center.dx;
    final y = center.dy;

    // Simplified maple leaf shape
    path.moveTo(x, y - s * 0.5); // Top point
    path.lineTo(x + s * 0.1, y - s * 0.3);
    path.lineTo(x + s * 0.35, y - s * 0.35);
    path.lineTo(x + s * 0.2, y - s * 0.15);
    path.lineTo(x + s * 0.45, y - s * 0.05);
    path.lineTo(x + s * 0.25, y + s * 0.05);
    path.lineTo(x + s * 0.3, y + s * 0.25);
    path.lineTo(x + s * 0.12, y + s * 0.2);
    path.lineTo(x, y + s * 0.4); // Bottom center
    path.lineTo(x - s * 0.12, y + s * 0.2);
    path.lineTo(x - s * 0.3, y + s * 0.25);
    path.lineTo(x - s * 0.25, y + s * 0.05);
    path.lineTo(x - s * 0.45, y - s * 0.05);
    path.lineTo(x - s * 0.2, y - s * 0.15);
    path.lineTo(x - s * 0.35, y - s * 0.35);
    path.lineTo(x - s * 0.1, y - s * 0.3);
    path.close();

    canvas.drawPath(path, paint);

    // Stem
    final stemPaint = Paint()
      ..color = paint.color
      ..strokeWidth = s * 0.06
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(x, y + s * 0.35),
      Offset(x, y + s * 0.55),
      stemPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Decorative bottom skyline that fades into the background.
class _SkylineDecoration extends StatelessWidget {
  const _SkylineDecoration({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: CustomPaint(
        painter: _BottomSkylinePainter(isDark: isDark),
      ),
    );
  }
}

class _BottomSkylinePainter extends CustomPainter {
  _BottomSkylinePainter({required this.isDark});
  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = (isDark ? AppColors.darkBorder : AppColors.lightBorder)
          .withAlpha(isDark ? 60 : 40);

    final baseY = size.height * 0.7;
    final path = Path();

    path.moveTo(0, baseY);
    // Simplified random skyline bars
    final barCount = 30;
    final barWidth = size.width / barCount;
    for (var i = 0; i < barCount; i++) {
      final heights = [0.15, 0.35, 0.25, 0.55, 0.20, 0.45, 0.30, 0.50,
                       0.18, 0.40, 0.60, 0.22, 0.48, 0.32, 0.42, 0.28,
                       0.52, 0.38, 0.20, 0.55, 0.35, 0.25, 0.45, 0.15,
                       0.50, 0.30, 0.40, 0.22, 0.48, 0.35];
      final h = heights[i % heights.length] * size.height;
      final x = i * barWidth;
      path.lineTo(x, baseY);
      path.lineTo(x, baseY - h);
      path.lineTo(x + barWidth * 0.8, baseY - h);
      path.lineTo(x + barWidth * 0.8, baseY);
    }
    path.lineTo(size.width, baseY);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
