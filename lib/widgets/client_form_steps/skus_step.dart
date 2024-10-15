import 'package:flutter/material.dart';

class SKUsStep extends StatelessWidget {
  const SKUsStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('SKUs', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        // Add SKU-related fields here
        TextFormField(
          decoration: const InputDecoration(labelText: 'SKU Name'),
        ),
        // Add more SKU-related fields as needed
      ],
    );
  }
}
