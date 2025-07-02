import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 800;

          return isWide
              ? Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Image.asset(
                        'assets/images/login-image.png',
                        fit: BoxFit.cover,
                        height: double.infinity,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: _LoginForm(),
                      ),
                    ),
                  ],
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/login-image.png',
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: _LoginForm(),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Log In',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: 'Your email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Forgot your password? '),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Forgot Password'),
                            content: TextField(
                              decoration: const InputDecoration(
                                labelText: 'Enter your email',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Display confirmation message
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Password reset email sent!'),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green, // Green background
                                  foregroundColor: Colors.white, // White text
                                ),
                                child: const Text('Send'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Click here!',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Do nothing
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
              child: const Text('Log In'),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register'); // Navigate to register screen
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            ),
            const SizedBox(height: 24), // Add spacing before the new buttons
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 2,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildRoleButton(
                  context: context,
                  icon: Icons.person,
                  label: 'Old Adult',
                  onPressed: () {
                    Navigator.pushNamed(context, '/old_adult_dashboard'); // Simulate Old Adult login
                  },
                ),
                _buildRoleButton(
                  context: context,
                  icon: Icons.family_restroom,
                  label: 'Family Member',
                  onPressed: () {
                    Navigator.pushNamed(context, '/family_dashboard'); // Navigate to Family Dashboard
                  },
                ),
                _buildRoleButton(
                  context: context,
                  icon: Icons.health_and_safety,
                  label: 'Caregiver',
                  onPressed: () {
                    Navigator.pushNamed(context, '/caregiver_dashboard'); // Simulate Caregiver login
                  },
                ),
                _buildRoleButton(
                  context: context,
                  icon: Icons.admin_panel_settings,
                  label: 'Admin',
                  onPressed: () {
                    Navigator.pushNamed(context, '/admin_dashboard'); // Navigate to Admin Dashboard
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 16),
        minimumSize: const Size(120, 80), // Increased width and height
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 32, color: Colors.black), // Centered icon
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ), // Centered text
        ],
      ),
    );
  }
}
