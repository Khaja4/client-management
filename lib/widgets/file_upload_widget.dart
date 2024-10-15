import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FileUploadWidget extends StatefulWidget {
  const FileUploadWidget({super.key});

  @override
  _FileUploadWidgetState createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  String? _fileName;
  String? _filePath;

  Future<void> _chooseFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _filePath = result.files.single.path;
        _fileName = result.files.single.name;
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Master Store List',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton.icon(
            onPressed: _chooseFile,
            icon: const Icon(Icons.upload_file),
            label: const Text('Choose File'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(109, 39, 231, 1),
              foregroundColor: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              textStyle: const TextStyle(fontSize: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          _fileName != null
              ? Text('Selected file: $_fileName',
                  style: const TextStyle(fontSize: 16))
              : const Text('No file selected', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 16.0),
          _filePath != null
              ? Text('File path: $_filePath',
                  style: const TextStyle(fontSize: 14, color: Colors.grey))
              : const SizedBox(),
        ],
      ),
    );
  }
}
