import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/category_chip_widget.dart';
import './widgets/course_card_widget.dart';
import './widgets/filter_bottom_sheet_widget.dart';
import './widgets/search_bar_widget.dart';
import './widgets/skeleton_course_card_widget.dart';
import './widgets/sort_fab_widget.dart';

class CourseCatalog extends StatefulWidget {
  const CourseCatalog({Key? key}) : super(key: key);

  @override
  State<CourseCatalog> createState() => _CourseCatalogState();
}

class _CourseCatalogState extends State<CourseCatalog> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> _allCourses = [];
  List<Map<String, dynamic>> _filteredCourses = [];
  List<Map<String, dynamic>> _displayedCourses = [];
  Map<String, dynamic> _activeFilters = {};
  String _currentSort = 'popularity';
  bool _isLoading = false;
  bool _isLoadingMore = false;
  String _searchQuery = '';
  int _currentPage = 1;
  final int _coursesPerPage = 10;

  final List<String> _categories = [
    'Programming',
    'Design',
    'Business',
    'Marketing',
    'Data Science',
    'Photography'
  ];

  final List<String> _recentSearches = [
    'Flutter Development',
    'UI/UX Design',
    'Python Programming',
    'Digital Marketing'
  ];

  final List<String> _trendingTopics = [
    'Machine Learning',
    'React Native',
    'Blockchain',
    'Cloud Computing'
  ];

  void _onBottomNavTap(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.homeDashboard, (route) => false);
        break;
      case 1:
        // Already on course catalog
        break;
      case 2:
        // Navigate to My Learning (placeholder)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('My Learning - Coming Soon')),
        );
        break;
      case 3:
        Navigator.pushNamed(context, AppRoutes.profileSettings);
        break;
    }
  }

  void _navigateToHome() {
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.homeDashboard, (route) => false);
  }

  @override
  void initState() {
    super.initState();
    _initializeCourses();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _initializeCourses() {
    setState(() {
      _isLoading = true;
    });

    // Mock course data
    _allCourses = [
      {
        'id': 1,
        'title': 'Complete Flutter Development Bootcamp',
        'instructor': 'Dr. Angela Yu',
        'thumbnail':
            'https://images.unsplash.com/photo-1607266424522-ccef52eb95ac',
        'semanticLabel':
            'Person typing code on a laptop with multiple monitors showing programming interfaces',
        'rating': 4.8,
        'price': '\$89.99',
        'duration': '42 hours',
        'category': 'Programming',
        'difficulty': 'Intermediate',
        'language': 'English',
        'isBookmarked': false,
        'popularity': 95,
        'releaseDate': DateTime(2024, 1, 15),
      },
      {
        'id': 2,
        'title': 'UI/UX Design Masterclass',
        'instructor': 'Sarah Johnson',
        'thumbnail':
            'https://images.unsplash.com/photo-1575195662586-b6c9179a40b6',
        'semanticLabel':
            'Designer working on wireframes and user interface mockups on a desk with design tools',
        'rating': 4.7,
        'price': '\$79.99',
        'duration': '28 hours',
        'category': 'Design',
        'difficulty': 'Beginner',
        'language': 'English',
        'isBookmarked': true,
        'popularity': 88,
        'releaseDate': DateTime(2024, 2, 10),
      },
      {
        'id': 3,
        'title': 'Python for Data Science',
        'instructor': 'Michael Chen',
        'thumbnail':
            'https://images.unsplash.com/photo-1721525746389-fac9b1f423c5',
        'semanticLabel':
            'Data visualization charts and graphs displayed on computer screens with Python code',
        'rating': 4.9,
        'price': '\$99.99',
        'duration': '35 hours',
        'category': 'Data Science',
        'difficulty': 'Advanced',
        'language': 'English',
        'isBookmarked': false,
        'popularity': 92,
        'releaseDate': DateTime(2024, 1, 20),
      },
      {
        'id': 4,
        'title': 'Digital Marketing Strategy',
        'instructor': 'Emma Rodriguez',
        'thumbnail':
            'https://images.unsplash.com/photo-1690192699379-fb68bb749eaa',
        'semanticLabel':
            'Marketing team analyzing social media analytics and campaign performance on laptops',
        'rating': 4.6,
        'price': '\$69.99',
        'duration': '24 hours',
        'category': 'Marketing',
        'difficulty': 'Beginner',
        'language': 'English',
        'isBookmarked': false,
        'popularity': 85,
        'releaseDate': DateTime(2024, 3, 5),
      },
      {
        'id': 5,
        'title': 'Business Analytics Fundamentals',
        'instructor': 'David Kim',
        'thumbnail':
            'https://images.unsplash.com/photo-1504868584819-f8e8b4b6d7e3',
        'semanticLabel':
            'Business professional presenting analytics dashboard with charts and KPI metrics',
        'rating': 4.5,
        'price': '\$59.99',
        'duration': '18 hours',
        'category': 'Business',
        'difficulty': 'Intermediate',
        'language': 'English',
        'isBookmarked': true,
        'popularity': 78,
        'releaseDate': DateTime(2024, 2, 28),
      },
      {
        'id': 6,
        'title': 'Professional Photography Course',
        'instructor': 'Lisa Thompson',
        'thumbnail':
            'https://images.unsplash.com/photo-1661075838824-265ef33d6b69',
        'semanticLabel':
            'Professional photographer adjusting camera settings with photography equipment and lighting setup',
        'rating': 4.8,
        'price': '\$129.99',
        'duration': '32 hours',
        'category': 'Photography',
        'difficulty': 'Intermediate',
        'language': 'English',
        'isBookmarked': false,
        'popularity': 90,
        'releaseDate': DateTime(2024, 1, 8),
      },
      {
        'id': 7,
        'title': 'React Native Mobile Development',
        'instructor': 'James Wilson',
        'thumbnail':
            'https://images.unsplash.com/photo-1666470956471-30178dbe98ff',
        'semanticLabel':
            'Mobile app development workspace with smartphone, tablet, and code editor showing React Native',
        'rating': 4.7,
        'price': '\$94.99',
        'duration': '38 hours',
        'category': 'Programming',
        'difficulty': 'Advanced',
        'language': 'English',
        'isBookmarked': false,
        'popularity': 87,
        'releaseDate': DateTime(2024, 2, 15),
      },
      {
        'id': 8,
        'title': 'Graphic Design Essentials',
        'instructor': 'Maria Garcia',
        'thumbnail':
            'https://images.unsplash.com/photo-1572044162444-ad60f128bdea',
        'semanticLabel':
            'Graphic designer creating logo designs using digital drawing tablet and design software',
        'rating': 4.6,
        'price': '\$74.99',
        'duration': '26 hours',
        'category': 'Design',
        'difficulty': 'Beginner',
        'language': 'English',
        'isBookmarked': true,
        'popularity': 83,
        'releaseDate': DateTime(2024, 3, 12),
      },
    ];

    _applyFiltersAndSort();

    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreCourses();
    }
  }

  void _loadMoreCourses() {
    if (_isLoadingMore || _displayedCourses.length >= _filteredCourses.length)
      return;

    setState(() {
      _isLoadingMore = true;
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        final nextPage = _currentPage + 1;
        final startIndex = (_currentPage - 1) * _coursesPerPage;
        final endIndex =
            (nextPage * _coursesPerPage).clamp(0, _filteredCourses.length);

        _displayedCourses
            .addAll(_filteredCourses.sublist(startIndex, endIndex));
        _currentPage = nextPage;
        _isLoadingMore = false;
      });
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _currentPage = 1;
    });
    _applyFiltersAndSort();
  }

  void _applyFiltersAndSort() {
    List<Map<String, dynamic>> filtered = List.from(_allCourses);

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((course) {
        final title = (course['title'] as String).toLowerCase();
        final instructor = (course['instructor'] as String).toLowerCase();
        final category = (course['category'] as String).toLowerCase();
        final query = _searchQuery.toLowerCase();

        return title.contains(query) ||
            instructor.contains(query) ||
            category.contains(query);
      }).toList();
    }

    // Apply category filters
    final selectedCategories =
        _activeFilters['categories'] as List<String>? ?? [];
    if (selectedCategories.isNotEmpty) {
      filtered = filtered.where((course) {
        return selectedCategories.contains(course['category']);
      }).toList();
    }

    // Apply price range filter
    final minPrice = _activeFilters['minPrice'] as double?;
    final maxPrice = _activeFilters['maxPrice'] as double?;
    if (minPrice != null && maxPrice != null) {
      filtered = filtered.where((course) {
        final priceString = (course['price'] as String).replaceAll('\$', '');
        final price = double.tryParse(priceString) ?? 0.0;
        return price >= minPrice && price <= maxPrice;
      }).toList();
    }

    // Apply other filters
    if (_activeFilters['difficulty'] != null) {
      filtered = filtered.where((course) {
        return course['difficulty'] == _activeFilters['difficulty'];
      }).toList();
    }

    if (_activeFilters['language'] != null) {
      filtered = filtered.where((course) {
        return course['language'] == _activeFilters['language'];
      }).toList();
    }

    if (_activeFilters['minRating'] != null) {
      final minRating = _activeFilters['minRating'] as int;
      filtered = filtered.where((course) {
        return (course['rating'] as double) >= minRating;
      }).toList();
    }

    // Apply sorting
    _sortCourses(filtered);

    setState(() {
      _filteredCourses = filtered;
      _displayedCourses = filtered.take(_coursesPerPage).toList();
      _currentPage = 1;
    });
  }

  void _sortCourses(List<Map<String, dynamic>> courses) {
    switch (_currentSort) {
      case 'popularity':
        courses.sort((a, b) =>
            (b['popularity'] as int).compareTo(a['popularity'] as int));
        break;
      case 'rating':
        courses.sort(
            (a, b) => (b['rating'] as double).compareTo(a['rating'] as double));
        break;
      case 'price_low':
        courses.sort((a, b) {
          final priceA =
              double.tryParse((a['price'] as String).replaceAll('\$', '')) ??
                  0.0;
          final priceB =
              double.tryParse((b['price'] as String).replaceAll('\$', '')) ??
                  0.0;
          return priceA.compareTo(priceB);
        });
        break;
      case 'price_high':
        courses.sort((a, b) {
          final priceA =
              double.tryParse((a['price'] as String).replaceAll('\$', '')) ??
                  0.0;
          final priceB =
              double.tryParse((b['price'] as String).replaceAll('\$', '')) ??
                  0.0;
          return priceB.compareTo(priceA);
        });
        break;
      case 'newest':
        courses.sort((a, b) => (b['releaseDate'] as DateTime)
            .compareTo(a['releaseDate'] as DateTime));
        break;
      case 'duration':
        courses.sort((a, b) {
          final durationA =
              int.tryParse((a['duration'] as String).split(' ')[0]) ?? 0;
          final durationB =
              int.tryParse((b['duration'] as String).split(' ')[0]) ?? 0;
          return durationA.compareTo(durationB);
        });
        break;
    }
  }

  void _onFilterApplied(Map<String, dynamic> filters) {
    setState(() {
      _activeFilters = filters;
    });
    _applyFiltersAndSort();
  }

  void _onSortChanged(String sortType) {
    setState(() {
      _currentSort = sortType;
    });
    _applyFiltersAndSort();
  }

  void _toggleBookmark(int courseId) {
    setState(() {
      final courseIndex =
          _allCourses.indexWhere((course) => course['id'] == courseId);
      if (courseIndex != -1) {
        _allCourses[courseIndex]['isBookmarked'] =
            !(_allCourses[courseIndex]['isBookmarked'] as bool);
      }
    });
    _applyFiltersAndSort();
  }

  void _shareCourse(Map<String, dynamic> course) {
    // Share functionality would be implemented here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing "${course['title']}"'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _removeFilter(String filterKey) {
    setState(() {
      if (filterKey == 'categories') {
        _activeFilters.remove('categories');
      } else {
        _activeFilters.remove(filterKey);
      }
    });
    _applyFiltersAndSort();
  }

  void _clearAllFilters() {
    setState(() {
      _activeFilters.clear();
      _searchController.clear();
      _searchQuery = '';
    });
    _applyFiltersAndSort();
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    _initializeCourses();
  }

  void _onVoiceSearch() {
    // Voice search functionality would be implemented here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Voice search activated'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: _navigateToHome,
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.neutralDark,
            size: 24,
          ),
        ),
        title: Text(
          'Course Catalog',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.neutralDark,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _navigateToHome,
            icon: CustomIconWidget(
              iconName: 'home',
              color: AppTheme.neutralDark,
              size: 24,
            ),
          ),
          SizedBox(width: 2.w),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildStickyHeader(),
            _buildActiveFilters(),
            Expanded(
              child: _isLoading ? _buildLoadingState() : _buildContent(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Set to 1 since this is the Explore/Catalog screen
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
              color: AppTheme.neutralMedium,
              size: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'search',
              color: AppTheme.primaryOrange, // Active state
              size: 24,
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'play_circle_outline',
              color: AppTheme.neutralMedium,
              size: 24,
            ),
            label: 'My Learning',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'person_outline',
              color: AppTheme.neutralMedium,
              size: 24,
            ),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: SortFabWidget(
        currentSort: _currentSort,
        onSortChanged: _onSortChanged,
      ),
    );
  }

  Widget _buildStickyHeader() {
    return Container(
      color: AppTheme.lightTheme.scaffoldBackgroundColor,
      child: Column(
        children: [
          SearchBarWidget(
            controller: _searchController,
            onChanged: _onSearchChanged,
            onFilterTap: () => _showFilterBottomSheet(),
            onVoiceSearch: _onVoiceSearch,
          ),
          if (_searchQuery.isNotEmpty &&
              _displayedCourses.isEmpty &&
              !_isLoading)
            _buildSearchSuggestions(),
        ],
      ),
    );
  }

  Widget _buildActiveFilters() {
    if (_activeFilters.isEmpty) return const SizedBox.shrink();

    return Container(
      height: 8.h,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _getActiveFilterChips().length,
              itemBuilder: (context, index) {
                final filter = _getActiveFilterChips()[index];
                return CategoryChipWidget(
                  label: filter['label'] as String,
                  isSelected: true,
                  count: filter['count'] as int?,
                  onRemove: () => _removeFilter(filter['key'] as String),
                );
              },
            ),
          ),
          if (_activeFilters.isNotEmpty) ...[
            SizedBox(width: 2.w),
            TextButton(
              onPressed: _clearAllFilters,
              child: const Text('Clear All'),
            ),
          ],
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getActiveFilterChips() {
    List<Map<String, dynamic>> chips = [];

    final categories = _activeFilters['categories'] as List<String>? ?? [];
    for (String category in categories) {
      chips.add({
        'key': 'categories',
        'label': category,
        'count': null,
      });
    }

    if (_activeFilters['difficulty'] != null) {
      chips.add({
        'key': 'difficulty',
        'label': _activeFilters['difficulty'] as String,
        'count': null,
      });
    }

    if (_activeFilters['language'] != null) {
      chips.add({
        'key': 'language',
        'label': _activeFilters['language'] as String,
        'count': null,
      });
    }

    if (_activeFilters['minRating'] != null) {
      chips.add({
        'key': 'minRating',
        'label': '${_activeFilters['minRating']}+ Stars',
        'count': null,
      });
    }

    return chips;
  }

  Widget _buildSearchSuggestions() {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'No results found for "${_searchQuery}"',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            'Try searching for:',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.neutralMedium,
            ),
          ),
          SizedBox(height: 1.h),
          Wrap(
            spacing: 2.w,
            runSpacing: 1.h,
            children: _trendingTopics.map((topic) {
              return GestureDetector(
                onTap: () {
                  _searchController.text = topic;
                  _onSearchChanged(topic);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.w),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryOrange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppTheme.primaryOrange.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    topic,
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.primaryOrange,
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

  Widget _buildLoadingState() {
    return GridView.builder(
      padding: EdgeInsets.all(4.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4.w,
        mainAxisSpacing: 4.w,
        childAspectRatio: 0.75,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => const SkeletonCourseCardWidget(),
    );
  }

  Widget _buildContent() {
    if (_displayedCourses.isEmpty && _searchQuery.isNotEmpty) {
      return const SizedBox.shrink();
    }

    if (_displayedCourses.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: AppTheme.primaryOrange,
      child: GridView.builder(
        controller: _scrollController,
        padding: EdgeInsets.all(4.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4.w,
          mainAxisSpacing: 4.w,
          childAspectRatio: 0.75,
        ),
        itemCount: _displayedCourses.length + (_isLoadingMore ? 2 : 0),
        itemBuilder: (context, index) {
          if (index >= _displayedCourses.length) {
            return const SkeletonCourseCardWidget();
          }

          final course = _displayedCourses[index];
          return CourseCardWidget(
            course: course,
            onTap: () => Navigator.pushNamed(context, '/course-detail'),
            onBookmark: () => _toggleBookmark(course['id'] as int),
            onShare: () => _shareCourse(course),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'school',
              color: AppTheme.neutralMedium,
              size: 20.w,
            ),
            SizedBox(height: 4.h),
            Text(
              'No courses found',
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'Try adjusting your filters or search terms to find more courses.',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.neutralMedium,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),
            ElevatedButton(
              onPressed: _clearAllFilters,
              child: const Text('Clear Filters'),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheetWidget(
        currentFilters: _activeFilters,
        onApplyFilters: _onFilterApplied,
      ),
    );
  }
}
