import 'package:flutter/material.dart';
import 'package:intelliface/screens/settingsprofile.dart';
 // Import the settings screen

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "Manahil Shakil";
  String profession = "Assistant Professor";
  String email = "manahil@example.com";
  String id = "12345";
  String language = "English";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // App bar-style container with "Profile" and settings icon
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blue[300],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Profile",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text("View your profile settings",
                          style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.settings, color: Colors.white),
                    onPressed: () async {
                      // Navigate to settings and wait for result
                      final updatedData = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileSettingsScreen(
                            email: email,
                            id: id,
                            language: language,
                          ),
                        ),
                      );

                      // If data was returned, update state
                      if (updatedData != null) {
                        setState(() {
                          email = updatedData['email'];
                          id = updatedData['id'];
                          language = updatedData['language'];
                        });
                      }
                    },
                  ),
                ],
              ),
            ),

            // Profile picture and name
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue[100],
              backgroundImage: null,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            SizedBox(height: 12),
            Text(name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            SizedBox(height: 4),
            Text(profession, style: TextStyle(fontSize: 14, color: Colors.grey[700])),

            SizedBox(height: 32),

            // Work Details Section
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Work Details",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
            ),
            SizedBox(height: 16),

            _buildDetailRow("Email", email),
            Divider(height: 24, thickness: 1),
            _buildDetailRow("ID", id),
            Divider(height: 24, thickness: 1),
            _buildDetailRow("Language", language),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 100, child: Text("$label:", style: TextStyle(fontWeight: FontWeight.w500))),
        Expanded(child: Text(value, style: TextStyle(color: Colors.grey[800]))),
      ],
    );
  }
}
