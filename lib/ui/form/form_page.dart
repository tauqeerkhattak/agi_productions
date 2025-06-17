import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/ui/labeled_date_range.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  int _currentStep = 0;

  final _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  final _lineNumberController = TextEditingController();
  final _nameController = TextEditingController();
  final _styleController = TextEditingController();
  DateTime? _selectedDate;
  LabeledDateRange? _selectedTimeSlot;
  final List<LabeledDateRange> timeSlots = [
    LabeledDateRange(
      start: DateTime(0, 1, 1, 8, 30),
      end: DateTime(0, 1, 1, 9, 30),
      label: "1st Hour",
    ),
    LabeledDateRange(
      start: DateTime(0, 1, 1, 9, 30),
      end: DateTime(0, 1, 1, 10, 30),
      label: "2nd Hour",
    ),
    LabeledDateRange(
      start: DateTime(0, 1, 1, 10, 30),
      end: DateTime(0, 1, 1, 11, 30),
      label: "3rd Hour",
    ),
    LabeledDateRange(
      start: DateTime(0, 1, 1, 11, 30),
      end: DateTime(0, 1, 1, 12, 30),
      label: "4th Hour",
    ),
    LabeledDateRange(
      start: DateTime(0, 1, 1, 12, 30),
      end: DateTime(0, 1, 1, 13, 30),
      label: "5th Hour",
    ),
    LabeledDateRange(
      start: DateTime(0, 1, 1, 13, 30),
      end: DateTime(0, 1, 1, 14, 30),
      label: "6th Hour",
    ),
    LabeledDateRange(
      start: DateTime(0, 1, 1, 14, 30),
      end: DateTime(0, 1, 1, 15, 30),
      label: "7th Hour",
    ),
    LabeledDateRange(
      start: DateTime(0, 1, 1, 15, 30),
      end: DateTime(0, 1, 1, 16, 30),
      label: "8th Hour",
    ),
    LabeledDateRange(
      start: DateTime(0, 1, 1, 16, 30),
      end: DateTime(0, 1, 1, 17, 30),
      label: "9th Hour",
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final DateTime now = DateTime.now().copyWith(year: 0, month: 1, day: 1);
      for (final timeslot in timeSlots) {
        if (timeslot.isDateInRange(now)) {
          _selectedTimeSlot = timeslot;
          setState(() {});
          break;
        }
      }
    });
  }

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _continue() {
    if (_formKeys[_currentStep].currentState!.validate()) {
      if (_currentStep < 2) {
        setState(() => _currentStep += 1);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Form Submitted!')));
      }
    }
  }

  void _cancel() {
    if (_currentStep > 0) {
      setState(() => _currentStep -= 1);
    }
  }

  @override
  void dispose() {
    _lineNumberController.dispose();
    _nameController.dispose();
    _styleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Stepper')),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepContinue: _continue,
        onStepCancel: _cancel,
        steps: [
          _buildStep1(),
          Step(
            title: const Text('Step 2'),
            content: Form(
              key: _formKeys[1],
              child: const Text("Step 2 Content Placeholder"),
            ),
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('Step 3'),
            content: Form(
              key: _formKeys[2],
              child: const Text("Step 3 Content Placeholder"),
            ),
            isActive: _currentStep >= 2,
            state: _currentStep == 2 ? StepState.editing : StepState.indexed,
          ),
        ],
      ),
    );
  }

  Step _buildStep1() {
    return Step(
      title: const Text('Step 1'),
      isActive: _currentStep >= 0,
      state: _currentStep > 0 ? StepState.complete : StepState.indexed,
      content: Form(
        key: _formKeys[0],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _lineNumberController,
              decoration: const InputDecoration(labelText: 'Line Number'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Required' : null,
            ),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Required' : null,
            ),
            TextFormField(
              controller: _styleController,
              decoration: const InputDecoration(
                labelText: 'Style (P.O. Number)',
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            Text('Date', style: Theme.of(context).textTheme.titleMedium),
            TextButton(
              onPressed: _pickDate,
              child: Text(
                _selectedDate != null
                    ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                    : 'Select Date',
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Time (Preferred Automatic)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Column(
              children: List.generate(timeSlots.length, (index) {
                final label = timeSlots[index].toString();
                return RadioListTile<LabeledDateRange>(
                  title: Text(label),
                  value: timeSlots[index],
                  groupValue: _selectedTimeSlot,
                  onChanged: (val) {
                    setState(() {
                      _selectedTimeSlot = val;
                    });
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
