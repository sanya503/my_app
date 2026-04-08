import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'login_screen.dart';

class PreConferencePage extends StatelessWidget {
  final Map<String, dynamic>? userData;
  const PreConferencePage({super.key, this.userData});
  Widget buildCard(
    String id,
    String title,
    String subtitle,
    String status,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ID + Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(id, style: const TextStyle(color: Colors.grey)),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Title
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          const SizedBox(height: 5),

          // Subtitle
          Text(subtitle, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Vidyen"),
        backgroundColor: Colors.blue.shade900,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_2_outlined),
            onPressed: () {
              if (userData != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(userData: userData!),
                  ),
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: ListView(
        children: [
          buildCard(
            "PRE0002",
            "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet",
            "Teaching & Learning in Competency Based Dental Education",
            "Under Review",
            Colors.blue.shade900,
          ),
          buildCard(
            "PRE0003",
            "dsds",
            "Assessment in Competency Based Dental Education",
            "Submitted",
            Colors.orange,
          ),
          buildCard(
            "PRE0004",
            "cdad",
            "Assessment in Competency Based Dental Education",
            "Submitted",
            Colors.orange,
          ),
          buildCard(
            "PRE00005",
            "ghghhg",
            "Interprofessional Education in Dental Education",
            "Submitted",
            Colors.orange,
          ),
        ],
      ),
    );
  }
}
