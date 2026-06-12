import 'package:dependencies/image_picker/image_picker.dart';

/// Thin, testable wrapper around `image_picker` that captures a fridge photo
/// from the camera or gallery.
///
/// The underlying [ImagePicker] is injected so tests can supply a fake:
///
/// ```dart
/// final service = ImagePickerService();              // production
/// final service = ImagePickerService(picker: fake);  // test
/// ```
class ImagePickerService {
  ImagePickerService({
    ImagePicker? picker,
  }) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  /// Opens [source] and returns the compressed photo, or `null` when the user
  /// dismisses the picker without choosing one.
  ///
  /// Every photo is downscaled and re-encoded with the same defaults so the
  /// bytes sent to the AI stay small without hurting detection accuracy — the
  /// longest edge is capped at [maxWidth] and re-encoded at [imageQuality]%
  /// (PRD §4.2.1).
  Future<XFile?> pickImage(
    ImageSource source, {

    /// Largest edge, in logical pixels, the captured photo is scaled down to.
    double maxWidth = 1280,

    /// JPEG quality (0–100) the captured photo is re-encoded at.
    int imageQuality = 85,
  }) {
    return _picker.pickImage(
      source: source,
      maxWidth: maxWidth,
      imageQuality: imageQuality,
    );
  }
}
