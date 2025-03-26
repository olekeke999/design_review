import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DoubleValueWidget extends StatelessWidget {
  final String title;
  final Function(double) onChanged;
  final double value;
  final bool isSigned;
  final double fallbackValue;
  final String? label;

  const DoubleValueWidget(
    this.title, {
    super.key,
    required this.onChanged,
    required this.value,
    required this.fallbackValue,
    this.isSigned = true,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 12,
          children: [
            Text(title),
            SizedBox(
              width: 50,
              child: TextFormField(
                initialValue: value.toString(),
                onChanged: (value) {
                  var formatted = value;
                  if (value.length == 1 && value == '-') {
                    formatted = '0';
                  }

                  var parsed = double.tryParse(formatted) ?? 0;

                  onChanged(isSigned ? parsed.abs() : parsed);
                },
                maxLength: 4,
                inputFormatters: [
                  TextInputFormatter.withFunction(
                    (oldValue, newValue) {
                      final value = newValue.text;
                      if (value.length == 1 && value == '-') return newValue;
                      if (value.isEmpty) return TextEditingValue(text: '0');
                      final number = double.tryParse(newValue.text);
                      if (number == null) return oldValue;
                      return newValue;
                    },
                  )
                ],
              ),
            ),
          ],
        ),
        if (label != null)
          Text(
            label!,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: Colors.orange),
          ),
      ],
    );
  }
}
