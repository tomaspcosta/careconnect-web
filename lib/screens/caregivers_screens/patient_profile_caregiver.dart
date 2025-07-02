import 'package:flutter/material.dart';

class PatientProfileCaregiver extends StatelessWidget {
  const PatientProfileCaregiver({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? patient =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (patient == null) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFFD9D9D9),
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text(
            'No patient data provided.',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFD9D9D9),
        title: Row(
          children: [
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'Care',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  TextSpan(
                    text: 'Connect',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/caregiver_dashboard');
                  },
                  child: const Text(
                    'Dashboard',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/patients');
                  },
                  child: const Text(
                    'Patients',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, '/home_screen');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'View Patient',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              patient['image'],
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '${patient['name']}, ${patient['age']}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'manuelmatos@example.com',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  DateTime? startDate;
                                  DateTime? endDate;
                                  final TextEditingController startDateController =
                                      TextEditingController();
                                  final TextEditingController endDateController =
                                      TextEditingController();
                                  final TextEditingController descriptionController =
                                      TextEditingController();
                                  bool morningSelected = false;
                                  bool afternoonSelected = false;
                                  bool eveningSelected = false;
                                  bool isValid = true;

                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      void validateAndSubmit() {
                                        isValid = true;

                                        if (descriptionController.text.isEmpty) {
                                          isValid = false;
                                        }
                                        if (!morningSelected && !afternoonSelected && !eveningSelected) {
                                          isValid = false;
                                        }
                                        if (startDate == null || endDate == null) {
                                          isValid = false;
                                        }

                                        if (isValid) {
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Medication added!'),
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                        } else {
                                          setState(() {}); // Trigger UI update to show validation errors
                                        }
                                      }

                                      return AlertDialog(
                                        title: const Text('Add Medication', style: TextStyle(fontWeight: FontWeight.bold)),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Text('Description', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                              const SizedBox(height: 8),
                                              TextField(
                                                controller: descriptionController,
                                                decoration: InputDecoration(
                                                  hintText: 'Enter Description',
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(color: isValid && descriptionController.text.isNotEmpty ? Colors.grey : Colors.red),
                                                  ),
                                                ),
                                                maxLines: 2,
                                              ),
                                              const SizedBox(height: 16),
                                              const Text('Times of Day', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                              const SizedBox(height: 8),
                                              Column(
                                                children: [
                                                  CheckboxListTile(
                                                    value: morningSelected,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        morningSelected = value ?? false;
                                                      });
                                                    },
                                                    title: const Text('Morning (08:00)'),
                                                    controlAffinity: ListTileControlAffinity.leading,
                                                  ),
                                                  CheckboxListTile(
                                                    value: afternoonSelected,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        afternoonSelected = value ?? false;
                                                      });
                                                    },
                                                    title: const Text('Afternoon (14:00)'),
                                                    controlAffinity: ListTileControlAffinity.leading,
                                                  ),
                                                  CheckboxListTile(
                                                    value: eveningSelected,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        eveningSelected = value ?? false;
                                                      });
                                                    },
                                                    title: const Text('Evening (20:00)'),
                                                    controlAffinity: ListTileControlAffinity.leading,
                                                  ),
                                                  if (!isValid && !morningSelected && !afternoonSelected && !eveningSelected)
                                                    const Text(
                                                      'Please select at least one time of day.',
                                                      style: TextStyle(color: Colors.red, fontSize: 12),
                                                    ),
                                                ],
                                              ),
                                              const SizedBox(height: 16),
                                              const Text('Start Date', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                              const SizedBox(height: 8),
                                              TextField(
                                                controller: startDateController,
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  hintText: 'Select Start Date',
                                                  suffixIcon: const Icon(Icons.calendar_today),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(color: isValid && startDate != null ? Colors.grey : Colors.red),
                                                  ),
                                                ),
                                                onTap: () async {
                                                  final DateTime? pickedDate = await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2100),
                                                  );
                                                  if (pickedDate != null) {
                                                    setState(() {
                                                      startDate = pickedDate;
                                                      startDateController.text =
                                                          '${startDate?.year}-${startDate?.month.toString().padLeft(2, '0')}-${startDate?.day.toString().padLeft(2, '0')}';
                                                    });
                                                  }
                                                },
                                              ),
                                              const SizedBox(height: 16),
                                              const Text('End Date', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                              const SizedBox(height: 8),
                                              TextField(
                                                controller: endDateController,
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  hintText: 'Select End Date',
                                                  suffixIcon: const Icon(Icons.calendar_today),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(color: isValid && endDate != null ? Colors.grey : Colors.red),
                                                  ),
                                                ),
                                                onTap: () async {
                                                  final DateTime? pickedDate = await showDatePicker(
                                                    context: context,
                                                    initialDate: startDate ?? DateTime.now(),
                                                    firstDate: startDate ?? DateTime(2000),
                                                    lastDate: DateTime(2100),
                                                  );
                                                  if (pickedDate != null) {
                                                    setState(() {
                                                      endDate = pickedDate;
                                                      endDateController.text =
                                                          '${endDate?.year}-${endDate?.month.toString().padLeft(2, '0')}-${endDate?.day.toString().padLeft(2, '0')}';
                                                    });
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            style: TextButton.styleFrom(
                                              backgroundColor: Colors.grey[300],
                                            ),
                                            child: const Text('Cancel', style: TextStyle(color: Colors.black)),
                                          ),
                                          ElevatedButton(
                                            onPressed: validateAndSubmit,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white, // Changed to white
                                            ),
                                            child: const Text(
                                              'Add Medication',
                                              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)), // Black text for contrast
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.add, color: Colors.white),
                            label: const Text(
                              'Add Medication',
                              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)), // Changed text color to black
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              minimumSize: const Size(double.infinity, 40),
                            ),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  DateTime? selectedDate;
                                  TimeOfDay? selectedTime;
                                  final TextEditingController dateController = TextEditingController();
                                  final TextEditingController timeController = TextEditingController();

                                  return AlertDialog(
                                    title: const Text('Add Task'),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            'Task Name*',
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 8),
                                          const TextField(
                                            decoration: InputDecoration(
                                              hintText: 'Enter Task Name',
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          const Text(
                                            'Description (optional)',
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 8),
                                          const TextField(
                                            decoration: InputDecoration(
                                              hintText: 'Enter Description',
                                              border: OutlineInputBorder(),
                                            ),
                                            maxLines: 3,
                                          ),
                                          const SizedBox(height: 16),
                                          const Text(
                                            'Date*',
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 8),
                                          TextField(
                                            controller: dateController,
                                            readOnly: true,
                                            decoration: const InputDecoration(
                                              hintText: 'Select Date',
                                              suffixIcon: Icon(Icons.calendar_today),
                                              border: OutlineInputBorder(),
                                            ),
                                            onTap: () async {
                                              final DateTime? pickedDate = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime(2100),
                                              );
                                              if (pickedDate != null) {
                                                selectedDate = pickedDate;
                                                dateController.text =
                                                    '${selectedDate?.year}-${selectedDate?.month.toString().padLeft(2, '0')}-${selectedDate?.day.toString().padLeft(2, '0')}';
                                              }
                                            },
                                          ),
                                          const SizedBox(height: 16),
                                          const Text(
                                            'Time*',
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 8),
                                          TextField(
                                            controller: timeController,
                                            readOnly: true,
                                            decoration: const InputDecoration(
                                              hintText: 'Select Time',
                                              suffixIcon: Icon(Icons.access_time),
                                              border: OutlineInputBorder(),
                                            ),
                                            onTap: () async {
                                              final TimeOfDay? pickedTime = await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                              );
                                              if (pickedTime != null) {
                                                selectedTime = pickedTime;
                                                timeController.text =
                                                    '${selectedTime?.hour.toString().padLeft(2, '0')}:${selectedTime?.minute.toString().padLeft(2, '0')}';
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(); // Close the dialog
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.grey[300],
                                        ),
                                        child: const Text('Cancel', style: TextStyle(color: Colors.black)),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(); // Close the dialog
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Task added!'),
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                        child: const Text('Add Task', style: TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.add, color: Colors.white),
                            label: const Text(
                              'Add Task',
                              style: TextStyle(color: Colors.white), // White text
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              minimumSize: const Size(double.infinity, 40),
                            ),
                          ),
                          const SizedBox(height: 8),
                          OutlinedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Remove Patient'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.warning, color: Colors.orange, size: 48),
                                        const SizedBox(height: 16),
                                        const Text(
                                          'Are you sure you want to remove this patient from your care list?',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'You will no longer have access to this patient’s information.',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 14, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(); // Close the dialog
                                        },
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.black,
                                          backgroundColor: Colors.grey[300],
                                        ),
                                        child: const Text('Cancel'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Handle patient removal logic here
                                          Navigator.of(context).pop(); // Close the dialog
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Patient removed!'),
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        child: const Text(
                                          'Remove',
                                          style: TextStyle(color: Colors.white), // Ensure white text
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: const BorderSide(color: Colors.red),
                              minimumSize: const Size(double.infinity, 40),
                            ),
                            child: const Text('Remove Patient'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Health Status',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text('Last Check-In: Today 09:00 AM'),
                              const Text('Medication: Morning Dose Taken'),
                              const Text('Last Alert: 2 days ago'),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Downloading report...'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  // Add logic to download the report here
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  minimumSize: const Size(double.infinity, 40),
                                ),
                                child: const Text(
                                  'Download Report', // Renamed from "View Full Report"
                                  style: TextStyle(color: Colors.white), // White text
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Assigned Tasks',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(2),
                                  1: FlexColumnWidth(1),
                                },
                                children: const [
                                  TableRow(
                                    children: [
                                      Text('Task', style: TextStyle(fontWeight: FontWeight.bold)),
                                      Text('Scheduled Time', style: TextStyle(fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Text('Check-in'),
                                      Text('09:00 AM'),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Text('Medication'),
                                      Text('09:55 AM'),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Text('Medication'),
                                      Text('11:55 AM'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Alert History',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(1),
                      },
                      children: const [
                        TableRow(
                          children: [
                            Text('Alert', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        TableRow(
                          children: [
                            Text('Check-in missed'),
                            Text('22/05/2025 09:00AM'),
                          ],
                        ),
                        TableRow(
                          children: [
                            Text('Check-in missed'),
                            Text('22/05/2025 09:00AM'),
                          ],
                        ),
                        TableRow(
                          children: [
                            Text('Check-in missed'),
                            Text('22/05/2025 09:00AM'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
