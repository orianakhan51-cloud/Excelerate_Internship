import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FilterBottomSheetWidget extends StatefulWidget {
  final Map<String, dynamic> currentFilters;
  final Function(Map<String, dynamic>) onApplyFilters;

  const FilterBottomSheetWidget({
    Key? key,
    required this.currentFilters,
    required this.onApplyFilters,
  }) : super(key: key);

  @override
  State<FilterBottomSheetWidget> createState() =>
      _FilterBottomSheetWidgetState();
}

class _FilterBottomSheetWidgetState extends State<FilterBottomSheetWidget> {
  late Map<String, dynamic> _filters;
  final List<String> _categories = [
    'Programming',
    'Design',
    'Business',
    'Marketing',
    'Data Science',
    'Photography'
  ];
  final List<String> _difficulties = ['Beginner', 'Intermediate', 'Advanced'];
  final List<String> _languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Chinese'
  ];
  final List<String> _durations = [
    '0-2 hours',
    '2-5 hours',
    '5-10 hours',
    '10+ hours'
  ];

  @override
  void initState() {
    super.initState();
    _filters = Map<String, dynamic>.from(widget.currentFilters);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      decoration: const BoxDecoration(
        color: AppTheme.neutralLight,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCategorySection(),
                  SizedBox(height: 3.h),
                  _buildPriceRangeSection(),
                  SizedBox(height: 3.h),
                  _buildDurationSection(),
                  SizedBox(height: 3.h),
                  _buildDifficultySection(),
                  SizedBox(height: 3.h),
                  _buildLanguageSection(),
                  SizedBox(height: 3.h),
                  _buildRatingSection(),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: const BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            width: 12.w,
            height: 0.5.h,
            decoration: BoxDecoration(
              color: AppTheme.neutralMedium.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter Courses',
                style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: CustomIconWidget(
                  iconName: 'close',
                  color: AppTheme.neutralMedium,
                  size: 6.w,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection() {
    return _buildExpandableSection(
      'Categories',
      Wrap(
        spacing: 2.w,
        runSpacing: 1.h,
        children: _categories.map((category) {
          final isSelected = (_filters['categories'] as List<String>? ?? [])
              .contains(category);
          return GestureDetector(
            onTap: () => _toggleCategory(category),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.primaryOrange.withValues(alpha: 0.1)
                    : AppTheme.surfaceWhite,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppTheme.primaryOrange
                      : AppTheme.neutralMedium.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                category,
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: isSelected
                      ? AppTheme.primaryOrange
                      : AppTheme.neutralDark,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPriceRangeSection() {
    return _buildExpandableSection(
      'Price Range',
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${(_filters['minPrice'] as double? ?? 0.0).toInt()}',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '\$${(_filters['maxPrice'] as double? ?? 500.0).toInt()}',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          RangeSlider(
            values: RangeValues(
              _filters['minPrice'] as double? ?? 0.0,
              _filters['maxPrice'] as double? ?? 500.0,
            ),
            min: 0,
            max: 500,
            divisions: 50,
            activeColor: AppTheme.primaryOrange,
            inactiveColor: AppTheme.neutralLight,
            onChanged: (values) {
              setState(() {
                _filters['minPrice'] = values.start;
                _filters['maxPrice'] = values.end;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDurationSection() {
    return _buildExpandableSection(
      'Duration',
      Column(
        children: _durations.map((duration) {
          final isSelected = _filters['duration'] == duration;
          return RadioListTile<String>(
            title: Text(
              duration,
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
            value: duration,
            groupValue: _filters['duration'] as String?,
            activeColor: AppTheme.primaryOrange,
            onChanged: (value) {
              setState(() {
                _filters['duration'] = value;
              });
            },
            contentPadding: EdgeInsets.zero,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDifficultySection() {
    return _buildExpandableSection(
      'Difficulty Level',
      Column(
        children: _difficulties.map((difficulty) {
          final isSelected = _filters['difficulty'] == difficulty;
          return RadioListTile<String>(
            title: Text(
              difficulty,
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
            value: difficulty,
            groupValue: _filters['difficulty'] as String?,
            activeColor: AppTheme.primaryOrange,
            onChanged: (value) {
              setState(() {
                _filters['difficulty'] = value;
              });
            },
            contentPadding: EdgeInsets.zero,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLanguageSection() {
    return _buildExpandableSection(
      'Language',
      Column(
        children: _languages.map((language) {
          final isSelected = _filters['language'] == language;
          return RadioListTile<String>(
            title: Text(
              language,
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
            value: language,
            groupValue: _filters['language'] as String?,
            activeColor: AppTheme.primaryOrange,
            onChanged: (value) {
              setState(() {
                _filters['language'] = value;
              });
            },
            contentPadding: EdgeInsets.zero,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRatingSection() {
    return _buildExpandableSection(
      'Rating',
      Column(
        children: [4, 3, 2, 1].map((rating) {
          final isSelected = _filters['minRating'] == rating;
          return RadioListTile<int>(
            title: Row(
              children: [
                ...List.generate(5, (index) {
                  return CustomIconWidget(
                    iconName: index < rating ? 'star' : 'star_border',
                    color: index < rating
                        ? AppTheme.warningAmber
                        : AppTheme.neutralMedium,
                    size: 5.w,
                  );
                }),
                SizedBox(width: 2.w),
                Text(
                  '& up',
                  style: AppTheme.lightTheme.textTheme.bodyMedium,
                ),
              ],
            ),
            value: rating,
            groupValue: _filters['minRating'] as int?,
            activeColor: AppTheme.primaryOrange,
            onChanged: (value) {
              setState(() {
                _filters['minRating'] = value;
              });
            },
            contentPadding: EdgeInsets.zero,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildExpandableSection(String title, Widget content) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        iconColor: AppTheme.primaryOrange,
        collapsedIconColor: AppTheme.neutralMedium,
        children: [
          Padding(
            padding: EdgeInsets.all(4.w),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: const BoxDecoration(
        color: AppTheme.surfaceWhite,
        border: Border(
          top: BorderSide(
            color: AppTheme.neutralLight,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  _filters.clear();
                });
              },
              child: const Text('Clear All'),
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {
                widget.onApplyFilters(_filters);
                Navigator.pop(context);
              },
              child: const Text('Apply Filters'),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleCategory(String category) {
    setState(() {
      final categories = _filters['categories'] as List<String>? ?? <String>[];
      if (categories.contains(category)) {
        categories.remove(category);
      } else {
        categories.add(category);
      }
      _filters['categories'] = categories;
    });
  }
}
