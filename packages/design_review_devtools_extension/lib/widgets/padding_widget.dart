import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaddingWidget extends StatelessWidget {
  const PaddingWidget(
      {super.key, required this.onChanged, required this.horizonal, required this.vertical,});
  final double horizonal;
  final double vertical;
  final Function(double, double) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _PaddingWidgetItem(
            'horizontal',
            value: horizonal.toInt(),
            onChanged: (p0) {
              onChanged(p0.toDouble(), vertical);
            },
          ),
          _PaddingWidgetItem(
            'vertical',
            value: vertical.toInt(),
            onChanged: (p0) {
              onChanged(horizonal, p0.toDouble());
            },
          ),
         
          
        ],
      ),
    );
  }
}

class _PaddingWidgetItem extends StatelessWidget {
  final String label;
  final Function(int) onChanged;
  final int value;

  const _PaddingWidgetItem(
    this.label, {
    required this.onChanged,
    required this.value,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        Text(label),
        SizedBox(
            width: 50,
            child: TextFormField(
              initialValue: value.toString(),
              onChanged: (value) {
                var formatted = value;
                if (value.length == 1 && value == '-') {
                  formatted = '0';
                }

                final parsed = int.tryParse(formatted) ?? 0;
                onChanged(parsed);
              },
              maxLength: 4,
              inputFormatters: [
                TextInputFormatter.withFunction(
                  (oldValue, newValue) {
                    final value = newValue.text;
                    if (value.length == 1 && value == '-') return newValue;
                    if (value.isEmpty) return TextEditingValue(text: '0');
                    final number = int.tryParse(newValue.text);
                    if (number == null) return oldValue;
                    return newValue;
                  },
                )
              ],
            )),
      ],
    );
  }
}
