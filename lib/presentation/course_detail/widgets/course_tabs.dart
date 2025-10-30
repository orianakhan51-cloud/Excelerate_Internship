import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CourseTabs extends StatefulWidget {
  final Map<String, dynamic> courseData;

  const CourseTabs({
    Key? key,
    required this.courseData,
  }) : super(key: key);

  @override
  State<CourseTabs> createState() => _CourseTabsState();
}

class _CourseTabsState extends State<CourseTabs> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tab Bar
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            color: AppTheme.neutralLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: AppTheme.primaryOrange,
              borderRadius: BorderRadius.circular(12),
            ),
            labelColor: AppTheme.surfaceWhite,
            unselectedLabelColor: AppTheme.neutralMedium,
            labelStyle: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: AppTheme.lightTheme.textTheme.bodySmall,
            tabs: const [
              Tab(text: 'Overview'),
              Tab(text: 'Curriculum'),
              Tab(text: 'Reviews'),
              Tab(text: 'Instructor'),
            ],
          ),
        ),

        SizedBox(height: 2.h),

        // Tab Bar View
        SizedBox(
          height: 50.h,
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildOverviewTab(),
              _buildCurriculumTab(),
              _buildReviewsTab(),
              _buildInstructorTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewTab() {
    final List<String> skills =
        (widget.courseData['skills'] as List?)?.cast<String>() ?? [];
    final List<String> requirements =
        (widget.courseData['requirements'] as List?)?.cast<String>() ?? [];

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // What you'll learn
          Text(
            'What you\'ll learn',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          ...skills.map((skill) => Padding(
                padding: EdgeInsets.only(bottom: 1.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomIconWidget(
                      iconName: 'check_circle',
                      color: AppTheme.successGreen,
                      size: 4.w,
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Text(
                        skill,
                        style: AppTheme.lightTheme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              )),

          SizedBox(height: 3.h),

          // Requirements
          Text(
            'Requirements',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          ...requirements.map((requirement) => Padding(
                padding: EdgeInsets.only(bottom: 1.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomIconWidget(
                      iconName: 'fiber_manual_record',
                      color: AppTheme.neutralMedium,
                      size: 2.w,
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Text(
                        requirement,
                        style: AppTheme.lightTheme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildCurriculumTab() {
    final List<Map<String, dynamic>> modules =
        (widget.courseData['modules'] as List?)?.cast<Map<String, dynamic>>() ??
            [];

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Course Content',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          ...modules.asMap().entries.map((entry) {
            final index = entry.key;
            final module = entry.value;
            return _buildModuleItem(module, index + 1);
          }),
        ],
      ),
    );
  }

  Widget _buildModuleItem(Map<String, dynamic> module, int moduleNumber) {
    final List<Map<String, dynamic>> lessons =
        (module['lessons'] as List?)?.cast<Map<String, dynamic>>() ?? [];

    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
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
          'Module $moduleNumber: ${module['title'] ?? 'Module Title'}',
          style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          '${lessons.length} lessons • ${module['duration'] ?? '0h 0m'}',
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.neutralMedium,
          ),
        ),
        children: lessons
            .map((lesson) => ListTile(
                  leading: CustomIconWidget(
                    iconName: 'play_circle_outline',
                    color: AppTheme.primaryOrange,
                    size: 5.w,
                  ),
                  title: Text(
                    lesson['title'] ?? 'Lesson Title',
                    style: AppTheme.lightTheme.textTheme.bodyMedium,
                  ),
                  subtitle: Text(
                    lesson['duration'] ?? '0:00',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.neutralMedium,
                    ),
                  ),
                  trailing: lesson['isCompleted'] == true
                      ? CustomIconWidget(
                          iconName: 'check_circle',
                          color: AppTheme.successGreen,
                          size: 4.w,
                        )
                      : null,
                ))
            .toList(),
      ),
    );
  }

  Widget _buildReviewsTab() {
    final List<Map<String, dynamic>> reviews =
        (widget.courseData['reviews'] as List?)?.cast<Map<String, dynamic>>() ??
            [];
    final double rating =
        (widget.courseData['rating'] as num?)?.toDouble() ?? 4.5;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rating summary
          Container(
            padding: EdgeInsets.all(4.w),
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
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      rating.toStringAsFixed(1),
                      style:
                          AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primaryOrange,
                      ),
                    ),
                    Row(
                      children: List.generate(
                          5,
                          (index) => CustomIconWidget(
                                iconName: index < rating.floor()
                                    ? 'star'
                                    : 'star_border',
                                color: AppTheme.warningAmber,
                                size: 4.w,
                              )),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      '${reviews.length} reviews',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.neutralMedium,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Column(
                    children: List.generate(5, (index) {
                      final starCount = 5 - index;
                      final percentage = (starCount / 5) * 100;
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 0.5.h),
                        child: Row(
                          children: [
                            Text(
                              '$starCount',
                              style: AppTheme.lightTheme.textTheme.bodySmall,
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: LinearProgressIndicator(
                                value: percentage / 100,
                                backgroundColor: AppTheme.neutralLight,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppTheme.warningAmber,
                                ),
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              '${percentage.toInt()}%',
                              style: AppTheme.lightTheme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 3.h),

          // Reviews list
          Text(
            'Student Reviews',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          ...reviews.map((review) => _buildReviewItem(review)),
        ],
      ),
    );
  }

  Widget _buildReviewItem(Map<String, dynamic> review) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(4.w),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 5.w,
                child: CustomImageWidget(
                  imageUrl: review['userAvatar'] ?? '',
                  width: 10.w,
                  height: 10.w,
                  fit: BoxFit.cover,
                  semanticLabel:
                      review['userAvatarSemanticLabel'] ?? 'User profile photo',
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['userName'] ?? 'Anonymous',
                      style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        ...List.generate(
                            5,
                            (index) => CustomIconWidget(
                                  iconName: index < (review['rating'] ?? 0)
                                      ? 'star'
                                      : 'star_border',
                                  color: AppTheme.warningAmber,
                                  size: 3.w,
                                )),
                        SizedBox(width: 2.w),
                        Text(
                          review['date'] ?? '',
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.neutralMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            review['comment'] ?? '',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructorTab() {
    final Map<String, dynamic> instructor =
        widget.courseData['instructorDetails'] ?? {};

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Instructor profile
          Container(
            padding: EdgeInsets.all(4.w),
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
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 8.w,
                      child: CustomImageWidget(
                        imageUrl: instructor['avatar'] ?? '',
                        width: 16.w,
                        height: 16.w,
                        fit: BoxFit.cover,
                        semanticLabel: instructor['avatarSemanticLabel'] ??
                            'Instructor profile photo',
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            instructor['name'] ?? 'Instructor Name',
                            style: AppTheme.lightTheme.textTheme.titleMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            instructor['title'] ?? 'Professional Title',
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: AppTheme.neutralMedium,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            children: [
                              CustomIconWidget(
                                iconName: 'star',
                                color: AppTheme.warningAmber,
                                size: 4.w,
                              ),
                              SizedBox(width: 1.w),
                              Text(
                                '${instructor['rating'] ?? '4.8'} instructor rating',
                                style: AppTheme.lightTheme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),

                // Stats
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildInstructorStat(
                      'reviews',
                      '${instructor['totalReviews'] ?? '0'}',
                      'Reviews',
                    ),
                    _buildInstructorStat(
                      'people',
                      '${instructor['totalStudents'] ?? '0'}',
                      'Students',
                    ),
                    _buildInstructorStat(
                      'play_circle_outline',
                      '${instructor['totalCourses'] ?? '0'}',
                      'Courses',
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 3.h),

          // About instructor
          Text(
            'About ${instructor['name'] ?? 'Instructor'}',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            instructor['bio'] ?? 'Instructor biography not available.',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructorStat(String icon, String value, String label) {
    return Column(
      children: [
        CustomIconWidget(
          iconName: icon,
          color: AppTheme.primaryOrange,
          size: 6.w,
        ),
        SizedBox(height: 1.h),
        Text(
          value,
          style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.neutralMedium,
          ),
        ),
      ],
    );
  }
}
