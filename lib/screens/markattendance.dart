import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MarkAttendanceScreen(),
  ));
}

class MarkAttendanceScreen extends StatefulWidget {
  @override
  _MarkAttendanceScreenState createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  List<bool> attendanceStatus = [false, false, false]; // Default: All Absent
  int presentCount = 0;
  int absentCount = 3; // Initially, everyone is absent

  void _toggleAttendance(int index) {
    setState(() {
      attendanceStatus[index] = !attendanceStatus[index];
      presentCount = attendanceStatus.where((status) => status).length;
      absentCount = attendanceStatus.length - presentCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Styled AppBar Area
          Container(
            decoration: BoxDecoration(
              color: Colors.blue[300],
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
            ),
            padding: EdgeInsets.only(top: 48, left: 16, right: 16, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back icon and titles
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Machine Learning",
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        Text("Sec (A)",
                            style: TextStyle(color: Colors.white70, fontSize: 14)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Status cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatusCard(presentCount.toString(), "Present", Icons.check_circle, Colors.green),
                    _buildStatusCard(absentCount.toString(), "Absent", Icons.cancel, Colors.red),
                  ],
                ),
                SizedBox(height: 20),

                // Start Attendance Button
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.how_to_reg),
                    label: Text("Start Attendance"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      shape: StadiumBorder(),
                      elevation: 4,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10),

          // "See All"
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text("See All", style: TextStyle(color: Colors.blue, fontSize: 12)),
            ),
          ),
          SizedBox(height: 10),
          // Students Table Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("Name", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Text("Roll No.", style: TextStyle(fontWeight: FontWeight.bold)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("Status", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),

          // Student List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10),
              itemCount: attendanceStatus.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    _buildStudentRow("Manahil", "0${index + 1}", index),
                    Divider(thickness: 1, color: Colors.grey[300]),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 🔷 New Status Card UI
  Widget _buildStatusCard(String count, String label, IconData icon, Color iconColor) {
    return Container(
      width: 130,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 28),
          SizedBox(height: 6),
          Text(count, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: iconColor)),
          Text(label, style: TextStyle(color: Colors.grey[700])),
        ],
      ),
    );
  }

  // Student row with tap to toggle
  Widget _buildStudentRow(String name, String rollNo, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: TextStyle(fontSize: 16)),
          Text(rollNo, style: TextStyle(fontSize: 16)),
          GestureDetector(
            onTap: () => _toggleAttendance(index),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: attendanceStatus[index] ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                attendanceStatus[index] ? "Present" : "Absent",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
