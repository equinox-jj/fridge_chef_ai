import 'dart:typed_data';

import 'package:dependencies/flutter_image_compress/flutter_image_compress.dart';

abstract class ImageCompressionService {
  Future<Uint8List> compress(Uint8List bytes);
}

class ImageCompressionServiceImpl implements ImageCompressionService {
  const ImageCompressionServiceImpl({
    this.minWidth = 1024,
    this.minHeight = 1024,
    this.quality = 80,
  });

  final int minWidth;
  final int minHeight;
  final int quality;

  @override
  Future<Uint8List> compress(Uint8List bytes) {
    return FlutterImageCompress.compressWithList(
      bytes,
      minWidth: minWidth,
      minHeight: minHeight,
      quality: quality,
      format: CompressFormat.jpeg,
    );
  }
}
