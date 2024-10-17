import 'package:flutter/material.dart';
import 'package:client_management/models/client.dart';

class ClientListItem extends StatelessWidget {
  final Client client;
  final VoidCallback onTap;

  const ClientListItem({
    super.key,
    required this.client,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: Text(
            client.name[0].toUpperCase(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          client.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(client.email),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}