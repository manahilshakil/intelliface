import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:intelliface/screens/profile.dart';

class ProfileSettingsScreen extends StatefulWidget {
  final String email;
  final String id;
  final String language;

  const ProfileSettingsScreen({
    super.key,
    required this.email,
    required this.id,
    required this.language,
  });

  @override
  _ProfileSettingsScreenState createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  File? _image;
  final picker = ImagePicker();

  late String email;
  late String id;
  late String selectedLanguage;

  @override
  void initState() {
    super.initState();
    email = widget.email;
    id = widget.id;
    selectedLanguage = widget.language;
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blue[300],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: ()  {
                      Navigator.pop(context);
                    }
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Settings",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text("Edit your profile settings",
                          style: TextStyle(color: Colors.white70)),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Profile Image Picker
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black54),
                      ),
                      child: _image == null
                          ? const Icon(Icons.camera_alt, size: 40, color: Colors.grey)
                          : ClipOval(
                              child: Image.file(_image!, fit: BoxFit.cover),
                            ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Manahil Shakil",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Assistant Prof.",
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Work Details Section
            const Text("Work Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const Text("Enter Email & ID", style: TextStyle(color: Colors.blue, fontSize: 12)),
            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: "Email:",
                    ),
                    controller: TextEditingController(text: email),
                    onChanged: (value) => email = value,
                  ),
                  const Divider(),
                  TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: "ID:",
                    ),
                    controller: TextEditingController(text: id),
                    onChanged: (value) => id = value,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Language Section
            const Text("Language", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const Text("Select your Language", style: TextStyle(color: Colors.blue, fontSize: 12)),
            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  _buildRadioOption("Urdu"),
                  const Divider(),
                  _buildRadioOption("English"),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Save Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context, {
                    'email': email,
                    'id': id,
                    'language': selectedLanguage,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                icon: Icon(Icons.save, color: Colors.white),
                label: Text("Save Changes", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption(String language) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(language, style: const TextStyle(fontSize: 16)),
        Radio<String>(
          value: language,
          groupValue: selectedLanguage,
          activeColor: Colors.black,
          onChanged: (value) {
            setState(() {
              selectedLanguage = value!;
            });
          },
        ),
      ],
    );
  }
}
