import 'package:design_review/src/design_review_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:developer' as dev;

class DesignReviewWidget extends StatefulWidget {
  const DesignReviewWidget({
    super.key,
    required this.child,
    this.direction = TextDirection.ltr,
  });
  final Widget child;
  final TextDirection direction;

  @override
  State<DesignReviewWidget> createState() => _DesignReviewWidgetState();
}

class _DesignReviewWidgetState extends State<DesignReviewWidget> {
  var review = DesignReviewItem.empty();

  @override
  void initState() {
    super.initState();
    if (!kDebugMode) return;
    dev.registerExtension(
      'ext.design_review.comparescreen',
      (method, parameters) async {
        _onDesignReviewItemReceived(parameters);
        return dev.ServiceExtensionResponse.result('');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) return widget.child;
    final image = review.image;
    if (image == null || image.isEmpty) return widget.child;
    return Directionality(
        textDirection: widget.direction,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            widget.child,
            Positioned(
              left: review.horizontal,
              top: review.vertical,
              child: Opacity(
                opacity: review.opacity / 100,
                child: Image.memory(
                  scale: review.scale,
                  fit: BoxFit.none,
                  image,
                ),
              ),
            ),
          ],
        ));
  }

  Future<void> _onDesignReviewItemReceived(Map<String, String> data) async {
    final parsed = DesignReviewItem.fromJson(data);
    setState(() {
      review = parsed;
    });
  }
}
