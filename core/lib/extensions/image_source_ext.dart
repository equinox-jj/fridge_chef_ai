import 'package:dependencies/image_picker/image_picker.dart';
import 'package:dependencies/permission_handler/permission_handler.dart';

import '../constants/image_source_option/image_source_option.dart';

/// Maps a user-facing [ImageSourceOption] onto the plugin source and the OS
/// permission that source requires.
extension ImageSourceExt on ImageSourceOption {
  ImageSource get imageSource => switch (this) {
    ImageSourceOption.camera => ImageSource.camera,
    ImageSourceOption.gallery => ImageSource.gallery,
  };

  Permission get permission => switch (this) {
    ImageSourceOption.camera => Permission.camera,
    ImageSourceOption.gallery => Permission.photos,
  };
}
