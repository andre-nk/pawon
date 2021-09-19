part of "services.dart";

class ImageService{
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> pickImage(ImageSource source) async {
    try {
      XFile? _result = await _picker.pickImage(source: source, imageQuality: 25);
      return _result;
    } catch (e) {
      throw e;
    }
  }
}