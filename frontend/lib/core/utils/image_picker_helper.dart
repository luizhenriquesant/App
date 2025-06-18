// core/utils/image_picker_helper.dart
import 'package:image_picker/image_picker.dart';
import 'dart:io';

Future<File?> pickImageFromGallery() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    return File(pickedFile.path);
  }
  return null;
}