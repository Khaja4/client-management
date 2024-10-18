import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:client_management/widgets/file_upload_widget.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_html/html.dart' as html;
import 'package:excel/excel.dart';

class MasterStoresStep extends StatelessWidget {
  final List<String> masterStores;
  final Function(List<String>) onMasterStoresChanged;

  Future<void> generateAndSaveExcel(BuildContext context) async {
    if (kIsWeb) {
      await _generateAndSaveExcelWeb();
    } else {
      await _generateAndSaveExcelMobile(context);
    }
  }

  Future<void> _generateAndSaveExcelMobile(BuildContext context) async {
    try {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        List<int> excelBytes = await _generateExcelBytes();

        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/master_stores.xlsx');
        await file.writeAsBytes(excelBytes);

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Excel file saved to ${file.path}')),
        );
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Storage permission denied')),
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving file: $e')),
      );
    }
  }

  Future<void> _generateAndSaveExcelWeb() async {
    List<int> excelBytes = await _generateExcelBytes();

    final blob = html.Blob([excelBytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.AnchorElement(href: url)
      ..setAttribute("download", "master_stores.xlsx")
      ..click();

    html.Url.revokeObjectUrl(url);
  }

  Future<List<int>> _generateExcelBytes() async {
    var excel = Excel.createExcel();

    // Add a sheet
    var sheet = excel['Sheet1'];

    // Add some data
    sheet.appendRow([
      TextCellValue("Outlet Code"),
      TextCellValue("Outlet Name"),
      TextCellValue('Channel'),
      TextCellValue('Country'),
      TextCellValue('Region'),
      TextCellValue('City'),
      TextCellValue('Account'),
    ]);
    // Convert to bytes
    return excel.encode()!;
  }

  const MasterStoresStep({
    super.key,
    required this.masterStores,
    required this.onMasterStoresChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
            Text(
              "Download Template",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    letterSpacing: 2,
                  ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 40,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await generateAndSaveExcel(context);
                },
                icon: const Icon(Icons.download),
                label: const Text('Download Template'),
              ),
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
                          masterStores
                              .where((file) => file != masterStores[index])
                              .toList(),
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
