import 'package:flutter/material.dart';
import 'package:client_management/models/client.dart';
import 'package:client_management/services/client_service.dart';
import 'package:client_management/pages/new_client_page.dart';

import '../widgets/client_list_items.dart';

class ClientManagementPage extends StatefulWidget {
  const ClientManagementPage({super.key});

  @override
  _ClientManagementPageState createState() => _ClientManagementPageState();
}

class _ClientManagementPageState extends State<ClientManagementPage> {
  final ClientService _clientService = ClientService();
  List<Client> _clients = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadClients();
  }

  Future<void> _loadClients() async {
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Back!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
          ),
          const SizedBox(height: 16),
          _buildSearchAndAddSection(),
          const SizedBox(height: 24),
          Expanded(
            child: _filteredClients.isEmpty
                ? _buildEmptyState()
                : _buildClientList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndAddSection() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search clients',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          height: 50,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewClientPage()),
              ).then((_) => _loadClients());
            },
            icon: const Icon(Icons.add),
            label: const Text('New Client'),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 64,
            color: Theme.of(context).primaryColor.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No clients found',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add a new client to get started',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildClientList() {
    return ListView.separated(
      itemCount: _filteredClients.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final client = _filteredClients[index];
        return ClientListItem(
          client: client,
          onTap: () {
            // TODO: Implement client details page navigation
          },
        );
      },
    );
  }
}
