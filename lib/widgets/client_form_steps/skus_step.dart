import 'package:flutter/material.dart';

class SKUsStep extends StatefulWidget {
  final List<String> skus;
  final Function(List<String>) onSKUsChanged;

  const SKUsStep({
    super.key,
    required this.skus,
    required this.onSKUsChanged,
  });

  @override
  _SKUsStepState createState() => _SKUsStepState();
}

class _SKUsStepState extends State<SKUsStep> {
  final TextEditingController _skuController = TextEditingController();

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
              'SKUs',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _skuController,
                    decoration: const InputDecoration(
                      labelText: 'Add SKU',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _addSKU,
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.skus.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.skus[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _removeSKU(index),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addSKU() {
    if (_skuController.text.isNotEmpty) {
      setState(() {
        widget.skus.add(_skuController.text);
        widget.onSKUsChanged(widget.skus);
        _skuController.clear();
      });
    }
  }

  void _removeSKU(int index) {
    setState(() {
      widget.skus.removeAt(index);
      widget.onSKUsChanged(widget.skus);
    });
  }
}