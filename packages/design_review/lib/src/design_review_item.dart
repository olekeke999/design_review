import 'dart:convert';

import 'package:flutter/foundation.dart';

class DesignReviewItem {
  final Uint8List? image;
  final double horizontal;
  final double vertical;
  final double opacity;
  final double scale;

  DesignReviewItem({
    required this.image,
    required this.horizontal,
    required this.vertical,
    required this.opacity,
    required this.scale,
  });

  factory DesignReviewItem.empty() => DesignReviewItem(
        image: null,
        opacity: 100,
        horizontal: 0,
        vertical: 0,
        scale: 1,
      );

  factory DesignReviewItem.fromJson(Map<String, String> json) {
    final imageBase64 = json['image'];
    final image = imageBase64 != null ? base64.decode(imageBase64) : null;

    final horizontal = double.tryParse(json['horizontal'] ?? '') ?? 0;
    final vertical = double.tryParse(json['vertical'] ?? '') ?? 0;
    final opacity = double.tryParse(json['opacity'] ?? '') ?? 100;
    var scale = (double.tryParse(json['scale'] ?? '') ?? 1).abs();
    double epsilon = 1e-9;
    if (scale < epsilon) {
      scale = 1.0;
    }
    return DesignReviewItem(
        image: image,
        horizontal: horizontal,
        vertical: vertical,
        opacity: opacity,
        scale: scale);
  }
}
