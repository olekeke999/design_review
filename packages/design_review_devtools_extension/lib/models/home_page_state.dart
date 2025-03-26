import 'dart:convert';
import 'dart:typed_data';

class HomePageState {
  final Uint8List? image;
  final double horizontalOffset;
  final double verticalOffset;
  final double opacity;
  final double scale;

  HomePageState({
    this.image,
    this.horizontalOffset = 0,
    this.verticalOffset = 0,
    this.opacity = 50,
    this.scale = 1,
  });

  bool get hasImage => image?.isNotEmpty ?? false;

  @override
  int get hashCode => Object.hash(
        image,
        horizontalOffset,
        verticalOffset,
        opacity,
        scale,
      );

  @override
  bool operator ==(Object other) {
    if (other is! HomePageState) return false;
    return image == other.image &&
        horizontalOffset == other.horizontalOffset &&
        verticalOffset == other.verticalOffset &&
        opacity == other.opacity &&
        scale == other.scale;
  }
}

extension HomePageStateJson on HomePageState {
  Map<String, dynamic> toJson() {
    return {
      'image': image != null ? base64.encode(image!) : '',
      'horizontal': horizontalOffset,
      'vertical': verticalOffset,
      'opacity': opacity,
      'scale': scale,
    };
  }
}
