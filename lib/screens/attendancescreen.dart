import 'package:flutter/material.dart';
import 'package:intelliface/screens/markattendance.dart';

class AttendanceScreen extends StatelessWidget {
 final List<Map<String, String>> students = [
  {"name": "Manahil Shakil", "roll": "1"},
  {"name": "Muhammad Ashir", "roll": "2"},
  {"name": "Moizz Khan", "roll": "3"},
  {"name": "Fatima Ahmed", "roll": "4"},
  {"name": "Hassan Raza", "roll": "5"},
  {"name": "Ayesha Khan", "roll": "6"},
  {"name": "Ali Hassan", "roll": "7"},
  {"name": "Sara Ahmed", "roll": "8"},
  {"name": "Usman Khan", "roll": "9"},
  {"name": "Zainab Raza", "roll": "10"},
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Machine Learning\nSec (A)",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        centerTitle: true,
        toolbarHeight: 70,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Menu Buttons with Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMenuButton(context, "Mark Attendance", Icons.check_circle, MarkAttendanceScreen()),
                _buildMenuButton(context, "Assignments", Icons.assignment, MarkAttendanceScreen()),
                _buildMenuButton(context, "Check Timetable", Icons.schedule, MarkAttendanceScreen()),
              ],
            ),
            SizedBox(height: 20),

            // Students Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Students (${students.length})", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Text("See All", style: TextStyle(color: Colors.blue, fontSize: 14)),
                      Icon(Icons.arrow_forward_ios, size: 12, color: Colors.blue),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),

            // Student List
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  return _buildStudentCard(
                    context,
                    students[index]['name']!,
                    students[index]['roll']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable Menu Button with Icon
  Widget _buildMenuButton(BuildContext context, String label, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
      child: Column(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
            ),
            child: Icon(icon, color: Colors.white),
          ),
          SizedBox(height: 6),
          Container(
            width: 70,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Improved Student Card
  Widget _buildStudentCard(BuildContext context, String name, String rollNo) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => StudentDetailScreen(name, rollNo)),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFFF9F9FF),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3)),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person, color: Colors.grey[600]),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  SizedBox(height: 4),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text("Roll no - $rollNo", style: TextStyle(color: Colors.blue[700], fontSize: 12)),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

// Student Detail Screen (Dummy)
class StudentDetailScreen extends StatelessWidget {
  final String name;
  final String rollNo;

  StudentDetailScreen(this.name, this.rollNo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$name Details")),
      body: Center(child: Text("Details for $name, Roll No: $rollNo")),
    );
  }
}
