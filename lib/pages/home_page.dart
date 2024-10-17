import 'package:flutter/material.dart';
import 'package:client_management/widgets/app_bar_widget.dart';
import 'package:client_management/widgets/drawer_widget.dart';
import 'package:client_management/pages/client_management_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(title: 'Client Management'),
      drawer: DrawerWidget(),
      body: ClientManagementPage(),
    );
  }
}