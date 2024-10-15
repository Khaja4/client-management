import 'package:flutter/material.dart';
import 'package:client_management/pages/new_client_page.dart';
import 'package:client_management/services/client_service.dart';
import 'package:client_management/models/client.dart';

import 'package:google_fonts/google_fonts.dart';

class ClientManagementPage extends StatefulWidget {
  const ClientManagementPage({super.key});

  @override
  ClientManagementPageState createState() => ClientManagementPageState();
}

class ClientManagementPageState extends State<ClientManagementPage> {
  final ClientService _clientService = ClientService();
  List<Client> _clients = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadClients();
  }

  void _loadClients() async {
    final clients = await _clientService.getClients();
    setState(() {
      _clients = clients;
    });
  }

  List<Client> get _filteredClients {
    return _clients
        .where((client) =>
        client.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white,

    textStyle: const TextStyle(fontWeight: FontWeight.bold),
    backgroundColor: const Color.fromRGBO(109, 39, 231, 1),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Search Client",
                      focusColor: const Color.fromRGBO(109, 39, 231, 1),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0)
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              SizedBox(
                height: 49,
                child: ElevatedButton(
                  style: raisedButtonStyle,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NewClientPage(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.add),
                      Text('New Client', style: GoogleFonts.poppins(
                        letterSpacing: 1
                      ),)
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredClients.length,
              itemBuilder: (context, index) {
                final client = _filteredClients[index];
                return Card(
                  child: ListTile(
                    title: Text(client.name),
                    subtitle: Text(client.email),
                    trailing: Text(client.phoneNumber),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
