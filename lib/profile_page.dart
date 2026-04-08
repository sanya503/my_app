import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> userData;

  const ProfilePage({super.key, required this.userData});

  Widget infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: TextStyle(color: Colors.grey)),
          ),
          Expanded(
            child: Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        backgroundColor: Colors.blue.shade900,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue.shade900,
              child: Text(
                (userData["name"] != null && userData["name"].isNotEmpty) 
                    ? userData["name"][0] 
                    : "U",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            SizedBox(height: 10),

            Text(
              userData["name"] ?? "User",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            Text(userData["email"] ?? ""),

            SizedBox(height: 20),

            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  infoRow("Reg. Code", userData["id"] != null 
                      ? "VIDYEN/${userData["id"].toString().padLeft(7, '0')}" 
                      : "Pending"),
                  infoRow("Delegate Type", userData["delegate_type"] ?? ""),
                  infoRow("Designation", userData["designation"] ?? ""),
                  infoRow("Institution", userData["college_name"] ?? ""),
                  infoRow("City", userData["city"] ?? ""),
                  infoRow("Country", userData["country"] ?? ""),
                  infoRow("Phone", userData["mobile"] ?? ""),
                  infoRow("Status", "Pending"),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
