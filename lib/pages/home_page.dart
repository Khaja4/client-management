import 'package:flutter/material.dart';
import 'package:client_management/pages/client_management_page.dart';
import 'package:client_management/widgets/app_bar_widget.dart';
import 'package:client_management/widgets/drawer_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: const AppBarWidget(),
      backgroundColor: Colors.grey[200],
      body: const ClientManagementPage(),
    );
  }
}
