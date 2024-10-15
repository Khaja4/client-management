import 'package:flutter/material.dart';

class SummaryStep extends StatelessWidget {
  const SummaryStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Summary', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        // Add summary-related fields here
        TextFormField(
          decoration: const InputDecoration(labelText: 'Additional Notes'),
          maxLines: 3,
        ),
        // Add more summary-related fields as needed
      ],
    );
  }
}
