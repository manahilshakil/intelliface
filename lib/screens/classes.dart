import 'package:flutter/material.dart';
import 'package:intelliface/screens/attendancescreen.dart';

class ProfessorScreen extends StatefulWidget {
  @override
  _ProfessorScreenState createState() => _ProfessorScreenState();
}

class _ProfessorScreenState extends State<ProfessorScreen> {
  bool isAnalyticsActive = false;

  // Example data
  int numClasses = 4;
  String subjectName = "Machine Learning";
  String classTime = "9:35 AM - 10:00 AM";
  int numStudents = 32;
  double attendancePercentage = 54.0;

  // Expanded card index (-1 means none expanded)
  int expandedCardIndex = -1;

  // Dummy students list for expanded view
  final List<String> students = [
    "Alice Johnson",
    "Bob Smith",
    "Carol Lee",
    "David Kim",
    "Eve Turner",
  ];

  @override
  Widget build(BuildContext context) {
    final double tabWidth = (MediaQuery.of(context).size.width - 40) / 2;

    return Scaffold(
      backgroundColor: Colors.white,
      

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blue[300],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Classes",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text("Check out your schedule",
                          style: TextStyle(color: Colors.white70)),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            // Pill tab with sliding indicator & icons
            Container(
              height: 46,
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Stack(
                children: [
                  AnimatedAlign(
                    duration: Duration(milliseconds: 300),
                    alignment: isAnalyticsActive ? Alignment.centerRight : Alignment.centerLeft,
                    curve: Curves.easeInOut,
                    child: Container(
                      width: tabWidth,
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.3),
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () => setState(() => isAnalyticsActive = false),
                          child: Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.book, size: 20, color: isAnalyticsActive ? Colors.black54 : Colors.white),
                                SizedBox(width: 6),
                                Text(
                                  "Classes",
                                  style: TextStyle(
                                    color: isAnalyticsActive ? Colors.black54 : Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () => setState(() => isAnalyticsActive = true),
                          child: Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.bar_chart, size: 20, color: isAnalyticsActive ? Colors.white : Colors.black54),
                                SizedBox(width: 6),
                                Text(
                                  "Analytics",
                                  style: TextStyle(
                                    color: isAnalyticsActive ? Colors.white : Colors.black54,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            // Conditional view
            isAnalyticsActive ? _buildAnalyticsView() : _buildClassesView(),
          ],
        ),
      ),
    );
  }

  // Classes View
  Widget _buildClassesView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with "Today, Classes (4)" and "See All >"
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Today, Classes ($numClasses)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.chevron_right, size: 20, color: Colors.blue[300]),
              label: Text(
                "See All",
                style: TextStyle(fontSize: 14, color: Colors.blue[300]),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                minimumSize: Size(60, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),

        // List of classes
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: numClasses,
          itemBuilder: (context, index) => _buildClassCard(),
        ),
      ],
    );
  }

  // Class card with expand on tap
  Widget _buildClassCard() {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AttendanceScreen()),
      );
    },
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
        color: Colors.white,
      ),
      child: Row(
        children: [
          // Colored vertical bar on left
          Container(
            width: 6,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              gradient: LinearGradient(
                colors: [Colors.blue.shade400, Colors.blue.shade200],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subjectName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    classTime,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Students count badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.blue.shade300,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade100.withOpacity(0.6),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.people, color: Colors.white, size: 16),
                SizedBox(width: 4),
                Text(
                  "$numStudents",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          Icon(Icons.arrow_forward_ios, color: Colors.grey.shade600, size: 18),
          SizedBox(width: 8),
        ],
      ),
    ),
  );
}


  // Analytics View
  Widget _buildAnalyticsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Attendance Trend header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Attendance Trend", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {},
              child: Text("Download", style: TextStyle(color: Colors.blue[300])),
            ),
          ],
        ),
        SizedBox(height: 8),
        Container(
          height: 220,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text("Graph Placeholder"),
        ),

        // Subject wise attendance section
        SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Subject Wise", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {},
              child: Text("Past 7 days", style: TextStyle(fontSize: 14, color: Colors.blue[300])),
            ),
          ],
        ),
        SizedBox(height: 12),

        _buildSubjectAttendance(),
      ],
    );
  }

  // Subject Attendance Bar
  Widget _buildSubjectAttendance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(subjectName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: attendancePercentage / 100,
                minHeight: 12,
                backgroundColor: Colors.grey[300],
                color: Colors.blue[300],
              ),
            ),
            SizedBox(width: 12),
            Text(
              "${attendancePercentage.toStringAsFixed(0)}%",
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        )
      ],
    );
  }
}
