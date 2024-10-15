import 'package:flutter/material.dart';

class ProjectsStep extends StatelessWidget {
  const ProjectsStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Projects', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        // Add project-related fields here
        TextFormField(
          decoration: const InputDecoration(labelText: 'Project Name'),
        ),
        // Add more project-related fields as needed
      ],
    );
  }
}
