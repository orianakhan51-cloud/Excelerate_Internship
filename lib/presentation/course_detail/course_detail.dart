import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/course_header.dart';
import './widgets/course_hero_section.dart';
import './widgets/course_metrics.dart';
import './widgets/course_tabs.dart';
import './widgets/enrollment_bottom_bar.dart';
import './widgets/expandable_description.dart';

class CourseDetail extends StatefulWidget {
  const CourseDetail({Key? key}) : super(key: key);

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  bool _isBookmarked = false;
  bool _isEnrolled = false;
  late ScrollController _scrollController;
  bool _showHeader = false;

  // Mock course data
  final Map<String, dynamic> _courseData = {
    'id': 1,
    'title': 'Complete Flutter Development Bootcamp',
    'instructor': 'Dr. Angela Yu',
    'thumbnail':
        'https://images.pexels.com/photos/574071/pexels-photo-574071.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'thumbnailSemanticLabel':
        'Modern workspace with laptop displaying code editor, smartphone, and coffee cup on wooden desk',
    'previewVideo':
        'https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_1mb.mp4',
    'duration': '65h 30m',
    'rating': 4.7,
    'studentsCount': 125000,
    'difficulty': 'Beginner',
    'price': 89.99,
    'originalPrice': 199.99,
    'description':
        '''Learn Flutter and Dart from the ground up, step-by-step. Build beautiful, fast user interfaces for any device. Master Flutter development by building real-world apps including a chat app, personal expense tracker, and more.

This comprehensive course covers everything you need to know to become a professional Flutter developer. You'll learn the fundamentals of Dart programming, understand Flutter widgets, work with APIs, implement state management, and deploy your apps to both iOS and Android app stores.

Perfect for beginners with no prior mobile development experience, this course will take you from zero to hero in Flutter development. By the end, you'll have the skills and confidence to build your own mobile applications and even start a career as a Flutter developer.''',
    'skills': [
      'Build beautiful native mobile apps for iOS and Android',
      'Master Flutter widgets and layouts',
      'Understand Dart programming fundamentals',
      'Work with APIs and handle data',
      'Implement state management solutions',
      'Deploy apps to App Store and Google Play',
      'Create responsive designs for different screen sizes',
      'Handle user authentication and security',
    ],
    'requirements': [
      'No prior programming experience required',
      'A computer (Windows, Mac, or Linux)',
      'Willingness to learn and practice',
      'Basic understanding of mobile apps (helpful but not required)',
    ],
    'modules': [
      {
        'title': 'Getting Started with Flutter',
        'duration': '8h 15m',
        'lessons': [
          {
            'title': 'Introduction to Flutter and Dart',
            'duration': '15:30',
            'isCompleted': true,
          },
          {
            'title': 'Setting up Development Environment',
            'duration': '25:45',
            'isCompleted': true,
          },
          {
            'title': 'Your First Flutter App',
            'duration': '35:20',
            'isCompleted': false,
          },
          {
            'title': 'Understanding Widgets',
            'duration': '28:15',
            'isCompleted': false,
          },
        ],
      },
      {
        'title': 'Dart Programming Fundamentals',
        'duration': '12h 45m',
        'lessons': [
          {
            'title': 'Variables and Data Types',
            'duration': '22:30',
            'isCompleted': false,
          },
          {
            'title': 'Functions and Methods',
            'duration': '18:45',
            'isCompleted': false,
          },
          {
            'title': 'Object-Oriented Programming',
            'duration': '45:20',
            'isCompleted': false,
          },
        ],
      },
      {
        'title': 'Building User Interfaces',
        'duration': '15h 20m',
        'lessons': [
          {
            'title': 'Layout Widgets',
            'duration': '32:15',
            'isCompleted': false,
          },
          {
            'title': 'Styling and Theming',
            'duration': '28:30',
            'isCompleted': false,
          },
          {
            'title': 'Navigation and Routing',
            'duration': '35:45',
            'isCompleted': false,
          },
        ],
      },
    ],
    'reviews': [
      {
        'userName': 'Sarah Johnson',
        'userAvatar':
            'https://images.unsplash.com/photo-1702089050621-62646a2b748f',
        'userAvatarSemanticLabel':
            'Professional headshot of a woman with shoulder-length brown hair wearing a navy blazer',
        'rating': 5,
        'date': '2 weeks ago',
        'comment':
            'Excellent course! Dr. Angela explains everything clearly and the projects are really engaging. I went from knowing nothing about mobile development to building my own apps.',
      },
      {
        'userName': 'Michael Chen',
        'userAvatar':
            'https://images.unsplash.com/photo-1687256457585-3608dfa736c5',
        'userAvatarSemanticLabel':
            'Portrait of an Asian man with short black hair wearing a white collared shirt',
        'rating': 5,
        'date': '1 month ago',
        'comment':
            'Best Flutter course on the market. The step-by-step approach makes complex concepts easy to understand. Highly recommended for beginners!',
      },
      {
        'userName': 'Emily Rodriguez',
        'userAvatar':
            'https://images.unsplash.com/photo-1669829489410-928ebd917166',
        'userAvatarSemanticLabel':
            'Smiling woman with long dark hair wearing a light blue top against a neutral background',
        'rating': 4,
        'date': '3 weeks ago',
        'comment':
            'Great content and well-structured lessons. The only minor issue is that some videos could be a bit shorter, but overall fantastic value.',
      },
    ],
    'instructorDetails': {
      'name': 'Dr. Angela Yu',
      'title': 'Lead iOS Instructor at App Brewery',
      'avatar':
          'https://images.pexels.com/photos/1181686/pexels-photo-1181686.jpeg?auto=compress&cs=tinysrgb&w=400',
      'avatarSemanticLabel':
          'Professional headshot of a woman with long dark hair wearing glasses and a dark blazer',
      'rating': 4.8,
      'totalReviews': 45000,
      'totalStudents': 500000,
      'totalCourses': 12,
      'bio':
          '''Dr. Angela Yu is a developer with a passion for teaching. She is the lead instructor at the London App Brewery, London's leading Programming Bootcamp. She's helped hundreds of thousands of students learn to code and change their lives by becoming a developer.

Angela has been invited by companies such as Twitter, Facebook and Google to teach their employees. She has a degree in Computer Science from Imperial College London and was a developer at a number of Silicon Valley startups including her own.

She is committed to designing the most comprehensive programming courses available. Her courses are based on her experience of learning and teaching code over many years.''',
    },
  };

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset > 200 && !_showHeader) {
      setState(() {
        _showHeader = true;
      });
    } else if (_scrollController.offset <= 200 && _showHeader) {
      setState(() {
        _showHeader = false;
      });
    }
  }

  void _handleBackPressed() {
    Navigator.pop(context);
  }

  void _handleSharePressed() {
    // Share course functionality
    HapticFeedback.lightImpact();
    Fluttertoast.showToast(
      msg: "Course link copied to clipboard!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.neutralDark,
      textColor: AppTheme.surfaceWhite,
    );
  }

  void _handleBookmarkPressed() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
    HapticFeedback.lightImpact();
    Fluttertoast.showToast(
      msg: _isBookmarked ? "Course bookmarked!" : "Bookmark removed",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.neutralDark,
      textColor: AppTheme.surfaceWhite,
    );
  }

  void _handleEnrollPressed() {
    if (_isEnrolled) {
      // Navigate to course content
      Navigator.pushNamed(context, '/course-catalog');
    } else {
      // Handle enrollment
      setState(() {
        _isEnrolled = true;
      });
      HapticFeedback.mediumImpact();
      Fluttertoast.showToast(
        msg: "Successfully enrolled! Start learning now.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppTheme.successGreen,
        textColor: AppTheme.surfaceWhite,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Main content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Hero section
              SliverToBoxAdapter(
                child: CourseHeroSection(courseData: _courseData),
              ),

              // Course metrics
              SliverToBoxAdapter(
                child: CourseMetrics(courseData: _courseData),
              ),

              SliverToBoxAdapter(
                child: SizedBox(height: 2.h),
              ),

              // Course description
              SliverToBoxAdapter(
                child: ExpandableDescription(
                  description: _courseData['description'] ?? '',
                ),
              ),

              SliverToBoxAdapter(
                child: SizedBox(height: 3.h),
              ),

              // Course tabs
              SliverToBoxAdapter(
                child: CourseTabs(courseData: _courseData),
              ),

              // Bottom padding for enrollment bar
              SliverToBoxAdapter(
                child: SizedBox(height: 12.h),
              ),
            ],
          ),

          // Sticky header
          if (_showHeader)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CourseHeader(
                courseData: _courseData,
                onBackPressed: _handleBackPressed,
                onSharePressed: _handleSharePressed,
                onBookmarkPressed: _handleBookmarkPressed,
                isBookmarked: _isBookmarked,
              ),
            ),

          // Back button overlay (when header is not shown)
          if (!_showHeader)
            Positioned(
              top: 6.h,
              left: 4.w,
              child: GestureDetector(
                onTap: _handleBackPressed,
                child: Container(
                  width: 10.w,
                  height: 10.w,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: CustomIconWidget(
                    iconName: 'arrow_back',
                    color: AppTheme.surfaceWhite,
                    size: 5.w,
                  ),
                ),
              ),
            ),

          // Bookmark button overlay (when header is not shown)
          if (!_showHeader)
            Positioned(
              top: 6.h,
              right: 4.w,
              child: GestureDetector(
                onTap: _handleBookmarkPressed,
                child: Container(
                  width: 10.w,
                  height: 10.w,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: CustomIconWidget(
                    iconName: _isBookmarked ? 'bookmark' : 'bookmark_border',
                    color: _isBookmarked
                        ? AppTheme.primaryOrange
                        : AppTheme.surfaceWhite,
                    size: 5.w,
                  ),
                ),
              ),
            ),

          // Enrollment bottom bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: EnrollmentBottomBar(
              courseData: _courseData,
              onEnrollPressed: _handleEnrollPressed,
              isEnrolled: _isEnrolled,
            ),
          ),
        ],
      ),
    );
  }
}
