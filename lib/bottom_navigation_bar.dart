import 'package:flutter/material.dart';
import 'abstract.dart';
import 'certificate.dart';
import 'pre_conf.dart';
import 'home.dart';
import 'workshop.dart';

class MainBottomBar extends StatefulWidget {
  final Map<String, dynamic>? userData;

  const MainBottomBar({super.key, this.userData});

  @override
  State<MainBottomBar> createState() => _MainBottomBarState();
}

class _MainBottomBarState extends State<MainBottomBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // ✅ MOVE PAGES HERE
    final List<Widget> pages = [
      DashboardPage(userData: widget.userData),
      Abstractpage(userData: widget.userData),
      PreConferencePage(userData: widget.userData),
      WorkShopPage(userData: widget.userData),
      CertificatePage(userData: widget.userData),
    ];

    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue.shade900,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: "Submit",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Pre-Conf",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.build), label: "Workshop"),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_membership),
            label: "Certificates",
          ),
        ],
      ),
    );
  }
}
