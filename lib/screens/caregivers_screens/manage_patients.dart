import 'package:flutter/material.dart';

class PatientListScreen extends StatelessWidget {
  const PatientListScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/caregiver_dashboard'); // Corrected navigation to caregiver_dashboard
                  },
                  child: Text(
                    'Dashboard',
                    style: TextStyle(
                      color: ModalRoute.of(context)?.settings.name == '/caregiver_dashboard'
                          ? Colors.blue
                          : Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Patients',
                    style: TextStyle(
                      color: ModalRoute.of(context)?.settings.name == '/patients'
                          ? Colors.blue
                          : Colors.black,
                    ),
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
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
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
              'Old Adults Under My Care',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'You are currently managing 14 seniors',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                final isSmallScreen = constraints.maxWidth < 600;

                return Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  alignment: WrapAlignment.start,
                  children: [
                    SizedBox(
                      width: isSmallScreen ? constraints.maxWidth * 0.8 : constraints.maxWidth * 0.5,
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Search by name',
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: isSmallScreen ? constraints.maxWidth * 0.9 : null,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Add Patient'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Email of older adult',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 8),
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Enter email',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Close the dialog
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.grey[600],
                                    ),
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(color: Colors.white), // Ensure white text
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Close the dialog
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Patient added!'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                    child: const Text(
                                      'Link Patient',
                                      style: TextStyle(color: Colors.white), // Ensure white text
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text(
                          'Add patient',
                          style: TextStyle(color: Colors.white), // Ensure white text
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 800
                      ? 5
                      : constraints.maxWidth > 600
                          ? 3
                          : 2;

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: 14, // Update to display 14 cards
                    itemBuilder: (context, index) {
                      final List<Map<String, dynamic>> persons = [
                        {'name': 'Manuel Matos', 'age': 97, 'image': 'assets/images/old-adult-image.png'},
                        {'name': 'Joao Tomas', 'age': 67, 'image': 'assets/images/default-profile-picture.png'},
                        {'name': 'Maria Silva', 'age': 85, 'image': 'assets/images/old-adult-female-image.png'},
                        {'name': 'Ana Costa', 'age': 72, 'image': 'assets/images/old-adult-female-image.png'},
                        {'name': 'Carlos Santos', 'age': 90, 'image': 'assets/images/old-adult-image.png'},
                        {'name': 'Isabel Ferreira', 'age': 78, 'image': 'assets/images/old-adult-female-image.png'},
                        {'name': 'Pedro Oliveira', 'age': 88, 'image': 'assets/images/old-adult-image.png'},
                        {'name': 'Sofia Martins', 'age': 70, 'image': 'assets/images/default-profile-picture.png'},
                        {'name': 'Luis Almeida', 'age': 82, 'image': 'assets/images/old-adult-image.png'},
                        {'name': 'Helena Rocha', 'age': 75, 'image': 'assets/images/default-profile-picture.png'},
                        {'name': 'Ricardo Lopes', 'age': 89, 'image': 'assets/images/old-adult-image.png'},
                        {'name': 'Teresa Carvalho', 'age': 73, 'image': 'assets/images/default-profile-picture.png'},
                        {'name': 'Miguel Pinto', 'age': 80, 'image': 'assets/images/old-adult-image.png'},
                        {'name': 'Clara Nunes', 'age': 76, 'image': 'assets/images/old-adult-female-image.png'},
                      ];

                      final person = persons[index];

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 60,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                child: Image.asset(
                                  person['image'],
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Name: ',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        TextSpan(
                                          text: person['name'],
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Age: ',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '${person['age']}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/patient_profile',
                                            arguments: person, // Pass the patient data to the profile page
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          minimumSize: const Size(140, 30),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                        ),
                                        child: const Text(
                                          'View',
                                          style: TextStyle(color: Colors.white), // Ensure white text
                                        ),
                                      ),
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
                                          minimumSize: const Size(60, 30),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                        ),
                                        child: const Text('Remove'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
