import 'package:flutter/material.dart';

class ProjectsStep extends StatefulWidget {
  final List<String> projects;
  final Function(List<String>) onProjectsChanged;

  const ProjectsStep({
    super.key,
    required this.projects,
    required this.onProjectsChanged,
  });

  @override
  _ProjectsStepState createState() => _ProjectsStepState();
}

class _ProjectsStepState extends State<ProjectsStep> {
  final TextEditingController _projectController = TextEditingController();

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
              'Projects',
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
                    controller: _projectController,
                    decoration: const InputDecoration(
                      labelText: 'Add Project',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _addProject,
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.projects.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.projects[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _removeProject(index),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addProject() {
    if (_projectController.text.isNotEmpty) {
      setState(() {
        widget.projects.add(_projectController.text);
        widget.onProjectsChanged(widget.projects);
        _projectController.clear();
      });
    }
  }

  void _removeProject(int index) {
    setState(() {
      widget.projects.removeAt(index);
      widget.onProjectsChanged(widget.projects);
    });
  }
}