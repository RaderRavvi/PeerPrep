import 'package:flutter/material.dart';
import 'package:peerprep2/screens/homepage/homepage.dart';
import 'package:peerprep2/screens/profile/profile_screen.dart';
import 'package:peerprep2/screens/saved_screen.dart';
import 'package:peerprep2/screens/search/search_screen.dart';
import 'package:peerprep2/screens/upload/upload_screen.dart';

class PageCore extends StatefulWidget {
  const PageCore({super.key});

  @override
  State<PageCore> createState() => _PageCoreState();
}

class _PageCoreState extends State<PageCore> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const SearchPage(),
    const UploadScreen(),
    const SavedScreen(),
    const ProfileScreen(),
    // ProfileScreen(profileId: Utils.currentUid()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.home,
              color: Colors.deepPurple,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Cerca',
            icon: Icon(
              Icons.search,
              color: Colors.deepPurple,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Aggiungi',
            icon: Icon(
              Icons.add_circle,
              color: Colors.deepPurple,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Salvati',
            icon: Icon(
              Icons.bookmark_sharp,
              color: Colors.deepPurple,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Profilo',
            icon: Icon(
              Icons.person,
              color: Colors.deepPurple,
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    ); 
  }
}