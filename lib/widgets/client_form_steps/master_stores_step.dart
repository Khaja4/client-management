import 'package:client_management/widgets/file_upload_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MasterStoresStep extends StatelessWidget {
  const MasterStoresStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Left-align items
          children: [
            Text(
              'Master Stores',
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                  letterSpacing: 1),
            ),
            const SizedBox(height: 16),
            Text(
              'Download Template',
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(fontWeight: FontWeight.w500),
                  letterSpacing: 2),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft, // Align button to the left
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold, letterSpacing: 1),
                      backgroundColor: const Color.fromRGBO(109, 39, 231, 1),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                    child: const Row(
                        mainAxisSize: MainAxisSize
                            .min, // Ensure the button is not stretched
                        children: [
                          Icon(Icons.download),
                          Text('Download Template')
                        ])),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Project 1 - Purchase and sales_IN (India)',
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                  letterSpacing: 1),
            ),
            const SizedBox(height: 10),
            const FileUploadWidget(),
          ],
        ),
      ),
    );
  }
}
