import 'package:flutter/material.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  final List<Map<String, String>> _users = List.generate(50, (index) {
    final names = [
      'João',
      'Maria',
      'Pedro',
      'Ana',
      'Carlos',
      'Beatriz',
      'Rafael',
      'Sofia',
      'Manuel',
      'Carla',
      'Ricardo',
      'Helena',
      'Tiago',
      'Marta',
      'José',
      'Patrícia'
    ];
    final roles = ['Old Adult', 'Admin', 'Family Member', 'Caregiver'];
    final name = names[index % names.length];
    return {
      'name': name,
      'email': '${name.toLowerCase()}@example.com',
      'role': roles[index % roles.length],
    };
  });

  int _currentPage = 0;
  final int _rowsPerPage = 10;

  @override
  Widget build(BuildContext context) {
    final int totalPages = (_users.length / _rowsPerPage).ceil();
    final List<Map<String, String>> paginatedUsers = _users.skip(_currentPage * _rowsPerPage).take(_rowsPerPage).toList();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFD9D9D9),
        title: Row(
          children: [
            const Text(
              'Care',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const Text(
              'Connect',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/admin_dashboard');
              },
              child: const Text('Dashboard', style: TextStyle(color: Colors.black)),
            ),
            const SizedBox(width: 16),
            TextButton(
              onPressed: () {},
              child: const Text('Users List', style: TextStyle(color: Colors.blue)),
            ),
            const Spacer(),
          ],
        ),
        actions: [
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
              'Users List',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Name', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Email', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Role', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Action', style: TextStyle(fontWeight: FontWeight.bold))),
                        ],
                        rows: paginatedUsers.asMap().entries.map((entry) {
                          final index = entry.key;
                          final user = entry.value;
                          final isAdmin = user['role'] == 'Admin';
                          return DataRow(cells: [
                            DataCell(Text(user['name']!)),
                            DataCell(Text(user['email']!)),
                            DataCell(Text(user['role']!)),
                            DataCell(
                              ElevatedButton(
                                onPressed: () {
                                  _showConfirmationDialog(
                                    context,
                                    isAdmin ? 'Revoke Admin' : 'Make Admin',
                                    isAdmin
                                        ? 'Are you sure you want to revoke admin privileges for this user?'
                                        : 'Are you sure you want to make this user an admin?',
                                    () {
                                      setState(() {
                                        final globalIndex = _currentPage * _rowsPerPage + index;
                                        _users[globalIndex]['role'] = isAdmin ? 'Old Adult' : 'Admin';
                                      });
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            isAdmin
                                                ? 'Admin privileges revoked successfully!'
                                                : 'User successfully made an admin!',
                                          ),
                                          backgroundColor: isAdmin ? Colors.red : Colors.green,
                                        ),
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isAdmin ? Colors.red : Colors.blue,
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                ),
                                child: Text(
                                  isAdmin ? 'Revoke Admin' : 'Make Admin',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ]);
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: _currentPage > 0
                              ? () {
                                  setState(() {
                                    _currentPage--;
                                  });
                                }
                              : null,
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Text('Page ${_currentPage + 1} of $totalPages'),
                        IconButton(
                          onPressed: _currentPage < totalPages - 1
                              ? () {
                                  setState(() {
                                    _currentPage++;
                                  });
                                }
                              : null,
                          icon: const Icon(Icons.arrow_forward),
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

  void _showConfirmationDialog(
      BuildContext context, String title, String message, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              const Icon(Icons.warning, size: 48, color: Colors.orange),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Text(
            message,
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
              onPressed: onConfirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}
