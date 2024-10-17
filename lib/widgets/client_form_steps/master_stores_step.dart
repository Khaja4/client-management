import 'package:flutter/material.dart';
import 'package:client_management/widgets/file_upload_widget.dart';

class MasterStoresStep extends StatelessWidget {
  final List<String> masterStores;
  final Function(List<String>) onMasterStoresChanged;

  const MasterStoresStep({
    super.key,
    required this.masterStores,
    required this.onMasterStoresChanged,
  });

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
              'Master Stores',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Implement template download
              },
              icon: const Icon(Icons.download),
              label: const Text('Download Template'),
            ),
            const SizedBox(height: 24),
            Text(
              'Project 1 - Purchase and sales_IN (India)',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            FileUploadWidget(
              onFileUploaded: (String filePath) {
                // TODO: Process the uploaded file and update masterStores
                onMasterStoresChanged([...masterStores, filePath]);
              },
            ),
            const SizedBox(height: 16),
            if (masterStores.isNotEmpty) ...[
              Text(
                'Uploaded Files:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                itemCount: masterStores.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.file_present),
                    title: Text(masterStores[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        onMasterStoresChanged(
                          masterStores.where((file) => file != masterStores[index]).toList(),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}