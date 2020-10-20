import 'dart:io';

import 'package:image_picker/image_picker.dart';

enum PickType {
  Camera,
  Galerry,
}

class BaseServices {
  static Future<File> pickImage(PickType type) async {
    var image = await ImagePicker().getImage(
      source:
          (type == PickType.Camera) ? ImageSource.camera : ImageSource.gallery,
    );
    if (image != null) {
      return File(image.path);
    }
    return null;
  }
}
