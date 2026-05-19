import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/widgets/category_card.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _allCategories = [
    {'label': 'Pothole', 'icon': Icons.construction_outlined, 'color': AppColors.mapleRed},
    {'label': 'Streetlight', 'icon': Icons.lightbulb_outline, 'color': Colors.amber},
    {'label': 'Snow & Ice', 'icon': Icons.ac_unit_outlined, 'color': Colors.blue},
    {'label': 'Garbage', 'icon': Icons.delete_outline_rounded, 'color': Colors.green},
    {'label': 'Graffiti', 'icon': Icons.format_paint_outlined, 'color': Colors.purple},
    {'label': 'Sidewalk', 'icon': Icons.directions_walk_outlined, 'color': Colors.teal},
    {'label': 'Park Issue', 'icon': Icons.nature_people_outlined, 'color': Colors.lightGreen},
    {'label': 'Flooding', 'icon': Icons.water_drop_outlined, 'color': Colors.indigo},
    {'label': 'Traffic Sign', 'icon': Icons.traffic_outlined, 'color': Colors.orange},
    {'label': 'Abandoned Car', 'icon': Icons.directions_car_outlined, 'color': Colors.blueGrey},
    {'label': 'Tree Care', 'icon': Icons.nature_outlined, 'color': Colors.green},
    {'label': 'Animal Control', 'icon': Icons.pets_outlined, 'color': Colors.brown},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final filteredCategories = _allCategories.where((cat) {
      final label = cat['label'].toString().toLowerCase();
      return label.contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: isDark ? AppColors.darkTextPrimary : AppColors.deepNavy,
        ),
        title: Text(
          'All Categories',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.darkTextPrimary : AppColors.deepNavy,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ── Search Input ────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.containerMargin, vertical: 8),
              child: Container(
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
                        controller: _searchController,
                        onChanged: (val) {
                          setState(() {
                            _searchQuery = val;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search categories...',
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
                    if (_searchQuery.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                        child: Icon(
                          Icons.clear_rounded,
                          size: 18,
                          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        ),
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ── Grid View of Categories ──────────────────────────────────────
            Expanded(
              child: filteredCategories.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 48,
                            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No categories match your search.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                            ),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.containerMargin,
                        vertical: 8,
                      ),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: filteredCategories.length,
                      itemBuilder: (context, index) {
                        final cat = filteredCategories[index];
                        return CategoryCard(
                          label: cat['label'],
                          icon: cat['icon'],
                          color: cat['color'],
                          onTap: () {
                            context.push('/report/submit?category=${cat['label']}');
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
