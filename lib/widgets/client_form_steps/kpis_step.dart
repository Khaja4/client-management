import 'package:flutter/material.dart';

class KPIsStep extends StatefulWidget {
  final Map<String, double> kpis;
  final Function(Map<String, double>) onKPIsChanged;

  const KPIsStep({
    super.key,
    required this.kpis,
    required this.onKPIsChanged,
  });

  @override
  _KPIsStepState createState() => _KPIsStepState();
}

class _KPIsStepState extends State<KPIsStep> {
  final TextEditingController _kpiNameController = TextEditingController();
  final TextEditingController _kpiValueController = TextEditingController();

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
              'KPIs',
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
                    controller: _kpiNameController,
                    decoration: const InputDecoration(
                      labelText: 'KPI Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _kpiValueController,
                    decoration: const InputDecoration(
                      labelText: 'KPI Value',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _addKPI,
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.kpis.length,
              itemBuilder: (context, index) {
                String key = widget.kpis.keys.elementAt(index);
                return ListTile(
                  title: Text(key),
                  subtitle: Text(widget.kpis[key]!.toString()),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _removeKPI(key),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addKPI() {
    if (_kpiNameController.text.isNotEmpty &&
        _kpiValueController.text.isNotEmpty) {
      setState(() {
        widget.kpis[_kpiNameController.text] =
            double.parse(_kpiValueController.text);
        widget.onKPIsChanged(widget.kpis);
        _kpiNameController.clear();
        _kpiValueController.clear();
      });
    }
  }

  void _removeKPI(String key) {
    setState(() {
      widget.kpis.remove(key);
      widget.onKPIsChanged(widget.kpis);
    });
  }
}
