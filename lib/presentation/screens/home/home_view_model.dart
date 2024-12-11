import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomeViewModel with ChangeNotifier {
  XFile? image;  // Directly store the image (no need for a getter)

  Future<void> pickCropAndMaskImage(BuildContext context) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        image = pickedImage; // Proceed to crop the image after picking

        final croppedFile = await ImageCropper().cropImage(
          sourcePath: image!.path,
          uiSettings: _getUiSettings(),
        );

        if (croppedFile != null) {
          image = XFile(croppedFile.path); // Store the cropped image
          notifyListeners(); // Notify listeners that the image has been updated

          // Show dialog with cropped image
          _showCroppedImageDialog(context, croppedFile.path);
        } else {
          debugPrint("Image cropping was canceled.");
        }
      } else {
        debugPrint("Image picking was canceled.");
      }
    } catch (e) {
      debugPrint("Error during image picking/cropping: $e");
    }
  }

  List<PlatformUiSettings> _getUiSettings() => [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.deepPurple,
          toolbarWidgetColor: Colors.white, // Adjusted for better visibility
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
          aspectRatioLockEnabled: false,
          showCancelConfirmationDialog: true,
        ),
      ];

  // Function to show a dialog with the cropped image
  void _showCroppedImageDialog(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cropped Image'),
          content: Image.file(
            File(imagePath), // Display the cropped image from the file
            fit: BoxFit.cover,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
