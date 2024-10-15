import 'package:flutter/material.dart';
import 'package:client_management/pages/home_page.dart';

void main() {
  runApp(const ClientManagement());
}

class ClientManagement extends StatelessWidget {
  const ClientManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Client Management",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}
