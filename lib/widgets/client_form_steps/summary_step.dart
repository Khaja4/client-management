import 'package:flutter/material.dart';

class SummaryStep extends StatelessWidget {
  final String name;
  final String email;
  final String phoneNumber;
  final String agent;
  final String location;
  final String? requiredImage;
  final String? optionalImage;
  final List<String> projects;
  final List<String> masterStores;
  final List<String> skus;
  final Map<String, double> kpis;

  const SummaryStep({
    super.key,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.agent,
    required this.location,
    this.requiredImage,
    this.optionalImage,
    required this.projects,
    required this.masterStores,
    required this.skus,
    required this.kpis,
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
              'Summary',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            const SizedBox(height: 16),
            _buildSummaryItem('Name', name),
            _buildSummaryItem('Email', email),
            _buildSummaryItem('Phone', phoneNumber),
            _buildSummaryItem('Agent', agent),
            _buildSummaryItem('Location', location),
            _buildSummaryItem(
                'Required Image', requiredImage ?? 'Not provided'),
            _buildSummaryItem(
                'Optional Image', optionalImage ?? 'Not provided'),
            _buildSummaryList('Projects', projects),
            _buildSummaryList('Master Stores', masterStores),
            _buildSummaryList('SKUs', skus),
            _buildSummaryMap('KPIs', kpis),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildSummaryList(String label, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items.map((item) => Text('• $item')).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryMap(String label, Map<String, double> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items.entries
                .map((entry) => Text('• ${entry.key}: ${entry.value}'))
                .toList(),
          ),
        ],
      ),
    );
  }
}
