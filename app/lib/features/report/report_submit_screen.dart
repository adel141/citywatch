import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/app_card.dart';

class ReportSubmitScreen extends StatefulWidget {
  final String? initialCategory;

  const ReportSubmitScreen({
    super.key,
    this.initialCategory,
  });

  @override
  State<ReportSubmitScreen> createState() => _ReportSubmitScreenState();
}

class _ReportSubmitScreenState extends State<ReportSubmitScreen> {
  int _currentStep = 0; // 0: Photo, 1: Location, 2: Details, 3: Preview, 4: Success

  // Form State
  String? _selectedCategory;
  String? _selectedPhotoUrl;
  String _address = '250 Queen St W, Toronto, ON M5V 1Z1';
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  String _impactLevel = 'Medium'; // Low, Medium, High
  bool _isSubmitting = false;

  final _formKey = GlobalKey<FormState>();

  // Mock photo choices
  final List<Map<String, String>> _mockPhotos = [
    {
      'title': 'Pothole',
      'url': 'https://images.unsplash.com/photo-1515162305285-0293e4767cc2?auto=format&fit=crop&w=300&q=80',
    },
    {
      'title': 'Streetlight',
      'url': 'https://images.unsplash.com/photo-1509024644558-2f56ce76c490?auto=format&fit=crop&w=300&q=80',
    },
    {
      'title': 'Garbage',
      'url': 'https://images.unsplash.com/photo-1611284446314-60a58ac0deb9?auto=format&fit=crop&w=300&q=80',
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep == 2) {
      // Validate Details Screen
      if (_formKey.currentState!.validate()) {
        setState(() {
          _currentStep++;
        });
      }
    } else if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _prevStep() {
    if (_currentStep > 0 && _currentStep < 4) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _handleSubmit() async {
    setState(() {
      _isSubmitting = true;
    });

    // Simulate server submission delay
    await Future.delayed(const Duration(milliseconds: 1800));

    if (mounted) {
      setState(() {
        _isSubmitting = false;
        _currentStep = 4; // success screen
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (_currentStep == 4) {
      return _buildSuccessScreen(theme, isDark);
    }

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.close_rounded,
            color: isDark ? AppColors.darkTextPrimary : AppColors.deepNavy,
          ),
          onPressed: () {
            // Confirm exit dialog if user has entered data
            context.pop();
          },
        ),
        title: Text(
          'Submit Report',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.darkTextPrimary : AppColors.deepNavy,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ── Step Indicator Bar ──────────────────────────────────────────
            _buildStepIndicator(isDark),

            // ── Step Content Panel ──────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSizes.containerMargin),
                child: _buildCurrentStepContent(theme, isDark),
              ),
            ),

            // ── Bottom Nav buttons ──────────────────────────────────────────
            _buildBottomActionBar(isDark),
          ],
        ),
      ),
    );
  }

  // ── Step Indicator UI ──────────────────────────────────────────────────────
  Widget _buildStepIndicator(bool isDark) {
    final steps = ['Photo', 'Location', 'Details', 'Preview'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.containerMargin, vertical: 8),
      child: Row(
        children: List.generate(steps.length, (index) {
          final isCompleted = _currentStep > index;
          final isActive = _currentStep == index;

          Color indicatorColor = isDark ? Colors.white12 : Colors.black12;
          if (isActive) indicatorColor = AppColors.civicBlue;
          if (isCompleted) indicatorColor = AppColors.successGreen;

          return Expanded(
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: isActive || isCompleted ? indicatorColor : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isActive || isCompleted ? indicatorColor : (isDark ? Colors.white30 : Colors.black26),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: isCompleted
                        ? const Icon(Icons.check, size: 16, color: Colors.white)
                        : Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: isActive || isCompleted ? Colors.white : (isDark ? Colors.white54 : Colors.black54),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                  ),
                ),
                if (index < steps.length - 1)
                  Expanded(
                    child: Container(
                      height: 2,
                      color: isCompleted ? AppColors.successGreen : (isDark ? Colors.white24 : Colors.black12),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // ── Render Step Content ───────────────────────────────────────────────────
  Widget _buildCurrentStepContent(ThemeData theme, bool isDark) {
    switch (_currentStep) {
      case 0:
        return _buildPhotoStep(theme, isDark);
      case 1:
        return _buildLocationStep(theme, isDark);
      case 2:
        return _buildDetailsStep(theme, isDark);
      case 3:
        return _buildPreviewStep(theme, isDark);
      default:
        return const SizedBox();
    }
  }

  // ── Step 0: Photo Selection ────────────────────────────────────────────────
  Widget _buildPhotoStep(ThemeData theme, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Attach Photo',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.darkTextPrimary : AppColors.deepNavy,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Adding a clear photo helps city maintenance crews locate and understand the issue quickly.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
        ),
        const SizedBox(height: 28),

        // Photo Grid Selector
        Text(
          'SELECT MOCK PHOTO:',
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.0,
          ),
          itemCount: _mockPhotos.length,
          itemBuilder: (context, index) {
            final photo = _mockPhotos[index];
            final isSelected = _selectedPhotoUrl == photo['url'];

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPhotoUrl = photo['url'];
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  border: Border.all(
                    color: isSelected ? AppColors.civicBlue : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                    width: isSelected ? 3 : 1.5,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd - 2),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        photo['url']!,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: Colors.black54,
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            photo['title']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      if (isSelected)
                        Positioned(
                          top: 6,
                          right: 6,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: AppColors.civicBlue,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(2),
                            child: const Icon(Icons.check, size: 14, color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 24),

        // Skip / Custom Actions
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedPhotoUrl = null;
                  });
                  _nextStep();
                },
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : Colors.white,
                    borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                    border: Border.all(
                      color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.no_photography_outlined, size: 32, color: isDark ? Colors.white38 : Colors.black38),
                      const SizedBox(height: 8),
                      Text(
                        'Skip Photo',
                        style: TextStyle(
                          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── Step 1: Location Picker ───────────────────────────────────────────────
  Widget _buildLocationStep(ThemeData theme, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Location',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.darkTextPrimary : AppColors.deepNavy,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Verify the pin placement on the map. Drag or tap to relocate the incident.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
        ),
        const SizedBox(height: 24),

        // Interactive Mock Map View
        Container(
          height: 260,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF0B192E) : const Color(0xFFE2E8F0),
            borderRadius: BorderRadius.circular(AppSizes.radiusLg),
            border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
          ),
          child: Stack(
            children: [
              // Mock Map lines painter
              Positioned.fill(
                child: CustomPaint(
                  painter: _InteractiveMapPainter(isDark: isDark),
                ),
              ),
              // Main Interactive Pin in Center
              const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      size: 40,
                      color: AppColors.mapleRed,
                    ),
                    SizedBox(height: 12), // accounts for bottom alignment
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Editable Address Field
        AppTextField(
          label: 'VERIFIED ADDRESS',
          controller: TextEditingController(text: _address),
          hintText: 'Enter incident address',
          prefixIcon: const Icon(Icons.location_searching_rounded, size: 20),
          onChanged: (val) {
            _address = val;
          },
        ),
      ],
    );
  }

  // ── Step 2: Issue Details Form ─────────────────────────────────────────────
  Widget _buildDetailsStep(ThemeData theme, bool isDark) {
    final List<String> categoriesList = [
      'Pothole',
      'Streetlight',
      'Snow & Ice',
      'Garbage',
      'Graffiti',
      'Sidewalk',
      'Park Issue',
      'Flooding',
      'Traffic Sign',
      'Other',
    ];

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Incident Details',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.darkTextPrimary : AppColors.deepNavy,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Provide a title, choose the issue category, and describe the hazard so our teams can assign the appropriate crew.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
          ),
          const SizedBox(height: 24),

          // Category Selector Dropdown
          Text(
            'CATEGORY',
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
          ),
          const SizedBox(height: 8),
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
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: categoriesList.contains(_selectedCategory) ? _selectedCategory : null,
                hint: Text(
                  'Select category',
                  style: TextStyle(
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    fontSize: 14,
                  ),
                ),
                dropdownColor: isDark ? AppColors.darkSurface : Colors.white,
                style: TextStyle(
                  color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                  fontSize: 14,
                ),
                isExpanded: true,
                items: categoriesList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Title Input
          AppTextField(
            label: 'SHORT TITLE',
            hintText: 'e.g. Broken pothole near crosswalk',
            controller: _titleController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a title for the report.';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          // Description Input
          AppTextField(
            label: 'DESCRIPTION & DETAILS',
            hintText: 'Describe the issue, its size, exact location details, or how long it has been there...',
            controller: _descController,
            maxLines: 4,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a description of the issue.';
              }
              return null;
            },
          ),

          const SizedBox(height: 24),

          // Impact Level Segmented Buttons
          Text(
            'ESTIMATED IMPACT LEVEL',
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: ['Low', 'Medium', 'High'].map((level) {
              final isSelected = _impactLevel == level;
              Color activeColor = AppColors.civicBlue;
              if (level == 'Low') activeColor = AppColors.successGreen;
              if (level == 'Medium') activeColor = AppColors.warningOrange;
              if (level == 'High') activeColor = AppColors.dangerRed;

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _impactLevel = level;
                      });
                    },
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: isSelected ? activeColor.withAlpha(25) : Colors.transparent,
                        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                        border: Border.all(
                          color: isSelected ? activeColor : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          level,
                          style: TextStyle(
                            color: isSelected
                                ? (isDark ? Colors.white : activeColor)
                                : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ── Step 3: Preview Report Details ─────────────────────────────────────────
  Widget _buildPreviewStep(ThemeData theme, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preview Submission',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.darkTextPrimary : AppColors.deepNavy,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Please verify that all details of your report are correct before submitting to the city database.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
        ),
        const SizedBox(height: 24),

        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Photo Preview
              if (_selectedPhotoUrl != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  child: Image.network(
                    _selectedPhotoUrl!,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Header elements: Category badge + Impact badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.civicBlue.withAlpha(20),
                      borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                    ),
                    child: Text(
                      _selectedCategory ?? 'Uncategorized',
                      style: const TextStyle(
                        color: AppColors.civicBlue,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: (_impactLevel == 'High'
                              ? AppColors.dangerRed
                              : (_impactLevel == 'Medium' ? AppColors.warningOrange : AppColors.successGreen))
                          .withAlpha(20),
                      borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                    ),
                    child: Text(
                      '$_impactLevel Impact',
                      style: TextStyle(
                        color: _impactLevel == 'High'
                            ? AppColors.dangerRed
                            : (_impactLevel == 'Medium' ? AppColors.warningOrange : AppColors.successGreen),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Title
              Text(
                _titleController.text,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.deepNavy,
                ),
              ),

              const SizedBox(height: 12),

              // Description
              Text(
                _descController.text,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  height: 1.5,
                ),
              ),

              const Divider(height: 24, thickness: 1),

              // Location address
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on_rounded, color: AppColors.mapleRed, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _address,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark ? AppColors.darkTextPrimary : AppColors.deepNavy,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Step 4: Success Screen Content ──────────────────────────────────────────
  Widget _buildSuccessScreen(ThemeData theme, bool isDark) {
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.containerMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 3),

              // Checked Shield icon
              Center(
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: AppColors.successGreen.withAlpha(20),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check_circle_rounded,
                      size: 56,
                      color: AppColors.successGreen,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              Text(
                'Report Submitted!',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.deepNavy,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Your ticket has been logged in the City Database. Maintenance dispatch will evaluate the hazard priority and assign the crew.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 36),

              // Reference Number Details Card
              AppCard(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'TICKET REFERENCE',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '#CW-829031',
                          style: GoogleFonts.robotoMono(
                            color: AppColors.civicBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 20, thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'REPORTED CATEGORY',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _selectedCategory ?? 'Unspecified',
                          style: TextStyle(
                            color: isDark ? AppColors.darkTextPrimary : AppColors.deepNavy,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'INITIAL STATUS',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Under Review',
                          style: TextStyle(
                            color: AppColors.warningOrange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 3),

              // Action buttons
              AppButton(
                text: 'Return to Dashboard',
                onPressed: () {
                  context.go('/home');
                },
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // ── Action Bar Buttons at Bottom of steps ─────────────────────────────────
  Widget _buildBottomActionBar(bool isDark) {
    final isFirstStep = _currentStep == 0;
    final isLastStep = _currentStep == 3;

    return Container(
      padding: const EdgeInsets.all(AppSizes.containerMargin),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
        ),
      ),
      child: Row(
        children: [
          if (!isFirstStep) ...[
            Expanded(
              child: AppButton(
                text: 'Back',
                variant: AppButtonVariant.secondary,
                onPressed: _isSubmitting ? null : _prevStep,
              ),
            ),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: AppButton(
              text: isLastStep ? 'Submit Report' : 'Continue',
              isLoading: _isSubmitting,
              onPressed: isLastStep ? _handleSubmit : _nextStep,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Painter for Interactive Map Screen ──────────────────────────────────────
class _InteractiveMapPainter extends CustomPainter {
  final bool isDark;

  _InteractiveMapPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()..color = isDark ? const Color(0xFF0F1E33) : const Color(0xFFE2E8F0);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    final roadPaint = Paint()
      ..color = isDark ? Colors.white12 : Colors.white
      ..strokeWidth = 16
      ..style = PaintingStyle.stroke;

    // Draw main intersecting grid roads
    canvas.drawLine(Offset(0, size.height * 0.4), Offset(size.width, size.height * 0.4), roadPaint);
    canvas.drawLine(Offset(0, size.height * 0.7), Offset(size.width, size.height * 0.7), roadPaint);
    canvas.drawLine(Offset(size.width * 0.3, 0), Offset(size.width * 0.3, size.height), roadPaint);
    canvas.drawLine(Offset(size.width * 0.75, 0), Offset(size.width * 0.75, size.height), roadPaint);

    // Draw road labels / dashed lane markings
    final lanePaint = Paint()
      ..color = Colors.amber.withValues(alpha: 0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(0, size.height * 0.4), Offset(size.width, size.height * 0.4), lanePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
