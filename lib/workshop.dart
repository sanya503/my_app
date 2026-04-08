import 'package:flutter/material.dart';
import 'abstract_form_page.dart';
import 'profile_page.dart';
import 'login_screen.dart';

class WorkShopPage extends StatelessWidget {
  final Map<String, dynamic>? userData;
  const WorkShopPage({super.key, this.userData});
  Widget workcard({
    required String id,
    required String title,
    required String subtitle,
    required String status,
    required Color statuscolor,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(id, style: TextStyle(color: Colors.grey)),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: statuscolor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(status, style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(subtitle, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
        title: const Text(
          "VIDYEN",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
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
          workcard(
            id: "WRK0001",
            title: "asdasd",
            subtitle: "Assessment in Competency Based Dental Education",
            status: "Evaluated",
            statuscolor: Colors.blue.shade900,
          ),
          workcard(
            id: "WRK0002",
            title: "dsds",
            subtitle:
                "Teaching & Learning in Competency Based Dental Education",
            status: "Submitted",
            statuscolor: Colors.orange,
          ),
          workcard(
            id: "WRK00003",
            title: "sdccsd",
            subtitle: "Interprofessional Education in Dental Education",
            status: "Submitted",
            statuscolor: Colors.orange,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue.shade900,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AbstractFormPage()),
          );
        },
        icon: Icon(Icons.add, color: Colors.white),
        label: Text("Submit", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
