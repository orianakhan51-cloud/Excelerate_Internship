import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/settings_item_widget.dart';
import './widgets/settings_section_widget.dart';
import './widgets/storage_info_widget.dart';
import './widgets/toggle_settings_item_widget.dart';
import './widgets/user_header_widget.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  // Mock user data
  final Map<String, dynamic> userData = {
    "id": 1,
    "name": "Sarah Johnson",
    "email": "sarah.johnson@email.com",
    "profileImage":
        "https://images.unsplash.com/photo-1650003775770-5e852b47741c",
    "profileImageSemanticLabel":
        "Professional headshot of a young woman with shoulder-length brown hair wearing a navy blue blazer, smiling at the camera against a neutral background",
    "learningStreak": 15,
    "joinDate": "2023-08-15",
    "coursesCompleted": 12,
    "totalLearningHours": 145
  };

  // Mock storage data
  final Map<String, dynamic> storageData = {
    "usedStorage": 2.4,
    "totalStorage": 16.0,
    "downloadedCourses": 8,
    "cacheSize": 0.6
  };

  // Settings state
  bool isDarkMode = false;
  bool courseUpdatesEnabled = true;
  bool achievementNotificationsEnabled = true;
  bool weeklyProgressEnabled = false;
  bool marketingCommunicationsEnabled = false;
  bool autoplayEnabled = true;
  bool biometricAuthEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Profile Settings",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: Theme.of(context).appBarTheme.elevation,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: Theme.of(context).appBarTheme.foregroundColor ??
                AppTheme.neutralDark,
            size: 6.w,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _showLogoutDialog,
            icon: CustomIconWidget(
              iconName: 'logout',
              color: AppTheme.errorRed,
              size: 6.w,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),

              // User Header
              UserHeaderWidget(
                userData: userData,
                onEditPressed: _editProfile,
              ),

              SizedBox(height: 2.h),

              // Account Settings Section
              SettingsSectionWidget(
                title: "Account",
                children: [
                  SettingsItemWidget(
                    title: "Edit Profile",
                    subtitle: "Update your personal information",
                    iconName: 'person',
                    onTap: _editProfile,
                  ),
                  SettingsItemWidget(
                    title: "Change Password",
                    subtitle: "Update your account password",
                    iconName: 'lock',
                    onTap: _changePassword,
                  ),
                  SettingsItemWidget(
                    title: "Email Preferences",
                    subtitle: "Manage email notifications",
                    iconName: 'email',
                    onTap: _emailPreferences,
                  ),
                  SettingsItemWidget(
                    title: "Privacy Settings",
                    subtitle: "Control your data and privacy",
                    iconName: 'privacy_tip',
                    onTap: _privacySettings,
                    showDivider: false,
                  ),
                ],
              ),

              // Learning Preferences Section
              SettingsSectionWidget(
                title: "Learning Preferences",
                children: [
                  SettingsItemWidget(
                    title: "Download Quality",
                    subtitle: "High Quality (720p)",
                    iconName: 'high_quality',
                    onTap: _downloadQuality,
                  ),
                  ToggleSettingsItemWidget(
                    title: "Autoplay Settings",
                    subtitle: "Automatically play next lesson",
                    iconName: 'play_circle',
                    value: autoplayEnabled,
                    onChanged: (value) {
                      setState(() {
                        autoplayEnabled = value;
                      });
                      _showToast("Autoplay ${value ? 'enabled' : 'disabled'}");
                    },
                  ),
                  SettingsItemWidget(
                    title: "Subtitle Language",
                    subtitle: "English",
                    iconName: 'subtitles',
                    onTap: _subtitleLanguage,
                  ),
                  SettingsItemWidget(
                    title: "Playback Speed",
                    subtitle: "1.25x",
                    iconName: 'speed',
                    onTap: _playbackSpeed,
                    showDivider: false,
                  ),
                ],
              ),

              // Notifications Section
              SettingsSectionWidget(
                title: "Notifications",
                children: [
                  ToggleSettingsItemWidget(
                    title: "Course Updates",
                    subtitle: "New lessons and announcements",
                    iconName: 'notifications',
                    value: courseUpdatesEnabled,
                    onChanged: (value) {
                      setState(() {
                        courseUpdatesEnabled = value;
                      });
                      _showToast(
                          "Course updates ${value ? 'enabled' : 'disabled'}");
                    },
                  ),
                  ToggleSettingsItemWidget(
                    title: "Achievement Notifications",
                    subtitle: "Badges and milestone alerts",
                    iconName: 'emoji_events',
                    value: achievementNotificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        achievementNotificationsEnabled = value;
                      });
                      _showToast(
                          "Achievement notifications ${value ? 'enabled' : 'disabled'}");
                    },
                  ),
                  ToggleSettingsItemWidget(
                    title: "Weekly Progress",
                    subtitle: "Learning summary reports",
                    iconName: 'trending_up',
                    value: weeklyProgressEnabled,
                    onChanged: (value) {
                      setState(() {
                        weeklyProgressEnabled = value;
                      });
                      _showToast(
                          "Weekly progress ${value ? 'enabled' : 'disabled'}");
                    },
                  ),
                  ToggleSettingsItemWidget(
                    title: "Marketing Communications",
                    subtitle: "Promotional offers and updates",
                    iconName: 'campaign',
                    value: marketingCommunicationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        marketingCommunicationsEnabled = value;
                      });
                      _showToast(
                          "Marketing communications ${value ? 'enabled' : 'disabled'}");
                    },
                    showDivider: false,
                  ),
                ],
              ),

              // Appearance Section
              SettingsSectionWidget(
                title: "Appearance",
                children: [
                  ToggleSettingsItemWidget(
                    title: "Dark Mode",
                    subtitle: "Switch to dark theme",
                    iconName: 'dark_mode',
                    value: isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        isDarkMode = value;
                      });
                      _showToast("Dark mode ${value ? 'enabled' : 'disabled'}");
                    },
                  ),
                  SettingsItemWidget(
                    title: "Language",
                    subtitle: "English (US)",
                    iconName: 'language',
                    onTap: _languageSettings,
                    showDivider: false,
                  ),
                ],
              ),

              // Storage Section
              SettingsSectionWidget(
                title: "Storage",
                children: [
                  StorageInfoWidget(
                    storageData: storageData,
                    onClearCache: _clearCache,
                    onManageDownloads: _manageDownloads,
                  ),
                ],
              ),

              // Security Section
              SettingsSectionWidget(
                title: "Security",
                children: [
                  ToggleSettingsItemWidget(
                    title: "Biometric Authentication",
                    subtitle: "Use fingerprint or face ID",
                    iconName: 'fingerprint',
                    value: biometricAuthEnabled,
                    onChanged: (value) {
                      setState(() {
                        biometricAuthEnabled = value;
                      });
                      _showToast(
                          "Biometric authentication ${value ? 'enabled' : 'disabled'}");
                    },
                    showDivider: false,
                  ),
                ],
              ),

              // Help & Support Section
              SettingsSectionWidget(
                title: "Help & Support",
                children: [
                  SettingsItemWidget(
                    title: "FAQ",
                    subtitle: "Frequently asked questions",
                    iconName: 'help',
                    onTap: _faqScreen,
                  ),
                  SettingsItemWidget(
                    title: "Contact Support",
                    subtitle: "Get help from our team",
                    iconName: 'support_agent',
                    onTap: _contactSupport,
                  ),
                  SettingsItemWidget(
                    title: "Rate App",
                    subtitle: "Share your feedback",
                    iconName: 'star_rate',
                    onTap: _rateApp,
                  ),
                  SettingsItemWidget(
                    title: "Terms of Service",
                    subtitle: "Legal terms and conditions",
                    iconName: 'description',
                    onTap: _termsOfService,
                    showDivider: false,
                  ),
                ],
              ),

              // Danger Zone Section
              SettingsSectionWidget(
                title: "Account Management",
                children: [
                  SettingsItemWidget(
                    title: "Delete Account",
                    subtitle: "Permanently delete your account",
                    iconName: 'delete_forever',
                    onTap: _showDeleteAccountDialog,
                    showDivider: false,
                  ),
                ],
              ),

              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }

  void _editProfile() {
    _showToast("Edit Profile feature coming soon");
  }

  void _changePassword() {
    _showToast("Change Password feature coming soon");
  }

  void _emailPreferences() {
    _showToast("Email Preferences feature coming soon");
  }

  void _privacySettings() {
    _showToast("Privacy Settings feature coming soon");
  }

  void _downloadQuality() {
    _showQualityDialog();
  }

  void _subtitleLanguage() {
    _showLanguageDialog();
  }

  void _playbackSpeed() {
    _showSpeedDialog();
  }

  void _languageSettings() {
    _showAppLanguageDialog();
  }

  void _clearCache() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Clear Cache"),
          content: Text(
              "This will clear ${storageData["cacheSize"]} GB of cached data. Downloaded courses will not be affected."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showToast("Cache cleared successfully");
              },
              child: Text("Clear"),
            ),
          ],
        );
      },
    );
  }

  void _manageDownloads() {
    _showToast("Manage Downloads feature coming soon");
  }

  void _faqScreen() {
    _showToast("FAQ feature coming soon");
  }

  void _contactSupport() {
    _showToast("Contact Support feature coming soon");
  }

  void _rateApp() {
    _showToast("Rate App feature coming soon");
  }

  void _termsOfService() {
    _showToast("Terms of Service feature coming soon");
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text(
              "Are you sure you want to logout? Your downloaded courses will remain available."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login-screen', (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.errorRed,
              ),
              child: Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Delete Account",
            style: TextStyle(color: AppTheme.errorRed),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("This action cannot be undone. Deleting your account will:"),
              SizedBox(height: 1.h),
              Text("• Remove all your progress and certificates"),
              Text("• Cancel any active subscriptions"),
              Text("• Delete your personal information"),
              Text("• Remove access to purchased courses"),
              SizedBox(height: 2.h),
              Text(
                "Are you absolutely sure?",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showToast("Account deletion request submitted");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.errorRed,
              ),
              child: Text("Delete Account"),
            ),
          ],
        );
      },
    );
  }

  void _showQualityDialog() {
    final List<String> qualities = [
      "Low (360p)",
      "Medium (480p)",
      "High (720p)",
      "Ultra (1080p)"
    ];
    String selectedQuality = "High (720p)";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Download Quality"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: qualities.map((quality) {
              return RadioListTile<String>(
                title: Text(quality),
                value: quality,
                groupValue: selectedQuality,
                onChanged: (value) {
                  selectedQuality = value!;
                  Navigator.pop(context);
                  _showToast("Download quality set to $selectedQuality");
                },
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _showLanguageDialog() {
    final List<String> languages = [
      "English",
      "Spanish",
      "French",
      "German",
      "Chinese",
      "Japanese"
    ];
    String selectedLanguage = "English";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Subtitle Language"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: languages.map((language) {
              return RadioListTile<String>(
                title: Text(language),
                value: language,
                groupValue: selectedLanguage,
                onChanged: (value) {
                  selectedLanguage = value!;
                  Navigator.pop(context);
                  _showToast("Subtitle language set to $selectedLanguage");
                },
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _showSpeedDialog() {
    final List<String> speeds = ["0.5x", "0.75x", "1x", "1.25x", "1.5x", "2x"];
    String selectedSpeed = "1.25x";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Playback Speed"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: speeds.map((speed) {
              return RadioListTile<String>(
                title: Text(speed),
                value: speed,
                groupValue: selectedSpeed,
                onChanged: (value) {
                  selectedSpeed = value!;
                  Navigator.pop(context);
                  _showToast("Playback speed set to $selectedSpeed");
                },
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _showAppLanguageDialog() {
    final List<Map<String, String>> languages = [
      {"name": "English (US)", "code": "en_US"},
      {"name": "Spanish", "code": "es"},
      {"name": "French", "code": "fr"},
      {"name": "German", "code": "de"},
      {"name": "Chinese", "code": "zh"},
      {"name": "Japanese", "code": "ja"},
    ];
    String selectedLanguage = "English (US)";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("App Language"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: languages.map((language) {
              return RadioListTile<String>(
                title: Text(language["name"]!),
                value: language["name"]!,
                groupValue: selectedLanguage,
                onChanged: (value) {
                  selectedLanguage = value!;
                  Navigator.pop(context);
                  _showToast("App language set to $selectedLanguage");
                },
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.neutralDark,
      textColor: AppTheme.surfaceWhite,
    );
  }
}
