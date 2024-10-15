import 'package:flutter/material.dart';

class KPIsStep extends StatelessWidget {
  const KPIsStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('KPIs', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        // Add KPI-related fields here
        TextFormField(
          decoration: const InputDecoration(labelText: 'KPI Name'),
        ),
        // Add more KPI-related fields as needed
      ],
    );
  }
}
