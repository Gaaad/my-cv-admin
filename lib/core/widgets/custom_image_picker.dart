import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future uploadFromGallery() async {
  File profileImage;

  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    profileImage = File(pickedFile.path);
    return profileImage;
  }
}

Future uploadFromCamera() async {
  File profileImage;

  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.camera);
  if (pickedFile != null) {
    profileImage = File(pickedFile.path);
    return profileImage;
  }
}
