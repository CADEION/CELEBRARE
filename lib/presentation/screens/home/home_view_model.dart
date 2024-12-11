import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:widget_mask/widget_mask.dart';

class HomeViewModel with ChangeNotifier {
  XFile? image;
  bool isLoading = false;
  String selectedMask = 'assets/images/user_image_frame_1.png';

  Future<void> pickCropAndMaskImage(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        image = pickedImage;
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: image!.path,
          uiSettings: _getUiSettings(),
        );

        if (croppedFile != null) {
          image = XFile(croppedFile.path);
          notifyListeners();
          _showMaskSelectionDialog(context, croppedFile.path);
        } else {
          debugPrint("Image cropping was canceled.");
        }
      } else {
        debugPrint("Image picking was canceled.");
      }
    } catch (e) {
      debugPrint("Error during image picking/cropping: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  List<PlatformUiSettings> _getUiSettings() => [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.deepPurple,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
          aspectRatioLockEnabled: false,
        ),
      ];

  void _showMaskSelectionDialog(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select a Mask'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              WidgetMask(
                blendMode: BlendMode.srcOver,
                mask: Image.file(File(imagePath), fit: BoxFit.fill),
                child:
                    Center(child: Image.asset(selectedMask, fit: BoxFit.cover)),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      selectedMask = 'assets/images/user_image_frame_1.png';
                      Navigator.of(context).pop();
                      notifyListeners();
                    },
                    child: Image.asset('assets/images/user_image_frame_1.png',
                        width: 50, height: 50),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectedMask = 'assets/images/user_image_frame_2.png';
                      Navigator.of(context).pop();
                      notifyListeners();
                    },
                    child: Image.asset('assets/images/user_image_frame_2.png',
                        width: 50, height: 50),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectedMask = 'assets/images/user_image_frame_3.png';
                      Navigator.of(context).pop();
                      notifyListeners();
                    },
                    child: Image.asset('assets/images/user_image_frame_3.png',
                        width: 50, height: 50),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectedMask = 'assets/images/user_image_frame_4.png';
                      Navigator.of(context).pop();
                      notifyListeners();
                    },
                    child: Image.asset('assets/images/user_image_frame_4.png',
                        width: 50, height: 50),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
