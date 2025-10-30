import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/category_filter_chip.dart';
import './widgets/continue_learning_card.dart';
import './widgets/course_grid_card.dart';
import './widgets/recommended_course_card.dart';
import './widgets/search_header.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({Key? key}) : super(key: key);

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int _selectedBottomNavIndex = 0;
  String _selectedCategory = 'All';
  bool _isOffline = false;

  // Mock data for current learning course
  final Map<String, dynamic> _currentCourse = {
    'id': 1,
    'title': 'Complete Flutter Development Bootcamp',
    'instructor': 'Dr. Angela Yu',
    'thumbnail':
        'https://images.unsplash.com/photo-1617040619263-41c5a9ca7521',
    'semanticLabel':
        'Computer screen displaying colorful code editor with Flutter development environment',
    'progress': 0.65,
    'duration': '42 hours',
  };

  // Mock data for recommended courses
  final List<Map<String, dynamic>> _recommendedCourses = [
    {
      'id': 2,
      'title': 'React Native - The Practical Guide',
      'instructor': 'Maximilian Schwarzmüller',
      'thumbnail':
          'https://images.unsplash.com/photo-1687168644714-3343aa9b5af8',
      'semanticLabel':
          'Modern smartphone displaying mobile app interface with clean design elements',
      'rating': 4.8,
      'reviewCount': 12543,
      'price': '\$89.99',
      'duration': '38 hours',
      'isBookmarked': false,
    },
    {
      'id': 3,
      'title': 'iOS App Development with Swift',
      'instructor': 'Paul Hudson',
      'thumbnail':
          'https://images.unsplash.com/photo-1540448770000-b45ee5255411',
      'semanticLabel':
          'Apple iPhone showing iOS app development interface with Xcode simulator',
      'rating': 4.9,
      'reviewCount': 8765,
      'price': '\$94.99',
      'duration': '45 hours',
      'isBookmarked': true,
    },
    {
      'id': 4,
      'title': 'Machine Learning with Python',
      'instructor': 'Jose Portilla',
      'thumbnail':
          'https://images.unsplash.com/photo-1670681423906-0ee3ca2da3ae',
      'semanticLabel':
          'Computer screen showing Python code with data visualization charts and machine learning algorithms',
      'rating': 4.7,
      'reviewCount': 15432,
      'price': '\$79.99',
      'duration': '52 hours',
      'isBookmarked': false,
    },
  ];

  // Mock data for course grid
  final List<Map<String, dynamic>> _allCourses = [
    {
      'id': 5,
      'title': 'Web Development Bootcamp',
      'instructor': 'Colt Steele',
      'thumbnail':
          'https://images.unsplash.com/photo-1518773553398-650c184e0bb3',
      'semanticLabel':
          'Laptop computer displaying colorful web development code with HTML, CSS, and JavaScript',
      'rating': 4.6,
      'reviewCount': 23456,
      'price': '\$69.99',
      'level': 'Beginner',
      'category': 'Web Development',
      'isBookmarked': false,
    },
    {
      'id': 6,
      'title': 'Data Science Masterclass',
      'instructor': 'Kirill Eremenko',
      'thumbnail':
          'https://images.unsplash.com/photo-1583373325529-501e03a3a8e7',
      'semanticLabel':
          'Multiple computer monitors showing data analytics dashboards with colorful charts and graphs',
      'rating': 4.8,
      'reviewCount': 18765,
      'price': '\$99.99',
      'level': 'Intermediate',
      'category': 'Data Science',
      'isBookmarked': true,
    },
    {
      'id': 7,
      'title': 'UI/UX Design Complete Course',
      'instructor': 'Daniel Schifano',
      'thumbnail':
          'https://images.unsplash.com/photo-1595846870485-df6f64d1e510',
      'semanticLabel':
          'Designer workspace with tablet showing mobile app wireframes and design tools',
      'rating': 4.9,
      'reviewCount': 9876,
      'price': '\$84.99',
      'level': 'Beginner',
      'category': 'Design',
      'isBookmarked': false,
    },
    {
      'id': 8,
      'title': 'DevOps Engineering Bootcamp',
      'instructor': 'Stephane Maarek',
      'thumbnail':
          'https://images.unsplash.com/photo-1594914462951-6e5f1f353083',
      'semanticLabel':
          'Server room with multiple computer servers and networking equipment with blue LED lights',
      'rating': 4.7,
      'reviewCount': 12345,
      'price': '\$109.99',
      'level': 'Advanced',
      'category': 'DevOps',
      'isBookmarked': false,
    },
    {
      'id': 9,
      'title': 'Digital Marketing Mastery',
      'instructor': 'Phil Ebiner',
      'thumbnail':
          'https://images.unsplash.com/photo-1660732421009-469aba1c2e81',
      'semanticLabel':
          'Marketing analytics dashboard on laptop screen showing social media metrics and growth charts',
      'rating': 4.5,
      'reviewCount': 16789,
      'price': '\$59.99',
      'level': 'Beginner',
      'category': 'Marketing',
      'isBookmarked': true,
    },
    {
      'id': 10,
      'title': 'Cybersecurity Fundamentals',
      'instructor': 'Nathan House',
      'thumbnail':
          'https://images.unsplash.com/photo-1655404716621-fc9082e6e133',
      'semanticLabel':
          'Computer screen showing cybersecurity interface with network security monitoring and encryption data',
      'rating': 4.8,
      'reviewCount': 7654,
      'price': '\$89.99',
      'level': 'Intermediate',
      'category': 'Security',
      'isBookmarked': false,
    },
  ];

  final List<String> _categories = [
    'All',
    'Web Development',
    'Mobile Development',
    'Data Science',
    'Design',
    'DevOps',
    'Marketing',
    'Security',
  ];

  List<Map<String, dynamic>> get _filteredCourses {
    if (_selectedCategory == 'All') {
      return _allCourses;
    }
    return _allCourses
        .where((course) => course['category'] == _selectedCategory)
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _checkConnectivity() {
    // Simulate connectivity check
    setState(() {
      _isOffline = false;
    });
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedBottomNavIndex = index;
    });

    switch (index) {
      case 0:
        // Already on Home
        break;
      case 1:
        Navigator.pushNamed(context, '/course-catalog');
        break;
      case 2:
        // Navigate to My Learning
        break;
      case 3:
        Navigator.pushNamed(context, '/profile-settings');
        break;
    }
  }

  void _onSearchChanged(String query) {
    // Implement search functionality
    if (query.isNotEmpty) {
      // Filter courses based on search query
    }
  }

  void _onNotificationTap() {
    // Navigate to notifications
  }

  void _onProfileTap() {
    Navigator.pushNamed(context, '/profile-settings');
  }

  void _onResumeCourse() {
    Navigator.pushNamed(context, '/course-detail');
  }

  void _onCourseCardTap(Map<String, dynamic> course) {
    Navigator.pushNamed(context, '/course-detail');
  }

  void _onBookmarkTap(Map<String, dynamic> course) {
    setState(() {
      course['isBookmarked'] = !(course['isBookmarked'] as bool? ?? false);
    });
  }

  void _onCourseLongPress(Map<String, dynamic> course) {
    _showCourseContextMenu(course);
  }

  void _showCourseContextMenu(Map<String, dynamic> course) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.lightTheme.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.neutralMedium.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 3.h),
            _buildContextMenuItem(
              icon: 'bookmark_border',
              title: 'Bookmark Course',
              onTap: () {
                Navigator.pop(context);
                _onBookmarkTap(course);
              },
            ),
            _buildContextMenuItem(
              icon: 'share',
              title: 'Share Course',
              onTap: () {
                Navigator.pop(context);
                // Implement share functionality
              },
            ),
            _buildContextMenuItem(
              icon: 'visibility',
              title: 'View Details',
              onTap: () {
                Navigator.pop(context);
                _onCourseCardTap(course);
              },
            ),
            _buildContextMenuItem(
              icon: 'remove_circle_outline',
              title: 'Remove from Recommendations',
              onTap: () {
                Navigator.pop(context);
                // Implement remove functionality
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _buildContextMenuItem({
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: CustomIconWidget(
        iconName: icon,
        color: AppTheme.neutralDark,
        size: 24,
      ),
      title: Text(
        title,
        style: AppTheme.lightTheme.textTheme.bodyLarge,
      ),
      onTap: onTap,
    );
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  Future<void> _onRefresh() async {
    // Simulate refresh delay
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      // Refresh data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: Column(
        children: [
          SearchHeader(
            searchController: _searchController,
            onNotificationTap: _onNotificationTap,
            onProfileTap: _onProfileTap,
            onSearchChanged: _onSearchChanged,
          ),
          if (_isOffline)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 1.h),
              color: AppTheme.warningAmber,
              child: Text(
                'Offline mode - Showing cached content',
                textAlign: TextAlign.center,
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.surfaceWhite,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              color: AppTheme.primaryOrange,
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Continue Learning Section
                    ContinueLearningCard(
                      courseData: _currentCourse,
                      onResume: _onResumeCourse,
                    ),

                    // Recommended Courses Section
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recommended for You',
                            style: AppTheme.lightTheme.textTheme.headlineSmall
                                ?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/course-catalog'),
                            child: Text(
                              'See All',
                              style: AppTheme.lightTheme.textTheme.bodyMedium
                                  ?.copyWith(
                                color: AppTheme.primaryOrange,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 35.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        itemCount: _recommendedCourses.length,
                        itemBuilder: (context, index) {
                          final course = _recommendedCourses[index];
                          return RecommendedCourseCard(
                            courseData: course,
                            onTap: () => _onCourseCardTap(course),
                            onBookmark: () => _onBookmarkTap(course),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 3.h),

                    // Category Filters
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Text(
                        'Browse Categories',
                        style: AppTheme.lightTheme.textTheme.headlineSmall
                            ?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    SizedBox(height: 2.h),

                    SizedBox(
                      height: 6.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        itemCount: _categories.length,
                        itemBuilder: (context, index) {
                          final category = _categories[index];
                          return CategoryFilterChip(
                            category: category,
                            isSelected: _selectedCategory == category,
                            onTap: () => _onCategorySelected(category),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 3.h),

                    // Course Grid
                    _filteredCourses.isEmpty
                        ? _buildEmptyState()
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.75,
                                crossAxisSpacing: 3.w,
                                mainAxisSpacing: 3.w,
                              ),
                              itemCount: _filteredCourses.length,
                              itemBuilder: (context, index) {
                                final course = _filteredCourses[index];
                                return CourseGridCard(
                                  courseData: course,
                                  onTap: () => _onCourseCardTap(course),
                                  onBookmark: () => _onBookmarkTap(course),
                                  onLongPress: () => _onCourseLongPress(course),
                                );
                              },
                            ),
                          ),

                    SizedBox(height: 10.h), // Bottom padding for FAB
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedBottomNavIndex,
        onTap: _onBottomNavTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor:
            AppTheme.lightTheme.bottomNavigationBarTheme.backgroundColor,
        selectedItemColor:
            AppTheme.lightTheme.bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor:
            AppTheme.lightTheme.bottomNavigationBarTheme.unselectedItemColor,
        selectedLabelStyle:
            AppTheme.lightTheme.bottomNavigationBarTheme.selectedLabelStyle,
        unselectedLabelStyle:
            AppTheme.lightTheme.bottomNavigationBarTheme.unselectedLabelStyle,
        elevation: 8,
        items: [
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'home',
              color: _selectedBottomNavIndex == 0
                  ? AppTheme.primaryOrange
                  : AppTheme.neutralMedium,
              size: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'search',
              color: _selectedBottomNavIndex == 1
                  ? AppTheme.primaryOrange
                  : AppTheme.neutralMedium,
              size: 24,
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'play_circle_outline',
              color: _selectedBottomNavIndex == 2
                  ? AppTheme.primaryOrange
                  : AppTheme.neutralMedium,
              size: 24,
            ),
            label: 'My Learning',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'person_outline',
              color: _selectedBottomNavIndex == 3
                  ? AppTheme.primaryOrange
                  : AppTheme.neutralMedium,
              size: 24,
            ),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/course-catalog'),
        backgroundColor: AppTheme.primaryOrange,
        foregroundColor: AppTheme.surfaceWhite,
        elevation: 6,
        child: CustomIconWidget(
          iconName: 'search',
          color: AppTheme.surfaceWhite,
          size: 28,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(8.w),
      child: Column(
        children: [
          CustomIconWidget(
            iconName: 'school',
            color: AppTheme.neutralMedium,
            size: 80,
          ),
          SizedBox(height: 3.h),
          Text(
            'No courses found',
            style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              color: AppTheme.neutralMedium,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Try selecting a different category or explore our course catalog',
            textAlign: TextAlign.center,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.neutralMedium,
            ),
          ),
          SizedBox(height: 3.h),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/course-catalog'),
            child: const Text('Explore Courses'),
          ),
        ],
      ),
    );
  }
}
