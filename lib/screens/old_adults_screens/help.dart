import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final helpItems = [
      _HelpItem(Icons.check_circle, Colors.green, 'Check-In',
          'Tap ‘Check-in’ to confirm you are doing well.'),
      _HelpItem(Icons.medication, Colors.blue, 'Medication',
          'Tap ‘Medication’ to see your medications and mark them as taken.'),
      _HelpItem(Icons.water_drop, Colors.blue, 'Hydration',
          'Tap ‘Hydration’ to confirm you’ve hydrated yourself.'),
      _HelpItem(Icons.restaurant, Colors.green, 'Nutrition',
          'Tap ‘Nutrition’ to confirm you’ve eaten your meals.'),
      _HelpItem(Icons.checklist, Colors.red, 'Tasks',
          'Tap ‘Tasks’ to see and check off your tasks for the day.'),
      _HelpItem(Icons.emergency, Colors.red, 'Emergency',
          'In case of emergency, tap the ‘Emergency’ button to get help.'),
    ];

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
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/old_adult_dashboard');
              },
              child: const Text('Dashboard', style: TextStyle(color: Colors.blue)),
            ),
            const SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/manage_caregivers');
              },
              child: const Text('Caregivers', style: TextStyle(color: Colors.black)),
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
            icon: const Icon(Icons.emergency, color: Colors.red),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Column(
                      children: [
                        Icon(Icons.emergency, size: 48, color: Colors.red),
                        const SizedBox(height: 8),
                        const Text(
                          'Activate Emergency',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    content: const Text(
                      'Are you sure you want to activate the emergency button?',
                      textAlign: TextAlign.center,
                    ),
                    actionsAlignment: MainAxisAlignment.spaceEvenly,
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.grey.shade300,
                        ),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Emergency activated! Help is on the way.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Activate'),
                      ),
                    ],
                  );
                },
              );
            },
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
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Help',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 48),
                Wrap(
                  spacing: 48,
                  runSpacing: 48,
                  alignment: WrapAlignment.center,
                  children: helpItems.map((item) => _buildHelpBlock(item)).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHelpBlock(_HelpItem item) {
    return SizedBox(
      width: 400,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(item.icon, size: 40, color: item.color),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  item.description,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HelpItem {
  final IconData icon;
  final Color color;
  final String title;
  final String description;

  _HelpItem(this.icon, this.color, this.title, this.description);
}
