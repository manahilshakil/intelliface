import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Add in pubspec.yaml

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _timeString = '';
  bool isClockedIn = false;
  Timer? _timer;

  int worked = 14;
  int absent = 4;
  int late = 12;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _updateTime());
  }

  void _updateTime() {
    final String formattedTime = DateFormat('hh:mm a').format(DateTime.now());
    if (!mounted) return;
    setState(() {
      _timeString = formattedTime;
    });
  }

  void _toggleClockIn() {
    setState(() {
      isClockedIn = !isClockedIn;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // GREETING CARD
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue[300],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.blue[300]),
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello, Manahil",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text("Have a great day!",
                          style: TextStyle(color: Colors.white70)),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20),

            // TIME & CLOCK-IN STATUS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today, ${DateFormat('dd MMM').format(DateTime.now())}",
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                    Text(
                      _timeString,
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    Text("On time",
                        style:
                            TextStyle(fontSize: 12, color: Colors.green[700])),
                  ],
                ),
                // Pill Style Status Badge
                Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isClockedIn ? Colors.green[100] : Colors.red[100],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isClockedIn ? Icons.check_circle : Icons.cancel,
                            color: isClockedIn ? Colors.green : Colors.red,
                            size: 18,
                          ),
                          SizedBox(width: 6),
                          Text(
                            isClockedIn ? "Clocked In" : "Not Clocked In",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color:
                                  isClockedIn ? Colors.green[800] : Colors.red[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 8),
            Text("Working Hours",
                style: TextStyle(fontSize: 13, color: Colors.grey[600])),
            Text("9AM - 2PM",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),

            SizedBox(height: 15),

            // CONDITIONAL CLOCK IN BUTTON
            Center(
              child: ElevatedButton.icon(
                onPressed: _toggleClockIn,
                icon: Icon(
                    isClockedIn ? Icons.logout : Icons.login, color: Colors.white),
                label: Text(isClockedIn ? "Clock Out" : "Clock In"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  backgroundColor:
                      isClockedIn ? Colors.redAccent : Colors.blue[300],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            SizedBox(height: 30),

            // ATTENDANCE SECTION
            Text("Attendance",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5)),

            SizedBox(height: 15),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Replace with real image
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/graph.JPG',
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 12),

                // Attendance cards - compact
                Column(
                  children: [
                    _buildAttendanceCard("Worked", worked, Colors.blueAccent),
                    SizedBox(height: 10),
                    _buildAttendanceCard("Absent", absent, Colors.red),
                    SizedBox(height: 10),
                    _buildAttendanceCard(
                        "Late", late, Colors.black),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceCard(
      String label, int count, Color color) {
    return Container(
      width: 80,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text("$count",
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 2),
          Text(label,
              style: TextStyle(fontSize: 10, color: Colors.white)),
        ],
      ),
    );
  }
}
