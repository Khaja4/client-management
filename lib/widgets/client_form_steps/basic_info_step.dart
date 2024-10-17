import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class BasicInfoStep extends StatefulWidget {
  final Function(String) onNameChanged;
  final Function(String) onEmailChanged;
  final Function(String) onPhoneChanged;
  final Function(String) onLocationChanged;
  final Function(String) onAgentChanged;
  final Function(String?) onRequiredImageChanged;
  final Function(String?) onOptionalImageChanged;

  const BasicInfoStep({
    super.key,
    required this.onNameChanged,
    required this.onEmailChanged,
    required this.onPhoneChanged,
    required this.onLocationChanged,
    required this.onAgentChanged,
    required this.onRequiredImageChanged,
    required this.onOptionalImageChanged,
  });

  @override
  _BasicInfoStepState createState() => _BasicInfoStepState();
}

class _BasicInfoStepState extends State<BasicInfoStep> {
  String? _clientAgent;
  String? _requiredImageName;
  String? _optionalImageName;

  final List<String> _clientAgents = ['Agent 1', 'Agent 2', 'Agent 3'];

  Future<void> _pickImage(bool isRequired) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        if (isRequired) {
          _requiredImageName = result.files.single.name;
          widget.onRequiredImageChanged(_requiredImageName);
        } else {
          _optionalImageName = result.files.single.name;
          widget.onOptionalImageChanged(_optionalImageName);

        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Information',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildTextField(
              label: 'Client Name',
              icon: Icons.person,
              onChanged: widget.onNameChanged,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Email',
              icon: Icons.email,
              onChanged: widget.onEmailChanged,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Phone',
              icon: Icons.phone,
              onChanged: widget.onPhoneChanged,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a phone number';
                }
                if (!RegExp(r'^\+?[0-9]{10,14}$').hasMatch(value)) {
                  return 'Please enter a valid phone number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildDropdownField(
              label: 'Client Agent',
              icon: Icons.person_outline,
              value: _clientAgent,
              items: _clientAgents,
              onChanged: (String? newValue) {
                setState(() {
                  _clientAgent = newValue;
                  widget.onAgentChanged(newValue ?? '');
                });
              },
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Geographical Location for Auditor',
              icon: Icons.location_on,
              onChanged: widget.onLocationChanged,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a location';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            _buildImageUploadButton(
              label: 'Upload Required Image',
              icon: Icons.cloud_upload,
              isRequired: true,
              imageName: _requiredImageName,
            ),
            const SizedBox(height: 16),
            _buildImageUploadButton(
              label: 'Upload Optional Image',
              icon: Icons.add_photo_alternate,
              isRequired: false,
              imageName: _optionalImageName,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required Function(String) onChanged,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }

  Widget _buildDropdownField({
    required String label,
    required IconData icon,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      value: value,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildImageUploadButton({
    required String label,
    required IconData icon,
    required bool isRequired,
    required String? imageName,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          onPressed: () => _pickImage(isRequired),
          icon: Icon(icon),
          label: Text(label),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        if (imageName != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Selected: $imageName',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}