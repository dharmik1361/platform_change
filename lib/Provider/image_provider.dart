import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerProvider with ChangeNotifier {
  XFile? _pickedImage;

  XFile? get pickedImage => _pickedImage;

  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery, // You can change this to ImageSource.camera if needed
    );

    if (pickedImage != null) {
      _pickedImage = pickedImage;
      notifyListeners();
    }
  }

  void clearImage() {
    _pickedImage = null;
    notifyListeners();
  }
}
