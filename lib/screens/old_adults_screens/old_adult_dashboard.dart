import 'package:flutter/material.dart';

class OldAdultDashboard extends StatelessWidget {
  const OldAdultDashboard({super.key});

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
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/old_adult_dashboard');
              },
              child: Text(
                'Dashboard',
                style: TextStyle(
                  color: ModalRoute.of(context)?.settings.name == '/old_adult_dashboard'
                      ? Colors.blue
                      : Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/manage_caregivers');
              },
              child: Text(
                'Caregivers',
                style: TextStyle(
                  color: ModalRoute.of(context)?.settings.name == '/caregiver_dashboard'
                      ? Colors.blue
                      : Colors.black,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              // Handle notifications
            },
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage('assets/images/greeting-image.jpg'), // Add your background image to assets
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                'Good Morning, John!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 4,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),
            Expanded(
              child: Center(
                child: GridView.count(
                  crossAxisCount: 3, // 3 columns
                  crossAxisSpacing: 12.0, // Adjusted spacing between buttons
                  mainAxisSpacing: 12.0, // Adjusted spacing between rows
                  childAspectRatio: 1.8, // Adjusted aspect ratio for smaller buttons
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(), // Prevent scrolling
                  children: [
                    _buildDashboardButton(
                      color: Colors.green.shade200,
                      icon: Icons.check_circle,
                      label: 'Check-In',
                      iconColor: Colors.green,
                      textColor: Colors.green,
                      onPressed: () => Navigator.pushNamed(context, '/check_in'),
                    ),
                    _buildDashboardButton(
                      color: Colors.blue.shade200,
                      icon: Icons.medication,
                      label: 'Medication',
                      iconColor: Colors.blue,
                      textColor: Colors.blue,
                      onPressed: () => Navigator.pushNamed(context, '/medication_screen'),
                    ),
                    _buildDashboardButton(
                      color: Colors.blue.shade100,
                      icon: Icons.local_drink,
                      label: 'Hydration',
                      iconColor: Colors.blue,
                      textColor: Colors.blue,
                      onPressed: () => Navigator.pushNamed(context, '/hydration'),
                    ),
                    _buildDashboardButton(
                      color: Colors.green.shade100,
                      icon: Icons.restaurant,
                      label: 'Nutrition',
                      iconColor: Colors.green,
                      textColor: Colors.green,
                      onPressed: () => Navigator.pushNamed(context, '/nutrition'),
                    ),
                    _buildDashboardButton(
                      color: Colors.red.shade200,
                      icon: Icons.checklist,
                      label: 'Tasks',
                      iconColor: Colors.red,
                      textColor: Colors.red,
                      onPressed: () => Navigator.pushNamed(context, '/tasks'),
                    ),
                    _buildDashboardButton(
                      color: Colors.grey.shade300,
                      icon: Icons.help_outline,
                      label: 'Help',
                      iconColor: Colors.black,
                      textColor: Colors.black,
                      onPressed: () => Navigator.pushNamed(context, '/help'), // Corrected navigation
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

  Widget _buildDashboardButton({
    required Color color,
    required IconData icon,
    required String label,
    required Color iconColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        padding: const EdgeInsets.all(16.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: iconColor), // Increased icon size
          const SizedBox(height: 16), // Adjusted spacing
          Text(
            label,
            style: TextStyle(
              fontSize: 20, // Increased font size
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
