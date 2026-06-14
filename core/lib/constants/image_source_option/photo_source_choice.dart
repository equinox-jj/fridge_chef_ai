import 'image_source_option.dart';

/// What the user picked from the photo-source sheet: a capture source, or the
/// explicit "remove current photo" action.
enum PhotoSourceChoice {
  camera,
  gallery,
  remove;

  /// The capture source this choice maps to, or `null` for [remove] (which is
  /// not a capture at all).
  ImageSourceOption? get imageSource => switch (this) {
    PhotoSourceChoice.camera => ImageSourceOption.camera,
    PhotoSourceChoice.gallery => ImageSourceOption.gallery,
    PhotoSourceChoice.remove => null,
  };
}
