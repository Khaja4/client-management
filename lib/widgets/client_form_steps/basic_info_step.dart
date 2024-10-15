import 'package:flutter/material.dart';

class BasicInfoStep extends StatelessWidget {
  final Function(String) onNameChanged;
  final Function(String) onEmailChanged;
  final Function(String) onPhoneChanged;

  const BasicInfoStep({
    super.key,
    required this.onNameChanged,
    required this.onEmailChanged,
    required this.onPhoneChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: const InputDecoration(labelText: 'Client Name'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a name';
            }
            return null;
          },
          onChanged: onNameChanged,
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Email'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter an email';
            }
            return null;
          },
          onChanged: onEmailChanged,
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Phone Number'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a phone number';
            }
            return null;
          },
          onChanged: onPhoneChanged,
        ),
      ],
    );
  }
}
