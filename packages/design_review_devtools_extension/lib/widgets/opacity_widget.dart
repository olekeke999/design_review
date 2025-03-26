import 'package:flutter/material.dart';

class OpacityWidget extends StatefulWidget {
  final double value;
  final Function(double) onChanged;

  const OpacityWidget(
    this.value, {
    super.key,
    required this.onChanged,
  });

  @override
  State<OpacityWidget> createState() => _OpacityWidgetState();
}

class _OpacityWidgetState extends State<OpacityWidget> {
  double localValue = 50;

  @override
  void initState() {
    localValue = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Row(
        spacing: 4,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Slider(
            onChangeEnd: (x) {
              widget.onChanged(x);
            },
            onChanged: (x) {
              setState(() {
                localValue = x;
              });
            },
            value: localValue,
            min: 1.0,
            max: 100.0,
          ),
          Text(localValue.toStringAsFixed(0)),
        ],
      ),
    );
  }
}
