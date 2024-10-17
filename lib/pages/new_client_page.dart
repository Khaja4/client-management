import 'package:flutter/material.dart';
import 'package:client_management/widgets/app_bar_widget.dart';
import 'package:client_management/services/client_service.dart';
import 'package:client_management/models/client.dart';
import 'package:client_management/widgets/client_form_steps/basic_info_step.dart';
import 'package:client_management/widgets/client_form_steps/projects_step.dart';
import 'package:client_management/widgets/client_form_steps/master_stores_step.dart';
import 'package:client_management/widgets/client_form_steps/skus_step.dart';
import 'package:client_management/widgets/client_form_steps/kpis_step.dart';
import 'package:client_management/widgets/client_form_steps/summary_step.dart';
import 'package:client_management/widgets/progress_bar.dart';

class NewClientPage extends StatefulWidget {
  const NewClientPage({super.key});

  @override
  _NewClientPageState createState() => _NewClientPageState();
}

class _NewClientPageState extends State<NewClientPage> {
  int _currentStep = 0;
  final ClientService _clientService = ClientService();
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  String _phoneNumber = '';
  String _agent = '';
  String _location = '';
  String? _requiredImage;
  String? _optionalImage;
  List<String> _projects = [];
  List<String> _masterStores = [];
  List<String> _skus = [];
  Map<String, double> _kpis = {};

  final List<String> _stepTitles = [
    'Basic Information',
    'Projects',
    'Master Stores',
    'SKUs',
    'KPIs',
    'Summary',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'New Client'),
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
            _buildNavigationButtons(),
          ],
        ),
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
          onAgentChanged: (value) => _agent = value,
          onLocationChanged: (value) => _location = value,
          onRequiredImageChanged: (value) => _requiredImage = value,
          onOptionalImageChanged: (value) => _optionalImage = value,
        );
      case 1:
        return ProjectsStep(
          projects: _projects,
          onProjectsChanged: (value) => _projects = value,
        );
      case 2:
        return MasterStoresStep(
          masterStores: _masterStores,
          onMasterStoresChanged: (value) => _masterStores = value,
        );
      case 3:
        return SKUsStep(
          skus: _skus,
          onSKUsChanged: (value) => _skus = value,
        );
      case 4:
        return KPIsStep(
          kpis: _kpis,
          onKPIsChanged: (value) => _kpis = value,
        );
      case 5:
        return SummaryStep(
          name: _name,
          email: _email,
          phoneNumber: _phoneNumber,
          agent: _agent,
          location: _location,
          requiredImage: _requiredImage,
          optionalImage: _optionalImage,
          projects: _projects,
          masterStores: _masterStores,
          skus: _skus,
          kpis: _kpis,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentStep > 0)
            SizedBox(
              width: 100,
              height: 50,
              child: ElevatedButton(
                onPressed: _handlePrevious,
                child: const Text('Previous'),
              ),
            )
          else
            const SizedBox.shrink(),
          SizedBox(
            width: 80,
            height: 50,
            child: ElevatedButton(
              onPressed: _handleNext,
              child: Text(
                  _currentStep == _stepTitles.length - 1 ? 'Submit' : 'Next'),
            ),
          ),
        ],
      ),
    );
  }

  void _handlePrevious() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _handleNext() {
    if (_currentStep < _stepTitles.length - 1) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        setState(() {
          _currentStep++;
        });
      }
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
        agent: _agent,
        location: _location,
        requiredImage: _requiredImage,
        optionalImage: _optionalImage,
        projects: _projects,
        masterStores: _masterStores,
        skus: _skus,
        kpis: _kpis,
      );
      _clientService.addClient(newClient);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Client added successfully')),
      );
      Navigator.pop(context);
    }
  }
}
