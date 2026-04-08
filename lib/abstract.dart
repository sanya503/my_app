import 'package:flutter/material.dart';
import 'abstract_form_page.dart';
import 'profile_page.dart';
import 'login_screen.dart';

class Abstractpage extends StatelessWidget {
  final Map<String, dynamic>? userData;
  const Abstractpage({super.key, this.userData});
  Widget abstractCard(String title, String id, String status, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.white12, blurRadius: 16)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.description, color: Colors.blue.shade900),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(id, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(status, style: TextStyle(color: color)),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16),
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
          abstractCard(
            "Abstract submission",
            "AUT000001",
            "Evaluated",
            Colors.green,
          ),
          abstractCard(
            "Abstract submission",
            "AUT000005",
            "Submitted",
            Colors.orange,
          ),
          abstractCard("qwertt", "AUT000006", "Submitted", Colors.orange),
          abstractCard("cdscds", "AUT000007", "Submitted", Colors.orange),
          abstractCard("ccds", "AUT000008", "Submitted", Colors.orange),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AbstractFormPage(userData: userData),
            ),
          );
        },
        backgroundColor: Colors.blue.shade900,
        icon: Icon(Icons.add, color: Colors.white),
        label: Text("Submit", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
