import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:badges/badges.dart' as badges;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController(text: 'Manuel Oliveira');
  final _emailController = TextEditingController(text: 'manuel.oliveira@example.com');
  final _addressController = TextEditingController(text: 'Avenida das Amoreiras');
  final _dobController = TextEditingController(text: '28/02/2025');
  final _phoneController = TextEditingController(text: '931312321');

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD9D9D9),
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Text('Care', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
            const Text('Connect', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)),
            const Spacer(),
            GestureDetector(
              onTapDown: (TapDownDetails details) {
                final RenderBox renderBox = context.findRenderObject() as RenderBox;
                final Offset offset = renderBox.localToGlobal(Offset.zero);
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(
                    offset.dx + renderBox.size.width - 40,
                    offset.dy + 56,
                    offset.dx,
                    offset.dy,
                  ),
                  items: [
                    PopupMenuItem(
                      child: ListTile(
                        leading: const Icon(Icons.event, color: Colors.blue),
                        title: const Text('Your appointment is tomorrow.'),
                      ),
                    ),
                    PopupMenuItem(
                      child: ListTile(
                        leading: const Icon(Icons.update, color: Colors.green),
                        title: const Text('Your profile was updated successfully.'),
                      ),
                    ),
                  ],
                );
              },
              child: badges.Badge(
                badgeContent: const Text('1', style: TextStyle(color: Colors.white, fontSize: 12)),
                position: badges.BadgePosition.topEnd(top: -5, end: -5),
                child: const Icon(Icons.notifications, color: Colors.black),
              ),
            ),
            IconButton(icon: const Icon(Icons.account_circle, color: Colors.black), onPressed: () {}),
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.black),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home_screen'); // Navigate to the main screen
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 48, 24, 24), // Added top margin of 48
        child: Center(
          child: isWideScreen
              ? IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: _buildProfileCard()),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          children: [
                            _buildUserDataCard(),
                            const SizedBox(height: 16),
                            _buildPasswordCard(),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    _buildProfileCard(),
                    const SizedBox(height: 24),
                    _buildUserDataCard(),
                    const SizedBox(height: 16),
                    _buildPasswordCard(),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/old-adult-image.png'),
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 16,
                    child: Icon(Icons.camera_alt, size: 18, color: Colors.black54),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Manuel Oliveira', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text('manuel.oliveira@example.com', style: TextStyle(color: Colors.grey)),
            const Text('Old Adult', style: TextStyle(color: Colors.grey)),
            const Spacer(), // Pushes the buttons to the bottom
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home_screen'); // Navigate to the main screen
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Logout'),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Column(
                        children: [
                          const Icon(Icons.warning, size: 48, color: Colors.red),
                          const SizedBox(height: 8),
                          const Text(
                            'Delete Account',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      content: const Text(
                        'Are you sure you want to delete your account? This action cannot be undone.',
                        textAlign: TextAlign.center,
                      ),
                      actionsAlignment: MainAxisAlignment.spaceEvenly,
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
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
                            Navigator.pushNamed(context, '/home_screen'); // Navigate to a valid route
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Account deleted successfully.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Delete'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.delete),
              label: const Text('Delete Account'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserDataCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextField('Name', Icons.person, _nameController),
            const SizedBox(height: 16),
            _buildTextField('Address', Icons.home, _addressController),
            const SizedBox(height: 16),
            _buildDateField(),
            const SizedBox(height: 16),
            _buildPhoneField(),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('User data updated successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              icon: const Icon(Icons.edit),
              label: const Text('Update User Data'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[100],
                foregroundColor: Colors.teal[900],
                minimumSize: const Size.fromHeight(40),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Change Password', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Old Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Password changed successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              icon: const Icon(Icons.password),
              label: const Text('Change Password'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[100],
                foregroundColor: Colors.teal[900],
                minimumSize: const Size.fromHeight(40),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDateField() {
    return TextField(
      controller: _dobController,
      readOnly: true,
      decoration: const InputDecoration(
        labelText: 'Date of Birth',
        prefixIcon: Icon(Icons.calendar_today),
        border: OutlineInputBorder(),
      ),
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (picked != null) {
          _dobController.text = "${picked.day.toString().padLeft(2, '0')}/"
              "${picked.month.toString().padLeft(2, '0')}/"
              "${picked.year}";
        }
      },
    );
  }

  Widget _buildPhoneField() {
    return Row(
      children: [
        CountryCodePicker(
          onChanged: (country) {},
          initialSelection: 'PT',
          favorite: const ['+351', 'PT'],
          showFlag: true,
          showCountryOnly: false,
          showOnlyCountryWhenClosed: false,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
