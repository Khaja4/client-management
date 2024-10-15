import 'package:flutter/material.dart';
import 'package:client_management/services/client_service.dart';
import 'package:client_management/models/client.dart';
import 'package:client_management/widgets/progress_bar.dart';
import 'package:client_management/widgets/client_form_steps/basic_info_step.dart';
import 'package:client_management/widgets/client_form_steps/projects_step.dart';
import 'package:client_management/widgets/client_form_steps/master_stores_step.dart';
import 'package:client_management/widgets/client_form_steps/skus_step.dart';
import 'package:client_management/widgets/client_form_steps/kpis_step.dart';
import 'package:client_management/widgets/client_form_steps/summary_step.dart';

class NewClientPage extends StatefulWidget {
  const NewClientPage({Key? key}) : super(key: key);

  @override
  NewClientPageState createState() => NewClientPageState();
}

class NewClientPageState extends State<NewClientPage> {
  int _currentStep = 0;
  final ClientService _clientService = ClientService();
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  String _phoneNumber = '';

  final List<String> _stepTitles = [
    'Basic Info',
    'Projects',
    'Master Stores',
    'SKUs',
    'KPIs',
    'Summary',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Client')),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            ProgressBar(
              steps: _stepTitles,
              currentStep: _currentStep,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildCurrentStep(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _handleNext,
        label: _currentStep == _stepTitles.length - 1
            ? const Text(
                'Done',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            : const Text('Next', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return BasicInfoStep(
          onNameChanged: (value) => _name = value,
          onEmailChanged: (value) => _email = value,
          onPhoneChanged: (value) => _phoneNumber = value,
        );
      case 1:
        return const ProjectsStep();
      case 2:
        return const MasterStoresStep();
      case 3:
        return const SKUsStep();
      case 4:
        return const KPIsStep();
      case 5:
        return const SummaryStep();
      default:
        return const SizedBox.shrink();
    }
  }

  void _handleNext() {
    if (_currentStep < _stepTitles.length - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      _submitForm();
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newClient = Client(
        id: DateTime.now().toString(),
        name: _name,
        email: _email,
        phoneNumber: _phoneNumber,
      );
      _clientService.addClient(newClient);
      Navigator.pop(context);
    }
  }
}
