import 'package:flutter/material.dart';

class MasterStoresStep extends StatelessWidget {
  const MasterStoresStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Master Stores', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        // Add master stores-related fields here
        TextFormField(
          decoration: const InputDecoration(labelText: 'Store Name'),
        ),
        // Add more master stores-related fields as needed
      ],
    );
  }
}
