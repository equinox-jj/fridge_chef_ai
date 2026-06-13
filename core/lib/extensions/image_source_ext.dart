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

  /// The runtime permission this source must hold before the picker opens, or
  /// `null` when none is needed.
  ///
  /// Only the camera needs an explicit grant. Gallery returns `null`: on both
  /// platforms `image_picker` opens a system picker (Android
  /// `ACTION_GET_CONTENT` / Photo Picker, iOS `PHPicker`) that hands back a
  /// single scoped item without a media/storage permission — across Android
  /// <13 and 13+ alike. Gating it on `Permission.photos` would needlessly
  /// prompt for whole-library access and, on iOS, block the picker if the user
  /// declines that prompt.
  Permission? get permission => switch (this) {
    ImageSourceOption.camera => Permission.camera,
    ImageSourceOption.gallery => null,
  };
}
