import 'package:flutter/material.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/screens/contact/contact_fragment.dart';
import 'package:mobile_app/screens/main_menu/my_receips/my_receipts_screen.dart';
import 'package:mobile_app/screens/profile/profile_fragement.dart';
import 'package:mobile_app/utils/configs.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  int _selectedIndex = 0; // Selected index for the bottom navigation bar

  final List<Widget> _screens = [
    const MyReceiptsScreen(),
    const ContactFragement(),
    const ProfileFragement(),
  ];

  final List<BottomNavigationBarItem> _bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: const Icon(Icons.receipt),
      label: language.myReceipts,
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.contact_mail),
      label: language.contact,
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.person),
      label: language.profile,
    ),
    // const BottomNavigationBarItem(
    //   icon: Icon(Icons.contact_phone),
    //   label: 'Contact',
    // ),
  ];

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor, // Color for selected item
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Update the selected index
          });
        },
      ),
    );
  }
}
