import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class ProfilePhotoWidget extends StatefulWidget {
  final Function(XFile?) onPhotoSelected;

  const ProfilePhotoWidget({
    Key? key,
    required this.onPhotoSelected,
  }) : super(key: key);

  @override
  State<ProfilePhotoWidget> createState() => _ProfilePhotoWidgetState();
}

class _ProfilePhotoWidgetState extends State<ProfilePhotoWidget> {
  XFile? _selectedImage;
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  bool _isCameraInitialized = false;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<bool> _requestCameraPermission() async {
    if (kIsWeb) return true;
    return (await Permission.camera.request()).isGranted;
  }

  Future<void> _initializeCamera() async {
    try {
      if (!await _requestCameraPermission()) return;

      _cameras = await availableCameras();
      if (_cameras.isEmpty) return;

      final camera = kIsWeb
          ? _cameras.firstWhere(
              (c) => c.lensDirection == CameraLensDirection.front,
              orElse: () => _cameras.first)
          : _cameras.firstWhere(
              (c) => c.lensDirection == CameraLensDirection.back,
              orElse: () => _cameras.first);

      _cameraController = CameraController(
          camera, kIsWeb ? ResolutionPreset.medium : ResolutionPreset.high);

      await _cameraController!.initialize();
      await _applySettings();

      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      // Silent fail - camera not available
    }
  }

  Future<void> _applySettings() async {
    if (_cameraController == null) return;

    try {
      await _cameraController!.setFocusMode(FocusMode.auto);
    } catch (e) {}

    if (!kIsWeb) {
      try {
        await _cameraController!.setFlashMode(FlashMode.auto);
      } catch (e) {}
    }
  }

  Future<void> _capturePhoto() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized)
      return;

    try {
      final XFile photo = await _cameraController!.takePicture();
      setState(() {
        _selectedImage = photo;
      });
      widget.onPhotoSelected(photo);
      Navigator.of(context).pop();
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> _pickFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = image;
        });
        widget.onPhotoSelected(image);
      }
      Navigator.of(context).pop();
    } catch (e) {
      // Handle error silently
    }
  }

  void _showPhotoOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      shape: RoundedRectangleBorder(
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
            Text(
              'Choose Profile Photo',
              style: AppTheme.lightTheme.textTheme.titleLarge,
            ),
            SizedBox(height: 3.h),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'camera_alt',
                color: AppTheme.primaryOrange,
                size: 24,
              ),
              title: Text(
                'Take Photo',
                style: AppTheme.lightTheme.textTheme.bodyLarge,
              ),
              onTap: () {
                Navigator.of(context).pop();
                _showCameraPreview();
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'photo_library',
                color: AppTheme.primaryOrange,
                size: 24,
              ),
              title: Text(
                'Choose from Gallery',
                style: AppTheme.lightTheme.textTheme.bodyLarge,
              ),
              onTap: _pickFromGallery,
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  void _showCameraPreview() {
    if (!_isCameraInitialized || _cameraController == null) {
      _pickFromGallery();
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.black,
        insetPadding: EdgeInsets.zero,
        child: Container(
          width: 100.w,
          height: 100.h,
          child: Stack(
            children: [
              Positioned.fill(
                child: CameraPreview(_cameraController!),
              ),
              Positioned(
                top: 8.h,
                left: 4.w,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: CustomIconWidget(
                    iconName: 'close',
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
              Positioned(
                bottom: 8.h,
                left: 0,
                right: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: _capturePhoto,
                    child: Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: AppTheme.primaryOrange,
                          width: 4,
                        ),
                      ),
                      child: Center(
                        child: CustomIconWidget(
                          iconName: 'camera_alt',
                          color: AppTheme.primaryOrange,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _showPhotoOptions,
          child: Container(
            width: 30.w,
            height: 30.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.lightTheme.colorScheme.primaryContainer,
              border: Border.all(
                color: AppTheme.primaryOrange.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: _selectedImage != null
                ? ClipOval(
                    child: kIsWeb
                        ? Image.network(
                            _selectedImage!.path,
                            width: 30.w,
                            height: 30.w,
                            fit: BoxFit.cover,
                          )
                        : CustomImageWidget(
                            imageUrl: _selectedImage!.path,
                            width: 30.w,
                            height: 30.w,
                            fit: BoxFit.cover,
                            semanticLabel: "Selected profile photo preview",
                          ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconWidget(
                        iconName: 'add_a_photo',
                        color: AppTheme.primaryOrange,
                        size: 32,
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'Add Photo',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.primaryOrange,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          'Choose Profile Photo',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.neutralMedium,
          ),
        ),
      ],
    );
  }
}
