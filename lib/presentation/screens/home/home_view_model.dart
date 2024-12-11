import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class HomeViewModel with ChangeNotifier {
  XFile? image; // Directly accessible property

  Future<void> pickAndCropImage() async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        image = pickedImage; // Proceed to crop the image after picking

        final croppedFile = await ImageCropper().cropImage(
          sourcePath: image!.path,
          uiSettings: [
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
              showCancelConfirmationDialog: true,
            ),
          ],
        );

        if (croppedFile != null) {
          image = XFile(croppedFile.path); // Update the image with the cropped version
          notifyListeners();
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
}
