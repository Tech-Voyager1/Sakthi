import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
            ),
            child: Center(
              child: Text(
                'Smart Box Tracker',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Live Tracking'),
            onTap: () {
              // Navigate to live tracking
            },
          ),

          ExpansionTile(
            leading: Icon(Icons.inventory_2), // box icon
            title: Text('Manage Box'),
            children: [
              ListTile(
                leading: Icon(Icons.add_box),
                title: Text('Create Box'),
                onTap: () {
                  // Navigate to create box
                },
              ),
              ListTile(
                leading: Icon(Icons.indeterminate_check_box),
                title: Text('Remove Box'),
                onTap: () {
                  // Navigate to remove box
                },
              ),
            ],
          ),

          ListTile(
            leading: Icon(Icons.analytics),
            title: Text('Box Dashboard'),
            onTap: () {
              // Navigate to dashboard
            },
          ),

          Spacer(), // pushes sign-out to the bottom

          Divider(),

          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Sign Out'),
            onTap: () {
              // Sign out logic
            },
          ),
        ],
      ),
    );
  }
}
