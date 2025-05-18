import 'package:flutter/material.dart';
// SIGN-UP SCREEN
class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.JPG', width: 100, height: 100),
            SizedBox(height: 20),
            Text("Sign Up", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Create your account", style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            TextField(decoration: InputDecoration(labelText: "Username", border: OutlineInputBorder())),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder())),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "Password", border: OutlineInputBorder()), obscureText: true),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "Confirm Password", border: OutlineInputBorder()), obscureText: true),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {}, 
              child: Text("Sign up", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Blue Button
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: Text("Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}