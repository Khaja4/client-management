import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FileUploadWidget extends StatefulWidget {
  final Function(String) onFileUploaded;

  const FileUploadWidget({super.key, required this.onFileUploaded});

  @override
  _FileUploadWidgetState createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  String? _fileName;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls', 'csv'],
    );

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
      });
      widget.onFileUploaded(result.files.single.path!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          onPressed: _pickFile,
          icon: const Icon(Icons.upload_file),
          label: const Text('Upload File'),
        ),
        if (_fileName != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text('Selected file: $_fileName'),
          ),
      ],
    );
  }
}
